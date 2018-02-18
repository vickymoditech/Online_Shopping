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
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.general.*;
import org.jfree.data.*;
import org.jfree.data.category.DefaultCategoryDataset;

public class Year_wise_sold_report extends Thread {

    ServletContext c;

    public Year_wise_sold_report(ServletContext c) {
        this.c = c;
    }

    @Override
    public void run() {


        try {

            int year = 2016;

            final String speed = "Year";

            final DefaultCategoryDataset dataset = new DefaultCategoryDataset();


            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            //      String query = "select sum(user_qty) from tbl_order_detail,tbl_sub_cat,tbl_category,tbl_product,tbl_order where tbl_order_detail.p_id = tbl_product.p_id and  tbl_order_detail.o_id = tbl_order.o_id and tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_order.order_date between '2017-01-01' and '2017-12-31'";

            final DefaultPieDataset data = new DefaultPieDataset();


            for (int i = 0; i < 12; i++) {
                String query = "select count(l_id) from tbl_user_detail where u_join_date between '" + year + "-01-01' and '" + year + "-12-31'";
                Statement st1 = cnn.createStatement();
                ResultSet rs1 = st1.executeQuery(query);
                while (rs1.next()) {

                    int total_user = rs1.getInt(1);
                    if (total_user > 0) {

                        dataset.addValue(new Integer(rs1.getInt(1)), String.valueOf(year), speed);
                    }
                    //        out.println(rs1.getInt(1));
                }
                year++;
            }


            JFreeChart barChart = ChartFactory.createBarChart(
                    "Year wise User report",
                    "Year", "Number of Users",
                    dataset, PlotOrientation.VERTICAL,
                    true, true, false);


            try {
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(c.getRealPath(".") + "/images/productImages/yearwiseuser.png");
                ChartUtilities.saveChartAsPNG(file1, barChart, 700, 450, info);
            } catch (Exception e) {
                System.out.println(e);
            }

        } catch (Exception ex) {
            System.out.println(ex);
        }

    }
}
