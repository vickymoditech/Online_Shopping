<%-- 
    Document   : Admin_manage_product
    Created on : Apr 8, 2016, 9:45:54 AM
    Author     : Vicky
--%>

<%@page import="sun.security.action.GetIntegerAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>SaiKiran BookStores</title>
    <link rel="shortcut icon" href="images/logo/ico.ico"/>
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="css/text.css"/>
    <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
    <link rel="stylesheet" type="text/css" href="css/product.css"  />
    <link rel="stylesheet" type="text/css" href="css/styles.css"/>

    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/myScript.js"></script>

    <script>
        
        function validation()
        {
            var add_qty = document.getElementById("a_qty").value;
            var price = document.getElementById("price").value;
            var v8 = document.getElementById("p_type").value;
            var v4 = document.getElementById("p_old").value;
            
            document.getElementById("msgold").innerHTML = " ";
            document.getElementById("m1").innerHTML = " ";
            document.getElementById("m2").innerHTML = " ";
            var check = "true";
  
            if(add_qty.match(/^[0-9]+$/))
            {}
            else
            {
                document.getElementById("m1").style.color = "red";
                document.getElementById("m1").innerHTML = "only Digit are allowed";
                check = "false";
            }
            
            if(v8=="special")
            {
                if(v4==null && v4=="")
                {
                    document.getElementById("msgold").style.color = "red";
                    document.getElementById("msgold").innerHTML = "only Digit are allowed";
                    check = "false";
                }
                if(v4.match(/^[0-9]+$/))
                {
                    
                }
                else
                {
                    document.getElementById("msgold").style.color = "red";
                    document.getElementById("msgold").innerHTML = "only Digit are allowed";
                    check = "false";
                }
                
            }
            
            
            
            if(price.match(/^[0-9]+$/))
            {}
            else
            {
                document.getElementById("m2").style.color = "red";
                document.getElementById("m2").innerHTML = "only Digit are allowed";
                check = "false";
            }
            
            if(check == "false")
            {
                return false;
            }
         
        }
        
        
        
        
        
        
    </script>


    <script>
        
        function check()
        {
            document.getElementById("d_m1").innerHTML = " ";
            var v = document.getElementById("d_price").value;
            if(v.match(/^[0-9]+$/))
            {
            
            }
            else
            {
                document.getElementById("d_m1").style.color = "red";
                document.getElementById("d_m1").innerHTML = "only Digit are allowed";
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

            <h1 class="grid_15">Manage Product Information</h1><hr/>


        </div>





        <%

            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;
            Statement st = cnn.createStatement();

            //Fetch the (PID) Product ID 
            String productId = request.getParameter("pid");
            if (request.getParameter("pid") != null) {


                String query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,old_price from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.p_id =" + productId;


                String company = "", productName = "",
                        category = "", subCategory = "",
                        image_id = "", summary = "", imageName = "", p_type = "";

                int quantity = 0, price = 0, old_price = 0;



                ArrayList<String> productImages = new ArrayList<String>();
                ArrayList<String> productImagesId = new ArrayList<String>();
                productImages.clear();
                productImagesId.clear();

                //   productImagesId.add("1");


                // all the images add in this array list 

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
                    old_price = rs.getInt(10);

                }

                session.setAttribute("productId", productId);
                session.setAttribute("productName", productName);
        %>

        <div class="grid_13"  style="padding: 10px 0px 10px 0px;" id="whiteBox">
            <h1 style="padding: 10px; text-align: center;" class="grid_12"><span class="blue"></span> <%=productName%></h1><hr/>

            <% if (session.getAttribute("admin") != null) {%>

            <form method="post" action="Admin_changeProductInfo?pid=<%= productId%>" onsubmit="return validation()">
                <div class="grid_7">
                    <h3 style="padding: 10px; "><%=category%> > <%=subCategory%></h3>
                </div>
                <div class="grid_5">
                    <a href="Admin_delete_product?pid=<%= productId%>" id="greenBtn"><strong>[x] Delete this Item</strong></a><br>
                    <a href="Admin_image_upload.jsp?mid=<%= productId%>" id="greenBtn"><strong>[x] Change product Image </strong></a><br>
                </div>
                <div class="clear"></div><br/>

                <div class="grid_13"  style="padding: 10px; ">
                    <div class="grid_2">
                        Product Name
                    </div>
                    <div class="grid_5">
                        <input type="text" name="p_name" value="<%=productName%>" maxlength="30" />
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_2">
                        Product Quantity in Stock
                    </div>
                    <div class="grid_5">
                        <input type="text" name="p_qty" value="<%=quantity%>" style="width: 75px;" disabled/><h1>+</h1>
                    </div>
                    <div class="clear"></div>

                    <div class="grid_2">
                        Add Product Quantity
                    </div>
                    <div class="grid_5">
                        <input type="text" id="a_qty" name="add_qty" value="0" style="width: 75px;" maxlength="11" required/>
                        <label id="m1"></label>
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_2">
                        Product Price: Rs.
                    </div>
                    <div class="grid_5">
                        <input type="text" id="price" name="p_price" value="<%=price%>" maxlength="11" required>
                        <label id="m2"></label>
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_2">
                        Product Company.
                    </div>
                    <div class="grid_5">
                        <input type="text" name="p_company" value="<%= company%>" maxlength="30" required>
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_2">
                        Product Type.
                    </div>
                    <div class="grid_5">
                        <select id="p_type" name="p_type" style="margin:  +2px" onchange="old_price(this.value)">
                            <% if (p_type.equals("special")) {%>
                            <option value="special" selected>special</option>
                            <option value="normal">normal</option>
                            <% } else {%>
                            <option value="normal" selected>normal</option>
                            <option value="special">special</option>
                            <% }%>
                        </select>
                    </div>
                    <div class="clear"></div><br/>



                    <div class="grid_2">
                        <label id="p_old_l">Old Price</label>
                    </div>
                    <div class="grid_5">
                        <input type="text" name="p_old" id="p_old" maxlength="6" value="<%= old_price%>"><br>
                        <label id="msgold"></label>
                    </div>
                    <div class="clear"></div><br/>




                    <div class="grid_2">
                        Description / Summary
                    </div>
                    <div class="grid_5">
                        <textarea name="p_desc" cols="50" rows="20" maxlength="80"><%= summary%></textarea>
                    </div>
                </div>




                <div class="grid_5">
                    <input type="submit" id="greenBtn" value="Save Changes" />
                </div>
            </form>



            <% } else {%>


            <form method="post" action="Dealer_add_price?pid=<%= productId%>" onsubmit="return check()">

                <div class="grid_7">
                    <h3 style="padding: 10px; "><%=category%> > <%=subCategory%></h3>
                </div>

                <%

                    boolean b = true;
                    int d_price = 0;
                    Statement st2 = cnn.createStatement();
                    ResultSet rs2 = st2.executeQuery("select d_price from tbl_dealer where l_id = " + session.getAttribute("dealer") + " and p_id = " + request.getParameter("pid"));
                    while (rs2.next()) {
                        b = false;
                        d_price = rs2.getInt(1);
                    }

                %>

                <% if (!b) {%>

                <div class="grid_5">
                    <a href="Dealer_delete_price?pid=<%= productId%>" id="greenBtn"><strong>[x] Delete Your Price</strong></a>
                </div>
                <div class="clear"></div><br/>

                <% }%>


                <div class="grid_13"  style="padding: 10px; ">
                    <div class="grid_16">
                        <img src="<%= imageName%>" >
                    </div>
                    <div class="grid_3">
                        Product Name
                    </div>
                    <div class="grid_5">
                        <input type="text" name="p_name" value="<%=productName%>" disabled/>
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_3">
                        Now Product Price: Rs.
                    </div>
                    <div class="grid_5">
                        <input type="text" id="price" name="p_price" value="<%=price%>" disabled>
                    </div>
                    <div class="clear"></div><br/>


                    <% if (b) {%>

                    <div class="grid_3">
                        Add Your Price: Rs.
                    </div>
                    <div class="grid_5">
                        <input type="text" id="d_price" name="d_price"><br>
                        <label id="d_m1"></label>
                    </div>
                    <div class="clear"></div><br/>

                    <div class="grid_5">
                        <input type="submit" id="greenBtn" value="Add Price" />
                    </div>

                    <% } else {%>


                    <div class="grid_3">
                        Add Your Price: Rs.
                    </div>
                    <div class="grid_5">
                        <input type="text" id="d_price" name="d_price" maxlength="11"  value="<%= d_price%>"><br>
                        <label id="d_m1"></label>
                    </div>
                    <div class="clear"></div><br/>

                    <div class="grid_5">
                        <input type="submit" id="greenBtn" value="Change Price" />
                    </div>


                    <% }%>



            </form>


            <% }%>



        </div>

        <script>
                
            function old_price(str)
            {
                var v = document.getElementById("p_old");
                var v1 = document.getElementById("p_old_l");
                var v2 = document.getElementById("msgold");
                if(str=='normal')
                {
                    
                    v.style.visibility = "hidden";
                    v1.style.visibility = "hidden";
                    v2.style.visibility = "hidden";
                }
                else
                {
                    v.style.visibility = "visible";
                    v1.style.visibility = "visible";
                    v2.style.visibility = "visible";
                }
            }
                
        </script>

        <%  }%>

    </div>
</body>
</html>
