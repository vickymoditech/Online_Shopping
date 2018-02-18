package Order_Cancle;

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
import cutomer_email_send.*;
        
@WebServlet(name = "Cancle_order", urlPatterns = {"/Cancle_order"})
public class Cancle_order extends HttpServlet {

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {

        if (req.getParameter("oid") != null) {

            PrintWriter out = res.getWriter();
            try {
                int oid = Integer.parseInt(req.getParameter("oid"));
                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                Statement st = cnn.createStatement();
                CallableStatement cs = cnn.prepareCall("{call st_cancle_order1(?,?)}");
                ResultSet rs = st.executeQuery("select p_id from tbl_order_detail where o_id = " + oid);
                while (rs.next()) {
                    cs.setInt(1, oid);
                    cs.setInt(2, rs.getInt(1));
                    cs.execute();
                }
                rs = st.executeQuery("select l_email,u_fname from tbl_login,tbl_order,tbl_user_detail where tbl_login.l_id = tbl_order.l_id and tbl_order.l_id = tbl_user_detail.l_id and tbl_order.o_id ="+oid);
                String email = null;
                String fname = null;
                while(rs.next())
                {
                    email = rs.getString(1);
                    fname = rs.getString(2);
                }
                st.execute("delete from tbl_order where o_id =" + oid);
                String msg = "Hi "+fname+" Your Order "+oid+" Successfully Cancle Thnx For Visit Our Saikiran BookStore";
                
                validation v = new validation(email,msg);
                
                RequestDispatcher rd = req.getRequestDispatcher("message1.jsp");
                req.setAttribute("message","Order Successfully Cancle");
                rd.forward(req, res);
                
            } catch (Exception ex) {
                out.println(ex);
            }
        } else 
        {
            res.sendRedirect(req.getContextPath()+"/index.jsp");
        }
    }
}
