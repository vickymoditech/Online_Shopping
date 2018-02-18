<%-- 
    Document   : Admin_manage_special
    Created on : May 2, 2016, 1:58:49 PM
    Author     : Vicky
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import="sun.security.action.GetIntegerAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*" %>


<html>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>SaiKiran BookStores</title>
    <link rel="shortcut icon" href="images/logo/ico.ico"/>
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="css/text.css"/>
    <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
    <link rel="stylesheet" type="text/css" href="css/product.css"  />
    <link rel="stylesheet" type="text/css" href="css/styles.css"/>
    <link rel="stylesheet" type="text/css" href="css/time_pass.css"/>

    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/myScript.js"></script>

    <script>
        
        function check()
        {
            var v = parseInt(document.getElementById("totaluser").textContent);
            var i = document.getElementById("limit").value;
            document.getElementById("msgdis").innerHTML = " ";
            
            if(i==" " || i==null)
            {
                document.getElementById("msgdis").style.color = "red";
                document.getElementById("msgdis").innerHTML =  " Invalid Limit ";
                return false;
            }
            
            
            if(i.match(/^[0-9]+$/))
            {
                
            }
            else
            {
                document.getElementById("msgdis").style.color = "red";
                document.getElementById("msgdis").innerHTML = "only Digit are allowed";
                return false;
            }
            
            
            if(i>v)
            {
                document.getElementById("msgdis").style.color = "red";
                document.getElementById("msgdis").innerHTML =  v+" or less User limit Insert";
                return false;
            }
            
            
        }
        
    </script>

    <style type="text/css">
        .imageGallery {
            width: 270px;
            margin: 11px;
            padding: 8px;
            border: 1px solid #CCC;
            text-align: center;
        }
        .alert {
            box-shadow: -20px 0px 0px #C00;
        }
    </style>
</head>
<body>

    <%
        if (session.getAttribute("user") == null) {// THen new user, show join now
%>
    <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
    <%        } else {
    %>
    <jsp:include page="includesPage/_logout.jsp"></jsp:include>
    <%            }

        if (session.getAttribute("admin") == null) {
            if (session.getAttribute("dealer") == null) {
                response.sendRedirect("index.jsp");
            }
        }
    %>

    <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
    <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>
    <div class="container_16">
        <div class="grid_16" style="padding: 10px;" id="whiteBox">

            <br/>

            <h1 class="grid_15">Manage Special Offers</h1><hr/>

        </div>


        <%

            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();

            //Fetch the (PID) Product ID 
            String productId = request.getParameter("pid");
            if (request.getParameter("pid") != null) {


                String query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.p_id =" + productId;


                String company = "", productName = "",
                        category = "", subCategory = "",
                        image_id = "", summary = "", imageName = "", p_type = "";

                int quantity = 0, price = 0;

                ResultSet rs = st.executeQuery(query);

                while (rs.next()) {
                    company = rs.getString(1);
                    productName = rs.getString(2);
                    category = rs.getString(3);
                    subCategory = rs.getString(4);
                    quantity = rs.getInt(5);
                    price = rs.getInt(6);
                    summary = rs.getString(7);
                    imageName = rs.getString(8);
                    p_type = rs.getString(9);

                }

                session.setAttribute("productId", productId);
                session.setAttribute("productName", productName);
        %>

        <div class="grid_13"  style="padding: 10px 0px 10px 0px;" id="whiteBox">
            <h1 style="padding: 10px; text-align: center;" class="grid_12"><span class="blue"></span> <%=productName%></h1><hr/>


            <%
                int total_user = 0;
                Statement st1 = cnn.createStatement();
                ResultSet rs1 = st1.executeQuery("select count(l_id) from tbl_login");
                while (rs1.next()) {
                    total_user = rs1.getInt(1);
                }

            %>


            <form method="post" action="Admin_add_special_offers?pid=<%= productId%>&total=<%= total_user%>" onsubmit="return check()">

                <div class="grid_7">
                    <h3 style="padding: 10px; "><%=category%> > <%=subCategory%></h3>
                </div>

                <div class="grid_13"  style="padding: 10px; ">
                    <div class="grid_16">
                        <img src="<%= imageName%>" >
                    </div>
                    <div class="grid_3">
                        <strong>Product Name</strong>
                    </div>
                    <div class="grid_5">
                        <input type="text" name="p_name" value="<%=productName%>" disabled/>
                    </div>
                    <div class="clear"></div><br/>




                    <div class="squaredTwo grid_12" align="left" >
                        <input type="text"  value="<%= "        Low To High     "%>" disabled/><br>
                        <input type="checkbox" value="lh" id="squaredTwo1" name="user" /> 
                        <label for="squaredTwo1"></label>
                    </div>



                    <div class="squaredTwo grid_12" align="left">
                        <input type="text"  value="<%= "        High To Low     "%>" disabled/><br>
                        <input type="checkbox" value="hl" id="squaredTwo2" name="user" /> 
                        <label for="squaredTwo2"></label>
                    </div>

                    <!-- checkbox -->

                    <div class="squaredTwo grid_12" align="left">
                        <input type="text"  value="<%= "        Random     "%>" disabled/><br>
                        <input type="checkbox" value="random" id="squaredTwo3" name="user" /> 
                        <label for="squaredTwo3"></label>
                    </div><br>



                    <div class="grid_3">
                        <strong>Limit Of User</strong>
                    </div>
                    <div class="grid_5">
                        <input type="text" name="limit" id="limit">
                        <strong>Total User</strong>
                        <label id="totaluser"><strong><font color="red"><%= total_user%></font></strong></label><br>
                                <% if (request.getAttribute("msg") != null) {%>
                        <label><strong><font color="red"><%= request.getAttribute("msg")%></font></strong></label>
                                <% } else {%>
                        <label id="msgdis"></label>
                        <%}%>
                    </div>
                    <div class="clear"></div><br/>



                    <div class="grid_8">
                        <input type="submit" id="greenBtn" value="Add Price" />

                    </div>


                </div>

            </form>


            <%  }%>

        </div>
</body>
</html>


