<%-- 
    Document   : Admin_deliver_order
    Created on : Apr 13, 2016, 12:11:35 PM
    Author     : Vicky
--%>



<%@page import="com.sun.org.apache.regexp.internal.REUtil"%>
<%@page import="java.sql.*, database.*" %>
<%@page import="database.*"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>SaiKiran BookStores</title>


        <link rel="shortcut icon" href="images/logo/ico.ico"/>
        <link rel="stylesheet" type="text/css" href="css/reset.css"/>
        <link rel="stylesheet" type="text/css" href="css/text.css"/>
        <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
        <link rel="stylesheet" type="text/css" href="css/time_pass.css"/>
        <link rel="stylesheet" type="text/css" href="css/product.css"  />

        <link rel="stylesheet" type="text/css" href="css/lightbox.css"  />

        <link rel="stylesheet" type="text/css" href="css/styles.css"/>

        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/lightbox.js"></script>
        <script src="js/myScript.js"></script>


        <script>
            
            var b = true;
            function checkall(str)
            {
                if(b==true)
                {
                    for(j=1;j<str;j++)
                    {
                        document.getElementById("squaredTwo"+j).checked = true;
                        document.getElementById("v"+j).setAttribute("for", "squaredTwo"+j);
                    }
                    b = false;
                }
                else
                {
                    for(j=1;j<str;j++)
                    {
                        document.getElementById("squaredTwo"+j).checked = false;
                        document.getElementById("v"+j).setAttribute("for", "squaredTwo"+j);
                    }
                    b = true;
                }
                return false;
            }
        </script>
        


    </head>
    <body>

        <form action="Admin_deliverorder" method="post">
            
            <% int i = 1; %>
            

            <%
                if (session.getAttribute("admin") == null) {                   // THen new user, show join now

                    response.sendRedirect(request.getContextPath() + "/index.jsp");

                } else {
            %>

            <jsp:include page="includesPage/_logout.jsp"></jsp:include>

            <% }%>

            <% {
                    Database_connection obj_connection = new Database_connection();
                    Connection cnn = obj_connection.cnn;
                    Statement st = cnn.createStatement();
                    ResultSet rs;
            %>

            <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
            <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>

            <div class="container_16">


                <div class="grid_16" id="whiteBox">
                    <div  class="grid_16">
                        <h1  style ="text-align: center; padding: 10px 0px 0px 0px;">Approval Order</h1><br/>
                    </div>
                </div>


                <div id="whiteBox" class="grid_16">

                    <div  style ="text-align: center; border-top: 20px #444 solid; padding: 10px 0px 10px 0px;" class="grid_15 MyOrders">

                        <h1 style ="padding: 10px 0px 10px 0px;"><input type="submit" value="Deliver Order" id="greenBtn"></h1>  

                        <div style="padding:10px 00px" class="grid_16">
                            <div class="grid_1">
                                <h2>Order No</h2>
                            </div> 
                            <div class="grid_7">
                                <h2 class="push_3">Order Summary</h2>
                                <div class="clear"></div>
                                <div class="grid_4">
                                    Item 
                                </div>
                                <div class="grid_2">
                                    Price x Quantity
                                </div>
                            </div>
                            <div class="grid_3 push_1">
                                <h2>Date</h2>
                            </div>

                            <div class="clear"></div>

                            <!-- data base bill number check and display -->

                            <%
                                
                                int billno = 0;
                                String order_date = null;
                                int total = 0;
                                rs = st.executeQuery(" select o_id,order_date,grand_total from tbl_order where order_status = 'approve'");
                                while (rs.next()) {
                                    billno = rs.getInt(1);
                                    order_date = rs.getString(2);
                                    total = rs.getInt(3);

                            %>


                            <div class="grid_15"  style="border-top: 3px #444 solid;">

                                <div  class="grid_1">
                                    <a class="blue" href="showMyBill.jsp?oid=<%= billno%>"><%= billno%></a>
                                </div>

                                <%

                                    // joint query write here tbl_oder_detail and tbl_product joint id = p_id
                                    Statement st1 = cnn.createStatement();
                                    ResultSet rs1;
                                    int count = 1;
                                    rs1 = st1.executeQuery(" select p_name,p_price,user_qty from tbl_product,tbl_order_detail where tbl_product.p_id = tbl_order_detail.p_id and o_id=" + billno);

                                    while (rs1.next()) {
                                        String p_name = rs1.getString(1);
                                        int p_price = rs1.getInt(2);
                                        int user_qty = rs1.getInt(3);
                                %>                                                                       


                                <!-- second item -->

                                <div class="grid_15">
                                    <div class="push_1">
                                        <div class="grid_7">
                                            <div class="grid_4 ">
                                                <%= p_name%> 
                                            </div>
                                            <div class="grid_2">
                                                Rs. <%= p_price%> x<%= user_qty%>
                                            </div>
                                        </div>
                                        <div class="grid_3">
                                            <%= order_date%>
                                        </div>
                                    </div>
                                </div>

                                <%  }%>     

                                <div class="grid_12"  style="border-top: 1px #444 solid;">
                                </div>


                                <div class="grid_15">
                                    <div class="push_1">
                                        <div class="grid_7">
                                            <div class="grid_4 ">
                                                <strong> <%= "Total Amount "%> </strong> 
                                            </div>
                                            <div class="grid_2">
                                                <strong>Rs. <%= total%></strong>
                                            </div>
                                        </div>
                                        <div class="grid_3">
                                            <%= order_date%>
                                        </div>
                                    </div>
                                </div>



                                <div class="squaredTwo grid_1">
                                    <input type="checkbox" value="<%= billno %>" id="<%= "squaredTwo" + i%>" name="check" />
                                    <label id="<%= "v" + i %>" for="<%= "squaredTwo" + i%>"></label>
                                </div>



                                <% i++;%>


                            </div>


                            <% }%>
                        </div>
                    </div>

                        
                        <div class="squaredTwo grid_1">
                        <input type="checkbox" value="" id="<%= "squaredTwo"%>" name="checkAll" onchange="return checkall(<%= i%>)" />
                        <label for="<%= "squaredTwo"%>"></label>
                    </div>
                        
                </div>
            </div>
            <% }%>
           
            <!-- add here footer page -->
            
            
            
        </form>
    </body>
</html>