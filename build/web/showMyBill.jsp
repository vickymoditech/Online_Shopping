<%-- 
    Document   : showMyBill
    Created on : Apr 6, 2016, 11:08:34 AM
    Author     : Vicky
--%>

<%@page import="javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.*"%>
<%@page import="database.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>SaiKiran BookStores</title>


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

            #whiteBox input , textarea{
                width:90px;
                position: relative;
                color:#000;
                border-color:#696969;
                outline: none;
                border-radius:7px 0px 7px 0px;
                padding:5px;
                background: -webkit-linear-gradient(top, #EEE,#FFF);
                background: -moz-linear-gradient(top, #EEE,#FFF);
                box-shadow:0px 0px 3px  #000;
                -webkit-transition: .7s all ease-in-out;
            }

            #whiteBox input :focus{
                color:#000;
                border-color:#696969;
                outline: none;
                background: -webkit-linear-gradient(top, #FFF,#EEE);
                background: -moz-linear-gradient(top, #FFF,#EEE);
                font-family:'Droid';
                box-shadow:0px 0px 7px  #000;
                -webkit-transition: .7s all ease-in-out;
            }

            #whiteBox  textarea:focus{
                color:#000;
                border-color:#696969;
                outline: none;
                background: -webkit-linear-gradient(top, #FFF,#EEE);
                background: -moz-linear-gradient(top, #FFF,#EEE);
                font-family:'Droid';
                box-shadow:0px 0px 7px  #000;
                -webkit-transition: .7s all ease-in-out;

            }
            #whiteBox textarea{
                font-family:'Droid';
            }
            #whiteBox {
                padding-top: 10px;
                padding-bottom: 10px;
                padding: 10px;
            }
            #status {
                margin: 17px;
                padding: 7px;
                font-size: 17px;
                text-align: center;
                box-shadow: 0px 0px 10px #999;
            }
        </style>
    </head>
    <body>

        <%
            if (session.getAttribute("user") == null) {// THen new user, show join now

                response.sendRedirect(request.getContextPath() + "/index.jsp");

            } else {
        %>
        <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%            }
        %>

        <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
        <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>

            <div class="container_16">


            <%
                try {
                    if (request.getParameter("oid") != null) {

                        String OrderId = request.getParameter("oid");
                        String query = "select u_fname,u_contact,u_add,u_pincode,order_date,l_email,order_status from tbl_order,tbl_user_detail,tbl_login where tbl_order.l_id=tbl_user_detail.l_id and tbl_order.l_id=tbl_login.l_id and tbl_order.o_id = " + OrderId;
                        Database_connection obj_connection = new Database_connection();
                        Connection cnn = obj_connection.cnn;
                        Statement st = cnn.createStatement();
                        ResultSet rs = st.executeQuery(query);
                        while (rs.next()) {
                            String name,
                                    email, address, mobileNum, status;
                            String ordered_on_date;
                            int pincode;

                            name = rs.getString(1);
                            email = rs.getString(6);
                            address = rs.getString(3);
                            mobileNum = rs.getString(2);
                            ordered_on_date = rs.getString(5);
                            pincode = rs.getInt(4);
                            status = rs.getString(7);
            %>
            <div class="grid_12 push_2" id="whiteBox">
                <div class="grid_7">
                    <div class="grid_2">
                        Name :
                    </div>
                    <div class="grid_3">
                        <%= name%>
                    </div>
                    <div class="grid_2">
                        Email:
                    </div>
                    <div class="grid_3">
                        <%= email%>
                    </div>
                    <div class="grid_2">
                        Address:
                    </div>
                    <div class="grid_3">
                        <%= address%>
                    </div>
                    <div class="grid_2">
                        Pin Code:
                    </div>
                    <div class="grid_3">
                        <%= pincode%>
                    </div>
                    <div class="grid_2">
                        Mobile:
                    </div>
                    <div class="grid_3">
                        <%= mobileNum%>
                    </div>
                    <div class="grid_2">
                        Ordered On:
                    </div>
                    <div class="grid_3">
                        <%= ordered_on_date%>
                    </div>
                </div>
                <div class="grid_4" >
                    <div id="status" class="grid_3">
                        Status <%= status%>
                    </div>
                    <% if (status.equals("deliver")) {
                    %>
                <!--    <a target="_blank" id="status" class="grid_3" href="showMyBill_Print.jsp?oid=<%= OrderId%>">Print my bill</a> -->
                    <%

                    } else {

                    %>

                    <a id="status" class="grid_3" href="Cancle_order?oid=<%= OrderId%>">Cancle Order</a>

                    <% }%>
                    <div class="clear">
                    </div><br/>
                </div>
            </div>
            <%
                }
            %>

            <div id="whiteBox" class="grid_12 push_2">
                <div id="CartTable" style="padding:10px 00px" class="grid_12">
                    <div class="grid_1">
                        <h3>Order No</h3>
                    </div> 
                    <div class="grid_7">
                        <h3 class="push_3">Order Summary</h3> 
                        <div class="clear"></div>
                        <div class="grid_4">
                            Item 
                        </div>
                        <div class="grid_2">
                            Price x Quantity
                        </div>
                    </div>
                    <div class="grid_3 ">
                        <h3>Total Value</h3>
                    </div>

                    <div class="grid_11"  style="border-top: 3px #444 solid;">
                    </div>

                    <div class="clear"></div>

                    <%



                        String query1 = " select p_name,p_price,user_qty,total from tbl_product,tbl_order_detail where tbl_product.p_id = tbl_order_detail.p_id and o_id = " + OrderId;
                        rs = st.executeQuery(query1);

                        String product_name;
                        double product_price;
                        int product_quantity;
                        double totalPrice = 0;
                        double totalValue = 0;

                        while (rs.next()) {

                            product_name = rs.getString(1);
                            product_price = rs.getInt(2);
                            product_quantity = rs.getInt(3);
                            totalValue = rs.getInt(4);
                            totalPrice += totalValue;

                    %>


                    <!-- Type I Order -->
                    <div class="grid_12">
                        <div  class="grid_1">
                            <a class="blue" href="showMyBill.jsp?oid=<%= OrderId%>"><font color="red"><%= OrderId%></font></a>
                        </div>
                        <div class="grid_7">
                            <div class="grid_4 ">
                                <%= product_name%> 
                            </div>
                            <div class="grid_2">
                                Rs. <%= product_price%> x<%= product_quantity%>
                            </div>
                        </div>
                        <div class="grid_3">
                            <%= totalValue%> 
                        </div>
                    </div>
                    <div class="clear"></div>

                    <%
                        }
                        totalPrice = Math.ceil(totalPrice);
                    %>

                    <!-- Type I Order -->
                    <div class="clear"></div><br/>
                    <div class="grid_12">
                        <hr class="grid_11"/>
                        <div class="grid_4">
                            Total Order Price
                        </div>
                        <div class="grid_4 push_4">
                            <h1>Rs. <%= totalPrice%></h1> 
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>

        <%        } else {%>

        <div class="container_16">
            <div class="grid_12 push_2" id="whiteBox">
                <br/><h1>No Product Invoice to Display</h1><hr/><br/>
            </div>
        </div>


        <%      }
  } catch (Exception ex) {%>

        <div class="container_16">
            <div class="grid_12 push_2" id="whiteBox">
                <br/><h1>No Product Invoice to Display</h1><hr/><br/>
            </div>
        </div>

        <%  }%>


