package User_detail;

import database.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Email_check {

    public Connection cnn;

    public Email_check() {
        try {
            Database_connection obj_connection = new Database_connection();
            cnn = obj_connection.cnn;
        } catch (Exception ex) {
        }
    }

    public boolean check_email(String email_id) {
        boolean b = false;
        try {
            Statement st = cnn.createStatement();
            ResultSet rs = st.executeQuery("select * from tbl_login where l_email = '" + email_id + "'");
            while (rs.next()) {
                b = true;
            }
        }
         catch (Exception ex) {
        }
        return b;
    }
}
