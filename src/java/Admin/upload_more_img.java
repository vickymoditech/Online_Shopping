/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Admin;

import database.Database_connection;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Vicky
 */
@WebServlet(name = "upload_more_img", urlPatterns = {"/upload_more_img"})
public class upload_more_img extends HttpServlet 
{
        private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                String fname = null;
                String fsize = null;
                String ftype = null;
                List<FileItem> multiparts = new ServletFileUpload(
                        new DiskFileItemFactory()).parseRequest(request);
                for (FileItem item : multiparts) {
                    if (!item.isFormField()) {
                        fname = new File(item.getName()).getName();
                        fsize = new Long(item.getSize()).toString();
                        ftype = item.getContentType();
                        String path = getServletContext().getRealPath("") + File.separator + "images/productImages" + File.separator;
                        out.println(path);
                        String tmp = path.replace('\\', '/');
                        out.println(tmp);
                        item.write(new File(tmp + fname));
                    }
                }
                //p_img='images/productImages/"+fname+"'
                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                Statement st = cnn.createStatement();
                st.execute("insert into tbl_display_img values(null,"+ request.getParameter("pid") +",'images/productImages/"+fname+"')");
            } catch (Exception ex) {
                request.setAttribute("message", "File Upload Failed due to " + ex);
            }

        } else {
            request.setAttribute("message",
                    "Sorry this Servlet only handles file upload request");
        }

        request.setAttribute("msg1", "successfully Image Upload");
        request.setAttribute("p_id",request.getParameter("pid"));
        request.getRequestDispatcher("/Admin_image_upload.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //       processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
