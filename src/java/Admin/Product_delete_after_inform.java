package Admin;

import java.sql.*;
import database.*;
import cutomer_email_send.*;
import java.util.ArrayList;
import java.util.Iterator;
//import javassist.bytecode.Descriptor;

public class Product_delete_after_inform extends Thread {

    int pid = 0;

    public Product_delete_after_inform(int pid) {
        this.pid = pid;
    }

    @Override
    public void run() {
        String query = "select l_id,p_name,tbl_order.o_id from tbl_order,tbl_order_detail,tbl_product where tbl_order.o_id = tbl_order_detail.o_id and tbl_order_detail.p_id = tbl_product.p_id and tbl_order.order_status = 'pending' and tbl_order_detail.p_id =" + pid;
        String query1 = "select l_id,p_name,tbl_order.o_id from tbl_order,tbl_order_detail,tbl_product where tbl_order.o_id = tbl_order_detail.o_id and tbl_order_detail.p_id = tbl_product.p_id and tbl_order.order_status = 'approve' and tbl_order_detail.p_id =" + pid;
        try {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            Statement tmpst = cnn.createStatement();
            ResultSet rs = st.executeQuery(query);
            ResultSet tmprs;
            ArrayList<Integer> lid = new ArrayList<Integer>();
            ArrayList<Integer> oid = new ArrayList<Integer>();
            String p_name = null;
            String email = null;
            String user = null;
            String msg = null;
            while (rs.next()) {                  // Pendding Order All Data Store in ArrayList 
                lid.add(rs.getInt(1));
                p_name = rs.getString(2);
                oid.add(rs.getInt(3));
            }
            rs = st.executeQuery(query1);
            while (rs.next()) // Approved Order All Data Store in ArrayList
            {
                p_name = rs.getString(2);
                lid.add(rs.getInt(1));
                oid.add(rs.getInt(3));
            }

            delete_product();       
            // Array List(o_id) Send To delete All Data But Deliver Order Data Can't Be Delete 
            check_bill_item(oid);

            Iterator i = lid.iterator();
            while (i.hasNext()) {
                tmprs = tmpst.executeQuery("select l_email,u_fname from tbl_login,tbl_user_detail where tbl_login.l_id = tbl_user_detail.l_id and tbl_login.l_id =" + i.next());
                while (tmprs.next()) {
                    email = tmprs.getString(1);
                    user = tmprs.getString(2);
                }
                msg = "Hii " + user + " <font color='red'> " + p_name + " </font> product is <font color='red'> out of stock </font> Sorry For SaiKiran Team !!  you can purchase that related Another product ";
         //       validation v = new validation(email, msg);
        //        this.sleep(1000);
            }



        } catch (SQLException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public void delete_product() {

            try {
                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                CallableStatement cb = cnn.prepareCall("{call st_delete_product(?)}");
                cb.setInt(1, pid);
                cb.execute();

            } catch (Exception ex)
            {
                System.out.println(ex);
            }
    }

   
    
    public void check_bill_item(ArrayList<Integer> oid) {
        try {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            Statement tmpst = cnn.createStatement();
            int tmp_oid = 0;
            Iterator i = oid.iterator();
            while (i.hasNext()) {
                tmp_oid = (Integer) i.next();
                ResultSet rs = st.executeQuery("select sum(user_qty) from tbl_order_detail,tbl_order where tbl_order.o_id = tbl_order_detail.o_id and tbl_order.o_id = " + tmp_oid);
                while (rs.next()) {
                    if (rs.getInt(1) == 0) {
                        tmpst.execute("delete from tbl_order where o_id = " + tmp_oid);
                    }
                }
            }
        } catch (Exception ex) {
        }
    }
}
