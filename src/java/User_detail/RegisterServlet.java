package User_detail;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.*;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import Admin.*;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        HttpSession usersession = req.getSession();
        String referer = req.getHeader("Referer"); // move To same Page 
        if (referer.endsWith("Online_Shoping_java/LoginServlet") || referer.endsWith("Online_Shoping_java/RegisterServlet")) {
        } else {
            usersession.setAttribute("back_to_page", referer);
        }

        String type = "public";
        if (req.getParameter("type") != null) {
            type = "dealer";
        }

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date date = new Date();

        RequestDispatcher rd = req.getRequestDispatcher("/message1.jsp");
        try {

            if ((req.getParameter("passReg")).equals(req.getParameter("passAgainReg"))) {

                Email_check e = new Email_check();
                if (e.check_email(req.getParameter("emailReg"))) {
                    req.setAttribute("message", "Email id is Already Registered");
                    rd.forward(req, res);
                } else {
                    int lid = 0;
                    Database_connection obj_connection = new Database_connection();
                    Connection cnn = obj_connection.cnn;
                    Statement st = cnn.createStatement();
                    Statement st1 = cnn.createStatement();


                    Algorithm_password a = new Algorithm_password();
                    String Encrypt_pass = a.Encrypt_password(req.getParameter("passReg"));
                        

                    if (req.getParameter("type") != null) {
                        
                        
                        st1.execute("insert into tbl_login values(null,'" + req.getParameter("emailReg") + "','" + Encrypt_pass + "','" + type + "')");

                        ResultSet rs = st.executeQuery("select max(l_id) from tbl_login");
                        while (rs.next()) {
                            lid = rs.getInt(1);

                        }
                        st1.execute("insert into tbl_user_detail values(null," + lid + ",'" + req.getParameter("fname") + "','" + req.getParameter("lname") + "','" + req.getParameter("gender") + "','" + req.getParameter("mobileNum") + "','" + req.getParameter("address") + "',1,1,1,'" + req.getParameter("pincode") + "','" + dateFormat.format(date) + "','" + dateFormat.format(date) + "')");
                    } else 
                    {
                        CallableStatement cb = cnn.prepareCall("{call st_new_user(?,?,?,?)}");
                        cb.setString(1,req.getParameter("emailReg"));
                        cb.setString(2,Encrypt_pass);
                        cb.setString(3, type);
                        cb.setString(4,null);
                        cb.execute();
                        //st1.execute("insert into tbl_user_detail values(null," + lid + ",null,null,null,null,null,null,null,null,null,'" + dateFormat.format(date) + "','" + dateFormat.format(date) + "')");
                    }



                    req.setAttribute("message", "Successfully Registered");
                    rd.forward(req, res);


                }
            } else {
                req.setAttribute("message", "Both Password is Not Match");
                rd.forward(req, res);
            }
        } catch (Exception ex) {
            req.setAttribute("message", ex);
            rd.forward(req, res);
        }
    }
}
