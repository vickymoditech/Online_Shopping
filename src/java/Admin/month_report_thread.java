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


public class month_report_thread extends Thread {

    ServletContext c;

    public month_report_thread(ServletContext c) {

        this.c = c;
    }
    
    
    @Override
    public void run() {



        try {

            String month = "";
            String year = "";

            final String speed = "Category";

            final DefaultCategoryDataset dataset = new DefaultCategoryDataset();


            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();
            String query = "select sum(user_qty) from tbl_order_detail,tbl_sub_cat,tbl_category,tbl_product,tbl_order where tbl_order_detail.p_id = tbl_product.p_id and  tbl_order_detail.o_id = tbl_order.o_id and tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_category.c_id = ";

            final DefaultPieDataset data = new DefaultPieDataset();


            ResultSet rs = st.executeQuery("select c_id,c_name from tbl_category");
            while (rs.next()) {
                Statement st1 = cnn.createStatement();
                ResultSet rs1 = st1.executeQuery(query + rs.getInt(1));
                String c_name = rs.getString(2);
                while (rs1.next()) {
                    dataset.addValue(rs1.getInt(1), c_name, speed);
                    //         out.println(rs1.getInt(1));
                }
            }


            JFreeChart barChart = ChartFactory.createBarChart(
                    "Top Category wise Sold Product",
                    "Category", "Number of Product Sold",
                    dataset, PlotOrientation.VERTICAL,
                    true, true, false);

            try {
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(c.getRealPath(".") + "/images/productImages/category" + month + year + ".png");
                ChartUtilities.saveChartAsPNG(file1, barChart, 700, 450, info);
            } catch (Exception e) {
                
            }

        } catch (Exception ex) {
            
        }

    }
}
