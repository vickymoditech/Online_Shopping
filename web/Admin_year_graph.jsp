<%-- 
    Document   : Admin_year_graph
    Created on : Apr 13, 2016, 1:03:07 PM
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
<%@ page import="Admin.*" %>

<%

    if (session.getAttribute("admin") == null) {// THen new user, show join now

        response.sendRedirect(request.getContextPath() + "/index.jsp");

    }
    
    if (request.getParameter("ref") != null) {
        new Year_wise_sold_report(getServletContext()).start();
        new Year_wise_user_report(getServletContext()).start();   
        out.println("call year wise thread");
    }
    
    
    
%>


<div class="grid_13" id="productStrip"> 

    <div class="ProductHeading">
        <div class="grid_12">
            <h2 class="heading"><center>Year Wise progress Report</center></h2>
            <a href="#"  data-parsley-required="true" onclick="return refresh_year()" class="greenBtn"> <strong> Refresh </strong> </a>
        </div>
    </div>


    <div class="clear"></div>

    <div id="productList" class="grid_3 prodGrid"> 


        <IMG SRC="<%= "images/productImages/yearwise.png"%>" WIDTH="700" HEIGHT="450" BORDER="0" USEMAP="#chart">

        
        <div class="grid_12"  style="border-top: 6px #444 solid;">
        </div>
        
        
        <IMG SRC="<%= "images/productImages/yearwiseuser.png"%>" WIDTH="700" HEIGHT="450" BORDER="0" USEMAP="#chart">
        
    </div>

</div>