package Admin;

import database.*;
import java.io.File;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.*;
import java.util.Enumeration;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import org.jfree.chart.*;
import org.jfree.chart.entity.*;
import org.jfree.data.general.*;
import org.jfree.data.*;

public class top_10_thread extends Thread {

    ServletContext c;

    public top_10_thread(ServletContext c) {

        this.c = c;
    }

    public void run() {

        int[] pid;
        int[] user_qty;


        try {

            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();

            int total = 0;
            ResultSet rs = st.executeQuery("select count(distinct p_id) from tbl_order_detail");
            while (rs.next()) {
                total = rs.getInt(1);
            }

            pid = new int[total];
            user_qty = new int[total];

            int index = 0;

            rs = st.executeQuery("select distinct p_id from tbl_order_detail");
            while (rs.next()) {
                int p_id = rs.getInt(1);
                Statement st1 = cnn.createStatement();
                ResultSet rs1 = st1.executeQuery("select sum(user_qty) from tbl_order_detail where p_id = " + p_id);
                while (rs1.next()) {
                    pid[index] = p_id;
                    user_qty[index] = rs1.getInt(1);
                }
                index++;
            }


            // shorting program 

            for (int i = 0; i < user_qty.length; i++) {
                for (int j = 0; j < user_qty.length; j++) {
                    if (user_qty[i] > user_qty[j]) {
                        int tmp = pid[i];
                        int tmp1 = user_qty[i];

                        pid[i] = pid[j];
                        user_qty[i] = user_qty[j];

                        pid[j] = tmp;
                        user_qty[j] = tmp1;
                    }
                }
            }

            if (total >= 10) {
                total = 10;
            } else {
                total = pid.length;
            }


            final DefaultPieDataset data = new DefaultPieDataset();
            // you can change pid length into 10  top 10 product will be display 

            for (int i = 0; i < total; i++) {

                rs = st.executeQuery("select p_name from tbl_product where p_id = " + pid[i]);
                while (rs.next()) {
                    data.setValue(rs.getString(1), new Double(user_qty[i]));
                }
            }


            JFreeChart chart = ChartFactory.createPieChart3D(" Top 10 Sold Product ", data, true, true, false);

            try {
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(c.getRealPath(".") + "/images/productImages/piechart.png");
                ChartUtilities.saveChartAsPNG(file1, chart, 700, 450, info);
            } catch (Exception e) {
            }

        } catch (Exception ex) {
        }


    }
}
