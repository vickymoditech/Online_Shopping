<%-- 
    Document   : top10_sold_product
    Created on : Apr 9, 2016, 6:15:44 PM
    Author     : Vicky
--%>

<%@page import="org.jfree.data.time.Year"%>
<%@page import="org.jfree.chart.plot.PlotOrientation"%>
<%@page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import="database.*"%>
<%@ page  import="java.sql.*" %>
<%@ page import="Admin.*"%>

<%

    if (session.getAttribute("admin") == null) {// THen new user, show join now

        response.sendRedirect(request.getContextPath() + "/index.jsp");

    }



    if (request.getParameter("ref") != null) {
        new top_10_thread(getServletContext()).start();
        new month_report_thread(getServletContext()).start();   
    }

    String q1 = "";
    String month = "";
    String year = "";

    if (request.getParameter("month") != null && request.getParameter("year") != null) {

        month = request.getParameter("month");
        year = request.getParameter("year");
        q1 = " and tbl_order.order_date between '" + year + "-" + month + "-01' and '" + year + "-" + month + "-31'";


        //else {


        //    new top_10_thread(getServletContext()).start(); thread of top -10 product






        /*  int[] pid;
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
         final File file1 = new File(getServletContext().getRealPath(".") + "/images/productImages/piechart.png");
         ChartUtilities.saveChartAsPNG(file1, chart, 700, 450, info);
         } catch (Exception e) {
         out.println(e);
         }

         } catch (Exception ex) {
         out.println(ex);
         }

         */
        //  new PieChart_top_product(getServletContext()).start();

        // }

        // secoond category wise bar chart 



        try {


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
                ResultSet rs1 = st1.executeQuery(query + rs.getInt(1) + q1);
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
                final File file1 = new File(getServletContext().getRealPath(".") + "/images/productImages/category" + month + year + ".png");
                ChartUtilities.saveChartAsPNG(file1, barChart, 700, 450, info);
            } catch (Exception e) {
                out.println(e);
            }

        } catch (Exception ex) {
            out.println(ex);
        }
    }

%>


<div class="grid_13" id="productStrip"> 

    <div class="ProductHeading">
        <div class="grid_12">
            <h2 class="heading"><center>Admin Dash Bord</center></h2>

            <select id="sortBy1" style="margin:  +2px" data-parsley-required="true" >
                <option value="">select Any Month</option>
                <option value="01"> January </option>
                <option value="02"> February </option>
                <option value="03"> March </option>
                <option value="04"> April </option>
                <option value="05"> May </option>
                <option value="06"> June </option>
                <option value="07"> July </option>
                <option value="08"> August </option>
                <option value="09"> September </option>
                <option value="10"> Octomber </option>
                <option value="11"> November </option>
                <option value="12"> December </option>
            </select>

            <select id="sortBy2" style="margin:  +2px" data-parsley-required="true"  onchange="babu1(this.value,document.getElementById('sortBy1').value)">
                <option value="">select Any Year</option>
                <option value="2016"> 2016 </option>
                <option value="2017"> 2017 </option>
                <option value="2018"> 2018 </option>
                <option value="2019"> 2019 </option>
                <option value="2020"> 2020 </option>
                <option value="2021"> 2021 </option>
                <option value="2022"> 2022 </option>
                <option value="2023"> 2023 </option>
            </select>


            <a href="#"  data-parsley-required="true" onclick="return refresh()" class="greenBtn"> <strong> Refresh </strong> </a>

        </div>
    </div>


    <div class="clear"></div>

    <div id="productList" class="grid_3 prodGrid"> 


        <IMG SRC="<%= "images/productImages/category" + month + year + ".png"%>" WIDTH="700" HEIGHT="450" BORDER="0" USEMAP="#chart">


        <div class="grid_12"  style="border-top: 6px #444 solid;">
        </div>



        <IMG SRC="images/productImages/piechart.png" WIDTH="700" HEIGHT="450" BORDER="0" USEMAP="#chart">


    </div>



</div>