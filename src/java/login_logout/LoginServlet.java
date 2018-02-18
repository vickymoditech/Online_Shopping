package login_logout;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.*;
import java.rmi.ServerException;
import java.sql.SQLException;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.security.auth.message.callback.PrivateKeyCallback;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import Add_To_Cart.*;
import java.util.HashMap;
import javax.servlet.http.Cookie;
import javax.ws.rs.core.Response;
import Admin.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

        HttpSession usersession = req.getSession();
        String referer = req.getHeader("Referer"); // move To same Page 
        if (referer.endsWith("LoginServlet") || referer.endsWith("RegisterServlet")) {
        } else {

            if (referer.endsWith("RegisterServlet?type=dealer")) {
                usersession.setAttribute("back_to_page", "index.jsp");
            } else {
                usersession.setAttribute("back_to_page", referer);
            }
        }

        RequestDispatcher rd = req.getRequestDispatcher("/message1.jsp");
        PrintWriter out = res.getWriter();
        String email = req.getParameter("email");
        String pass = req.getParameter("pass");
        boolean login_check = true;                                                                                        
        int lid = 0;
        String type = "";
        try {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            Algorithm_password a = new Algorithm_password();
            String Encrypt_pass = a.Encrypt_password(pass);
            
            ResultSet rs = st.executeQuery("select * from tbl_login where l_email='" + email + "' and l_pass='" + Encrypt_pass + "'");
            while (rs.next()) {
                lid = rs.getInt(1);
                type = rs.getString(4);
                Cookie c1 = new Cookie("lid", String.valueOf(lid));
                Cookie c = new Cookie("type", type);
                c1.setMaxAge(60 * 60 * 24);
                c.setMaxAge(60 * 60 * 24);
                res.addCookie(c1);
                res.addCookie(c);

                HashMap<Integer, Cart> hm = new HashMap<Integer, Cart>();
                if (type.equals("public")) {
                    usersession.setAttribute("user", lid);
                    usersession.setAttribute("Cart", hm);
                } else if (type.equals("dealer")) {
                    usersession.setAttribute("user", lid);
                    usersession.setAttribute("dealer", lid);
                    usersession.setAttribute("Cart", hm);
                } else {
                    usersession.setAttribute("user", lid);
                    usersession.setAttribute("admin", lid);
                    usersession.setAttribute("Cart", hm);
                    new top_10_thread(getServletContext()).start();
                    new month_report_thread(getServletContext()).start();
                    new Year_wise_sold_report(getServletContext()).start();
                    new Year_wise_user_report(getServletContext()).start();
                }
                login_check = false;
            }

        } catch (Exception ex) {
            req.setAttribute("message", "vicky-1 " + ex);

            rd.forward(req, res);
        }
        if (login_check) {
            req.setAttribute("message", "Invalid User and password");
            rd.forward(req, res);
        } else {
            try {
                DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                java.util.Date date = new java.util.Date();
                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                Statement st = cnn.createStatement();
                st.execute("update tbl_user_detail set u_laste_date ='" + dateFormat.format(date) + "' where l_id = " + lid);
            } catch (Exception ex) {
                req.setAttribute("message", "vicky-2 " + ex);
                rd.forward(req, res);
            }
            res.sendRedirect(usersession.getAttribute("back_to_page").toString());
        }
    }
}