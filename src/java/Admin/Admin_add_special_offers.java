package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.*;
import java.sql.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Random;
import java.util.Set;

@WebServlet(name = "Admin_add_special_offers", urlPatterns = {"/Admin_add_special_offers"})
public class Admin_add_special_offers extends HttpServlet {

    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        PrintWriter out = res.getWriter();
        try {
            String[] name = req.getParameterValues("user");
            int total = Integer.parseInt(req.getParameter("total"));
            int limit = Integer.parseInt(req.getParameter("limit"));
            int pid = Integer.parseInt(req.getParameter("pid"));
            //  out.println(name.length);
            //  out.println(total);
            //  out.println(limit);
            //  out.println(pid);
            int[] lid = new int[total];
            int[] count = new int[total];
            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            Statement st1 = cnn.createStatement();
            ResultSet rs = st.executeQuery("select l_id from tbl_login");
            int i = 0;
            while (rs.next()) {
                int l_id = rs.getInt(1);
                ResultSet rs1 = st1.executeQuery("select count(*) from tbl_order where l_id = " + l_id);
                while (rs1.next()) {
                    lid[i] = l_id;
                    count[i] = rs1.getInt(1);
                }
                i++;
            }

            for (int j = 0; j < total; j++) {
                for (int k = 0; k < total; k++) {
                    if (count[j] > count[k]) {
                        int ctmp = count[j];
                        int ltmp = lid[j];
                        count[j] = count[k];
                        lid[j] = lid[k];
                        count[k] = ctmp;
                        lid[k] = ltmp;
                    }
                }
            }

            for (String s : name) {

                if (s.equals("hl")) {

                    for (int j = 0; j < limit; j++) {
                        new Admin_special_user_thread(lid[j], pid).start();
                        //          out.println(lid[j]);
                    }

                } else if (s.equals("lh")) {
                    int tmp = 0;
                    for (int j = total - 1; j >= 0; j--) {
                        if (tmp == limit) {
                            break;
                        }
                        new Admin_special_user_thread(lid[j], pid).start();
                        //       out.println(lid[j]);
                        tmp++;
                    }

                } else {
                    Random r = new Random();
                    int Low = 0;
                    int High = total - 1;

                    HashMap<Integer, Integer> hm = new HashMap<Integer, Integer>();

                    while (hm.size() <= limit) {
                        int Result = r.nextInt(High - Low) + Low;
                        hm.put(new Integer(Result), new Integer(Result));
                    }

                    for (int k : hm.keySet()) {
                        new Admin_special_user_thread(lid[k], pid).start();
                    }

                }

            }


            res.sendRedirect(req.getContextPath() + "/Admin_dash_bord.jsp");

        } catch (Exception ex) {
            RequestDispatcher rd = req.getRequestDispatcher("Admin_manage_special.jsp");
            req.setAttribute("msg", "Select first Any one user");
            rd.forward(req, res);
        }
    }
}
