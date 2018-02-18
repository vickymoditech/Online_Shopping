package Admin;

import cutomer_email_send.validation;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.*;
import java.sql.*;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author Vicky
 */
@WebServlet(name = "Admin_add", urlPatterns = {"/Admin_add"})
public class Admin_add extends HttpServlet {

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        PrintWriter out = res.getWriter();  
        try {
            RequestDispatcher rd = req.getRequestDispatcher("Admin_new_add.jsp");
            String email_id = req.getParameter("email");
            String name = req.getParameter("fname");
            Random r = new Random();
            int Low = 65;
            int High = 90;
            String password = "";

            for (int i = 0; i < 10; i++) {
                int Result = r.nextInt(High - Low) + Low;
                password += (char) Result;
            }
            
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            ResultSet rs = st.executeQuery("select * from tbl_login where l_email ='"+ email_id+"'");
            boolean check = false;
            while(rs.next())
            {
                check = true;
            }
            
            if(check)
            {
                req.setAttribute("msg","Email is already registered");
                rd.forward(req, res);
            }
            else
            {
                Algorithm_password a = new Algorithm_password();
                String new_pass = a.Encrypt_password(password);
                
                CallableStatement cb = cnn.prepareCall("{ call st_new_user(?,?,?,?)}");
                cb.setString(1,email_id);
                cb.setString(2,new_pass);
                cb.setString(3,"private");
                cb.setString(4, name);
                cb.execute();
                validation v = new validation(email_id,"hiii "+ email_id +" your password "+ password);
                req.setAttribute("msg","Password successfully send Check your mail");
                rd.forward(req, res);
            }
            
        } catch (Exception ex)
        {
            out.println(ex);
        }
    }
}
