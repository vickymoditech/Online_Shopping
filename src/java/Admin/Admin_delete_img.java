/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Admin;

import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "Admin_delete_img", urlPatterns = {"/Admin_delete_img"})
public class Admin_delete_img extends HttpServlet 
{
    @Override
    public void service(HttpServletRequest req,HttpServletResponse res) throws IOException
    {
        PrintWriter out = res.getWriter();
        try
        {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            out.println(req.getParameter("pid"));
            out.println(req.getParameter("imgid"));
            st.execute("delete from tbl_display_img where p_id = "+req.getParameter("pid")+" and d_img_id="+req.getParameter("imgid"));
            RequestDispatcher rd = req.getRequestDispatcher("Admin_image_upload.jsp");
            req.setAttribute("p_id",req.getParameter("pid"));
            rd.forward(req, res);
        }
        catch(Exception ex)
        {
            out.println(ex);
        }
    }
}
