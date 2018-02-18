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

@WebServlet(name = "Code_check", urlPatterns = {"/Code_check"})
public class Code_check extends HttpServlet
{
    @Override
    public void service(HttpServletRequest req , HttpServletResponse res) throws IOException,ServletException
    {
        try
        {
        PrintWriter out = res.getWriter();
        HttpSession usersession = req.getSession();
        String code = usersession.getAttribute("Code").toString();
        String user_code = req.getParameter("code").toString();
        if(code.equals(user_code))
        {
            usersession.setAttribute("check","true");
            res.sendRedirect(req.getContextPath()+"/Forgot_email_index_2.jsp");
        }
        else
        {
            RequestDispatcher rd = req.getRequestDispatcher("/message.jsp");
            req.setAttribute("message","InValid Code");
            rd.forward(req, res);
        }
        }catch(Exception ex)
        {
            res.sendRedirect(req.getContextPath()+"/Forgot_email_index.jsp");
        }
    }
}