package Checking_code;

import cutomer_email_send.validation;
import database.Database_connection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.management.IntrospectionException;

class babu extends Thread {

    int pid = 0;

    public babu(int pid) {
        this.pid = pid;
    }

    @Override
    public void run() {
        String query = "select l_id,p_name from tbl_order,tbl_order_detail,tbl_product where tbl_order.o_id = tbl_order_detail.o_id and tbl_order_detail.p_id = tbl_product.p_id and tbl_order.order_status = 'pending' and tbl_order_detail.p_id =" + pid;
        try {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            Statement tmpst = cnn.createStatement();
            ResultSet rs = st.executeQuery(query);
            ResultSet tmprs;
            int lid = 0;
            String email = null;
            String user = null;
            String msg = null;
            while (rs.next()) {
                lid = rs.getInt(1);
                String p_name = rs.getString(2);
                tmprs = tmpst.executeQuery("select l_email,u_fname from tbl_login,tbl_user_detail where tbl_login.l_id = tbl_user_detail.l_id and tbl_login.l_id =" + lid);
                while (tmprs.next()) {
                    email = tmprs.getString(1);
                    user = tmprs.getString(2);
                }
                msg = "Hii " + user + "   " + p_name + "  product is out of stock  Sorry For SaiKiran Team !!  you can purchase that related Another product ";
                validation v = new validation(email, msg);
                this.sleep(10000);
            }


        } catch (SQLException ex) {
            System.out.println(ex);
        } catch (InterruptedException ex) {
            System.out.println(ex);
        } catch (Exception ex) {
            System.out.println(ex);
        }

        try 
        {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            CallableStatement cb = cnn.prepareCall("{call st_delete_product(?)}");
            cb.setInt(1, pid);
            cb.execute();

        } catch (Exception ex) {
        }

    }
}

public class thread_Example {

    public static void main(String args[]) {
        new babu(13).start();
        Thread t = babu.currentThread();
    }
}
