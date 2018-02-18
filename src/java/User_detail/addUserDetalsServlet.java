package User_detail;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.ws.rs.core.Response;



@WebServlet(name = "addUserDetalsServlet", urlPatterns = {"/addUserDetalsServlet"})
public class addUserDetalsServlet extends HttpServlet 
{
    @Override
    public void service(HttpServletRequest req , HttpServletResponse res) throws ServletException, IOException
    {
        HttpSession usersession = req.getSession();
        RequestDispatcher rd = req.getRequestDispatcher("/cust_message.jsp");
        try
        {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            String query = "update tbl_user_detail set u_fname = ?,u_lname = ?,u_gender=?,u_contact=?,u_add= ?,u_city = ?,u_state= ?,u_country = ?,u_pincode = ? where l_id ="+usersession.getAttribute("user");
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1,req.getParameter("fname"));
            ps.setString(2,req.getParameter("lname"));
            
            ps.setString(3,req.getParameter("gender"));
            ps.setString(4,req.getParameter("mobileNum"));
            
            ps.setString(5,req.getParameter("address"));
            ps.setInt(6,1);
            ps.setInt(7,1);
            ps.setInt(8,1);
            ps.setInt(9,Integer.parseInt(req.getParameter("pincode")));
            
            
            ps.execute();
            ps.close();
          //  req.setAttribute("message","Success Fully The Change Detail");
          //  rd.forward(req, res);
            res.sendRedirect(req.getContextPath()+"/User_info.jsp");
        }
        catch(Exception ex)
        {
             req.setAttribute("message",ex);
             rd.forward(req, res);
        }
    }
}
