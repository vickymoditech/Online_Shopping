package Admin;
import cutomer_email_send.validation;
import database.*;
import java.sql.*;

public class Admin_special_user_thread extends Thread 
{

    
    int lid;
    int pid;
    
    public Admin_special_user_thread(int lid,int pid) 
    {
        this.lid = lid;
        this.pid = pid;
    }
    
    
    
    @Override
    public void run()
    {
        try
        {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            st.execute("insert into tbl_special_product values(null,"+pid+","+lid+")");
            String email = null;
            String msg = null;
            String user = null;
            String p_name = null;
            ResultSet rs = st.executeQuery("select l_email,u_fname from tbl_login,tbl_user_detail where tbl_login.l_id = tbl_user_detail.l_id and tbl_login.l_id ="+lid);
            while(rs.next())
            {
                email = rs.getString(1);
                user = rs.getString(2);
            }
            Statement st1 = cnn.createStatement();
            ResultSet rs1 = st1.executeQuery("select p_name from tbl_product where p_id = "+pid);
            while(rs1.next())
            {
                p_name = rs1.getString(1);
            }
            //50% off all leather laptop bags at www.abcbags.com for the next 48 hours only.
            if(user==null)
            {
                user = email;
            }
            
            msg = "Hii " + user + " Special Offer for you only  <font color='red'> " + p_name + " </font>   at www.saikiran.com for the  <font color='red'> next 48 hours only. </font> Checkout";
            validation v = new validation(email, msg);
            
        }
        catch(Exception ex)
        {
            
        }
    }
    
}
