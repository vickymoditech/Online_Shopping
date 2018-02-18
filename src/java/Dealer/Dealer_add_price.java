package Dealer;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.*;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Vicky
 */
@WebServlet(name = "Dealer_add_price", urlPatterns = {"/Dealer_add_price"})
public class Dealer_add_price extends HttpServlet 
{
    @Override
    public void service(HttpServletRequest req,HttpServletResponse res) throws IOException
    {
        PrintWriter out = res.getWriter();
        HttpSession usersession = req.getSession();
        try
        {
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            Statement st1 = cnn.createStatement();
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
            java.util.Date date = new java.util.Date();
            boolean b = false;
            ResultSet rs = st.executeQuery("select * from tbl_dealer where l_id = "+usersession.getAttribute("dealer")+" and p_id = "+req.getParameter("pid"));
            while(rs.next())
            {
                b = true;
            }
            
            if(b)
            {
                st.execute("delete from tbl_dealer where l_id ="+ usersession.getAttribute("dealer") +" and p_id ="+req.getParameter("pid"));
            }
            
            
            st1.execute("insert into tbl_dealer values(null,"+ usersession.getAttribute("dealer") +","+ req.getParameter("pid") +","+req.getParameter("d_price") +",'"+dateFormat.format(date)+"')");
      
            
            String referer = req.getHeader("Referer");
            res.sendRedirect(referer);
            
        }
        catch(Exception ex)
        {
            out.println(ex.toString());
        }
    }
}
