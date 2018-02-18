package Forgot_pass;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import database.*;
import Admin.*;

@WebServlet(name = "Reset_pass", urlPatterns = {"/Reset_pass"})
public class Reset_pass extends HttpServlet {

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            String pass = req.getParameter("pass");
            String cpass = req.getParameter("cpass");
            HttpSession usersession = req.getSession();
            String tmp_email = usersession.getAttribute("Tmp_Email").toString();
            RequestDispatcher rd = req.getRequestDispatcher("/message.jsp");
            RequestDispatcher rd1 = req.getRequestDispatcher("/message1.jsp");
            if(usersession.getAttribute("check")!=null)
            {
            if (pass.equals(cpass)) {

                try {
                    
                    Algorithm_password a = new Algorithm_password();
                    String new_pass = a.Encrypt_password(pass);
                    
                    Database_connection obj_connection = new Database_connection();   // change the password
                    Connection cnn = obj_connection.cnn;
                    Statement st = cnn.createStatement();
                    st.execute("update tbl_login set l_pass='"+new_pass+"' where l_email='"+tmp_email+"'");
                    
                    usersession.invalidate();    // session invalid set 
                    req.setAttribute("message", "password successfully changed");
                    rd1.forward(req, res);
                } catch (Exception ex) {
                    req.setAttribute("message", ex);   // database related problem display
                    rd.forward(req, res);
                }
            } else {
                req.setAttribute("message", "Both Password is Not Match");
                rd.forward(req, res);
            }
        }else
            {
                res.sendRedirect(req.getContextPath()+"/index.jsp");
            }
        } catch (Exception ex) {
            res.sendRedirect(req.getContextPath() + "/Forgot_email_index.jsp");
        }
    }
}