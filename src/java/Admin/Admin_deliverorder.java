package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Vicky
 */
@WebServlet(name = "Admin_deliverorder", urlPatterns = {"/Admin_deliverorder"})
public class Admin_deliverorder extends HttpServlet 
{
     @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {

        HttpSession usersession = req.getSession();
        if (usersession.getAttribute("admin") == null) {
            res.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {

            PrintWriter out = res.getWriter();
            try 
            {
                String[] all_oid = req.getParameterValues("check");
                for (String s : all_oid) {
                    int o_id = Integer.parseInt(s);
                    new Admin_status_change(o_id,"deliver").start();
                }


            } catch (Exception ex) {
                out.println(ex);
            }
            finally
            {
                String referer = req.getHeader("Referer");
                res.sendRedirect(referer);
            }
        }
    }
    
}

