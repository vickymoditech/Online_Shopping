package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import database.*;
import javax.servlet.RequestDispatcher;

@WebServlet(name = "Admin_changeProductInfo", urlPatterns = {"/Admin_changeProductInfo"})
public class Admin_changeProductInfo extends HttpServlet {

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        PrintWriter out = res.getWriter();
        try {
            int pid = Integer.parseInt(req.getParameter("pid"));
            if (req.getParameter("pid") == null) {
                res.sendRedirect(req.getContextPath() + "/index.jsp");
            } else {
                
                String p_name = req.getParameter("p_name");
                int qty = Integer.parseInt(req.getParameter("add_qty"));
                int price = Integer.parseInt(req.getParameter("p_price"));
                String desc = req.getParameter("p_desc");
                String p_type = req.getParameter("p_type");
                String p_company = req.getParameter("p_company");
                int p_old = 0;
                if(p_type.equals("special"))
                {
                    p_old = Integer.parseInt(req.getParameter("p_old"));
                }
                
                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                CallableStatement cb = cnn.prepareCall("{call st_change_product_info(?,?,?,?,?,?,?,?)}");
                cb.setInt(1,pid);
                cb.setString(2,p_name);
                cb.setString(3,desc);
                cb.setInt(4,price);
                cb.setInt(5,qty);
                cb.setString(6,p_company);
                cb.setString(7, p_type);
                cb.setInt(8,p_old);
                cb.execute();
                
                String referer = req.getHeader("Referer"); 
                res.sendRedirect(referer);
            }
        } catch (Exception ex)
        {
            out.println(ex);
        }
    }
}
