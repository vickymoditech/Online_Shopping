<%-- 
    Document   : Admin_add_new_product
    Created on : Apr 30, 2016, 10:49:48 PM
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
        
        function send_cat(c)
        {
            window.location="Admin_add_new_product.jsp?cid="+c;
        }
        
        function data_check()
        {
            
            var check = "true";
            document.getElementById("catmsg1").innerHTML = " ";
            document.getElementById("msgqty").innerHTML = "";
            document.getElementById("msgold").innerHTML = "";
            document.getElementById("msgprice").innerHTML = "";
            document.getElementById("msgdesc").innerHTML = "";
            document.getElementById("msgcompany").innerHTML = "";
            document.getElementById("msgpname").innerHTML = "";
            var v = document.getElementById("selectcat").value;
            var v8 = document.getElementById("p_type").value;
            var v2 = document.getElementById("p_qty").value;
            var v3 = document.getElementById("p_price").value;
            var v4 = document.getElementById("p_old").value;
            var v5 = document.getElementById("p_name").value;
            var v6 = document.getElementById("p_company").value;
            var v7 = document.getElementById("p_desc").value;
            //   var v8 = document.getElementById("p_type").value;
            //    var v9 = document.getElementById("p_old").value;
           
            
            if(v=="" || v==null)
            {
                document.getElementById("catmsg1").style.color = "red";
                document.getElementById("catmsg1").innerHTML = "Select Category First";
                check = "false";
            }
            else
            {
                document.getElementById("subcatmsg1").innerHTML = " ";
                var v1 = document.getElementById("selectsubcat").value;
         
                if(v1=="" || v1==null)
                {
                    document.getElementById("subcatmsg1").style.color = "red";
                    document.getElementById("subcatmsg1").innerHTML = "Select Sub-Category First";
                    check = "false";
                }
            }
            
            if(v2.match(/^[0-9]+$/))
            {
            }
            else
            {
                document.getElementById("msgqty").style.color = "red";
                document.getElementById("msgqty").innerHTML = "only Digit are allowed";
                check = "false";
            }
            
            if(v3.match(/^[0-9]+$/))
            {
            }
            else
            {
                document.getElementById("msgprice").style.color = "red";
                document.getElementById("msgprice").innerHTML = "only Digit are allowed";
                check = "false";
            }
            
            if(v5 == "special")
            {
            
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
        
            if(v5.length < 3)
            {
                document.getElementById("msgpname").style.color = "red";
                document.getElementById("msgpname").innerHTML = "Invalid product Name";
                check = "false";
            }
        
            if(v6.length < 3)
            {
                document.getElementById("msgcompany").style.color = "red";
                document.getElementById("msgcompany").innerHTML = "Invalid product Company ";
                check = "false";
            }
        
            if(v7.length < 5)
            {
                document.getElementById("msgdesc").style.color = "red";
                document.getElementById("msgdesc").innerHTML = "Invalid product Desc";
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
        
            if(check=="false")
            {
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
            response.sendRedirect("index.jsp");
        }

    %>

    <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
    <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>
    <div class="container_16">
        <div class="grid_16" style="padding: 10px;" id="whiteBox">

            <br/>

            <h1 class="grid_15">Manage Product Information</h1><hr/>


        </div>



        <div class="grid_13"  style="padding: 10px 0px 10px 0px;" id="whiteBox">


            <form method="post" action="Add_new_product" onsubmit="return data_check()">
                <div class="clear"></div><br/>
                <div class="grid_13"  style="padding: 10px; ">



                    <%                        Database_connection obj_connection = new Database_connection();
                        Connection cnn = obj_connection.cnn;
                        Statement st = cnn.createStatement();
                        ResultSet rs = st.executeQuery("select c_id,c_name from tbl_category where status = 'true'");
                    %>

                    <div class="grid_2">
                        Category
                    </div>
                    <div class="grid_5">
                        <select id="selectcat"  name="p_category" style="margin:  +2px" onchange="send_cat(this.value)">

                            <% if (request.getParameter(
                                        "cid") == null) {%>
                            <option value="" selected><%= "Select Category"%></option>

                            <% while (rs.next()) {%>
                            <option value="<%= rs.getInt(1)%>"><%= rs.getString(2)%></option>
                            <% }%>

                            <% } else {%>


                            <% while (rs.next()) {
                                    int c_id = rs.getInt(1);
                                    if (request.getParameter("cid").equals(String.valueOf(c_id))) {
                            %>
                            <option value="<%= rs.getInt(1)%>" selected><%= rs.getString(2)%></option>
                            <% } else {%>
                            <option value="<%= rs.getInt(1)%>"><%= rs.getString(2)%></option>
                            <% }%>
                            <% }%>
                            <% }%>

                        </select>
                        <br>
                        <label id="catmsg1"></label>
                    </div>
                    <div class="clear"></div><br/>




                    <%
                        if (request.getParameter(
                                "cid") != null) {
                            Statement st1 = cnn.createStatement();
                            ResultSet rs1 = st1.executeQuery("select sub_id,sub_name from tbl_sub_cat where c_id = " + request.getParameter("cid")+" and status = 'true'");
                    %>


                    <div class="grid_2">
                        Sub-Category
                    </div>
                    <div class="grid_5">
                        <select id="selectsubcat" name="sub_category" style="margin:  +2px">
                            <option value="" selected><%= "Select Sub-Category"%></option>
                            <% while (rs1.next()) {%>
                            <option value="<%= rs1.getInt(1)%>"><%= rs1.getString(2)%></option>
                            <% }%>
                        </select>
                        <br>
                        <label id="subcatmsg1"></label>
                    </div>
                    <div class="clear"></div><br/>
                    <% }%>




                    <div class="grid_2">
                        Product Name
                    </div>
                    <div class="grid_5">
                        <input type="text" name="p_name" id="p_name" maxlength="30" required/><br>
                        <label id="msgpname"></label>
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_2">
                        Product Quantity 
                    </div>
                    <div class="grid_5">
                        <input type="text" id="p_qty" name="p_qty" style="width: 75px;" maxlength="6" required/><br>
                        <label id="msgqty"></label>
                    </div>
                    <div class="clear"></div><br>


                    <div class="grid_2">
                        Product Price: Rs.
                    </div>
                    <div class="grid_5">
                        <input type="text" id="p_price" name="p_price" maxlength="6" required><br>
                        <label id="msgprice"></label>
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_2">
                        Product Company.
                    </div>
                    <div class="grid_5">
                        <input type="text" id="p_company" name="p_company" maxlength="30" required><br>
                        <label id="msgcompany"></label>
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_2">
                        Product Type.
                    </div>
                    <div class="grid_5">
                        <select id="p_type" name="p_type" style="margin:  +2px"  onchange="old_price(this.value)">
                            <option value="normal" selected>normal</option>
                            <option value="special">special</option>
                        </select>
                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_2">
                        <label id="p_old_l">Old Price</label>
                    </div>
                    <div class="grid_5">
                        <input type="text" name="p_old" id="p_old" maxlength="6"><br>
                        <label id="msgold"></label>
                    </div>
                    <div class="clear"></div><br/>



                    <div class="grid_2">
                        Description / Summary
                    </div>
                    <div class="grid_5">
                        <textarea  id ="p_desc" name="p_desc" cols="50" rows="20" maxlength="80" required></textarea><br>
                        <label id="msgdesc"></label>
                    </div>
                </div>


                <div class="grid_5">
                    <input type="submit" id="greenBtn" value="Add New Product" />
                </div>
            </form>


        </div>




    </div>
</body>

<script>
    
    var v = document.getElementById("p_old");
    var v1 = document.getElementById("p_old_l");
    v.style.visibility = "hidden";
    v1.style.visibility = "hidden";
        
    
</script>


</html>


