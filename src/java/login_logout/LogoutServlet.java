package login_logout;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet
{
    @Override
    public void service(HttpServletRequest req,HttpServletResponse res) throws IOException
    {
        HttpSession usersession = req.getSession();
        usersession.invalidate();
        Cookie [] c = req.getCookies();
        for(Cookie tmp:c)
        {
            if(tmp.getName().equals("lid"))
            {
                tmp.setMaxAge(0);
                res.addCookie(tmp);
            }
            if(tmp.getName().equals("type"))
            {
                tmp.setMaxAge(0);
                res.addCookie(tmp);
            }
        }
        res.sendRedirect(req.getContextPath()+"/index.jsp");
    }
}
