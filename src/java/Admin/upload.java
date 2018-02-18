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
import java.sql.Statement;

/**
 *
 * @author Vicky
 */
@WebServlet(name = "upload", urlPatterns = {"/upload"})
public class upload extends HttpServlet {
    
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
                
                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                Statement st = cnn.createStatement();
                st.execute("update tbl_product set p_img='images/productImages/" + fname + "' where p_id = " + request.getParameter("pid"));
                request.setAttribute("p_id", request.getParameter("pid"));
                request.setAttribute("msg", "successfully Image Upload");
                
            } catch (Exception ex) {
                request.setAttribute("message", "File Upload Failed due to " + ex);
            }
            
        } else {
            request.setAttribute("message",
                    "Sorry this Servlet only handles file upload request");
        }
        
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
