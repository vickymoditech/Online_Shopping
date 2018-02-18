<%-- 
    Document   : dealer_price_view
    Created on : Apr 18, 2016, 6:38:23 PM
    Author     : Vicky
--%>


<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*"%>
<%@page import="Add_To_Cart.Cart"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>SaiKiran BookStores</title>

        <%@page import="java.sql.*, database.*" %>
        <link rel="shortcut icon" href="images/logo/ico.ico"/>
        <link rel="stylesheet" type="text/css" href="css/reset.css"/>
        <link rel="stylesheet" type="text/css" href="css/text.css"/>
        <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
        <link rel="stylesheet" type="text/css" href="css/product.css"  />

        <link rel="stylesheet" type="text/css" href="css/lightbox.css"  />

        <link rel="stylesheet" type="text/css" href="css/styles.css"/>

        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/lightbox.js"></script>
        <script src="js/myScript.js"></script>
        <style type="text/css">
            .shippingAddress {
                background: #EEE; 
                padding: 10px; 
                border: 2px solid #CCC; 
                border-radius: 10px 0px 10px 0px;
                cursor: pointer;
            } 
        </style>
    </head>
    <body>


        <%
            if (session.getAttribute("user") == null) {// THen new user, show join now
                     response.sendRedirect(request.getContextPath()+"/index.jsp");             
               } else {
        %>
        <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%            }
        %>

        <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
        <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>



            <div class="container_16">


                <div class="grid_16" id="whiteBox">
                    <div  class="grid_16">
                        <h1  style ="text-align: center; padding: 10px 0px 0px 0px;"> <%= request.getParameter("pname") %></h1><br/>
                    </div>
                </div>





            <%
                //   user User;
                String email = null;
                if ((session.getAttribute("user") == null)) {
                    response.sendRedirect("index.jsp");
                } else {

                    String MobileNum = null;
                    String Address = null;
                    String Username = null;
                    String l_Date = null;
                    int d_price = 0;

                    Database_connection obj_connection = new Database_connection();
                    Connection cnn = obj_connection.cnn;
                    Statement st = cnn.createStatement();
                    ResultSet rs = st.executeQuery("select u_fname,u_contact,l_email,d_last_date,d_price from tbl_user_detail,tbl_login,tbl_dealer where tbl_login.l_id = tbl_dealer.l_id and tbl_user_detail.l_id = tbl_dealer.l_id and tbl_dealer.p_id = " + request.getParameter("pid") + " order by d_price");
                    while (rs.next()) {
                        Username = rs.getString(1);
                        MobileNum = rs.getString(2);
                        Address = rs.getString(3);
                        l_Date = rs.getString(4);
                        d_price = rs.getInt(5);
            %>

            <div class="grid_14" id="whiteBox" style="padding: 10px;">

                <div class="grid_7 shippingAddress">

                    <div class="grid_1">
                        Name
                    </div>
                    <div class="grid_5">
                        <span id ="userName"><%= Username%></span>
                    </div>
                    <div class="clear"></div>
                    <div class="grid_1">
                        Mobile
                    </div>
                    <div class="grid_5">
                        <span id ="mobile"><%= MobileNum%></span>
                    </div>
                    <div class="grid_1">
                        Email
                    </div>
                    <div class="grid_5">
                        <span id ="useAddress"><%= Address%></span> 
                    </div>
                    <div class="grid_1">
                        Date
                    </div>
                    <div class="grid_5">
                        <span id ="pincode"><%= l_Date%></span> 
                    </div>
                    <div class="clear"></div>

                    <div class="grid_1">
                        Price
                    </div>
                    <div class="grid_5">
                        <span id ="pincode">Rs.<%= d_price%></span> 
                    </div>
                    <div class="clear"></div>

                    <div class="grid_17"  style="border-top: 3px #444 solid;">
                    </div>

                </div>


            </div>

            <script type="text/javascript" src="js/jquery.js"></script>
            <%  }
                    }%>


        </div>
    </body>
</html>
