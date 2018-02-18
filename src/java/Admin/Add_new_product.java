package Admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import database.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author Vicky
 */
@WebServlet(name = "Add_new_product", urlPatterns = {"/Add_new_product"})
public class Add_new_product extends HttpServlet {

    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
        PrintWriter out = res.getWriter();


        try {

            int sub_id = Integer.parseInt(req.getParameter("sub_category"));
            String p_name = (req.getParameter("p_name"));
            int p_qty = Integer.parseInt(req.getParameter("p_qty"));
            String p_desc = (req.getParameter("p_desc"));
            int p_price = Integer.parseInt(req.getParameter("p_price"));
            String p_company = (req.getParameter("p_company"));
            String p_type = (req.getParameter("p_type"));

            /*            out.println("sub id"+sub_id);
             out.println("p name"+p_name);
             out.println("p qty"+p_qty);
             out.println("p_desc"+p_desc);
             out.println("p company"+p_company);
             out.println("p type"+p_type);
             out.println("old price"+req.getParameter("p_old"));
             out.println("price"+p_price); */


            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();

            if (req.getParameter("p_type").equals("special")) {
                int old = Integer.parseInt(req.getParameter("p_old"));
                //           st.execute("insert into tbl_product values(null," + sub_id + ",'" + p_name + "','" + p_desc + "'," + p_price + "," + p_qty + ",null,'" + p_company + "','" + p_type + "'," + old + ")");
                st.execute("insert into tbl_product values(null," + sub_id + ",'" + p_name + "','" + p_desc + "'," + p_price + "," + p_qty + ",null,'" + p_company + "','" + p_type + "'," + old + ",'true')");
            } else {
                //           st.execute("insert into tbl_product values(null,"+ sub_id +",'"+ p_name +"','"+ p_desc +"',"+ p_price +","+ p_qty +",null,'"+ p_company +"','normal',null)");
                st.execute("insert into tbl_product values(null," + sub_id + ",'" + p_name + "','" + p_desc + "'," + p_price + "," + p_qty + ",null,'" + p_company + "','normal',null,'true')");
            }

            int p_id = 0;
            Statement st1 = cnn.createStatement();
            ResultSet rs = st1.executeQuery("select max(p_id) from tbl_product");
            while (rs.next()) {
                p_id = rs.getInt(1);
            }

            RequestDispatcher rd = req.getRequestDispatcher("Admin_image_upload.jsp");
            req.setAttribute("p_id", p_id);
            rd.forward(req, res);



        } catch (Exception ex) {
            out.println(ex);
        }
    }
}
