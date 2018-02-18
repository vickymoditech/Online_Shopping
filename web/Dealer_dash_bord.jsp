<%-- 
    Document   : Dealer_dash_bord
    Created on : Apr 17, 2016, 6:06:00 PM
    Author     : Vicky
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*"%>

<!DOCTYPE html>
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

        <script>
    
            function show(str)
            {
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", str , true);
                xhttp.send();
            }
            
            
            function d_cat(cid)
            {
               
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                        
                xhttp.open("GET", "Dealer_product_all.jsp?cid="+cid, true);
                xhttp.send();
                return false;
               
            }
            
            
            function d_sub(sid)
            {
               
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                        
                xhttp.open("GET", "Dealer_product_all.jsp?sid="+sid, true);
                xhttp.send();
                return false;
               
            }
            
            function d_delete(did)
            {
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                        
                xhttp.open("GET", "Dealer_all_price.jsp?did="+did, true);
                xhttp.send();
                return false;
            }
            
            function limitback(p,t)
            {
                alert(p-1);
                alert(t);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                        
                xhttp.open("GET", "Dealer_all_price.jsp?page="+(p-1)+"&total="+t, true);
                xhttp.send();
                return false;
                
            }
            
            function limitnext(p,t)
            {
                alert(p+1);
                alert(t);
                
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                        
                xhttp.open("GET", "Dealer_all_price.jsp?page="+(p+1)+"&total="+t, true);
                xhttp.send();
                return false;
                
                
            }
            
            
            
            function limitallback(p,t,sid)
            {
               // alert(p-1);
               // alert(t);
               // alert(sid);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                        
                xhttp.open("GET", "Dealer_product_all.jsp?page="+(p-1)+"&total="+t+"&sid="+sid, true);
                xhttp.send();
                return false;
                
            }
            
            function limitallnext(p,t,sid)
            {
               // alert(p+1);
               // alert(t);
               // alert(sid);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                        
                xhttp.open("GET", "Dealer_product_all.jsp?page="+(p+1)+"&total="+t+"&sid="+sid, true);
                xhttp.send();
                return false;
                
                
            }
            
            
            
            
            
            
            
            
            
        </script>




    </script>


    <style type="text/css">

        #leftside {
            cursor: pointer;
            position: fixed;
        }
    </style>

</head>
<body>


    <%
        if (session.getAttribute("user") == null || session.getAttribute("dealer") == null) {// THen new user, show join now

            response.sendRedirect(request.getContextPath() + "/index.jsp");

        } else {
    %>
    <jsp:include page="includesPage/_logout.jsp"></jsp:include>
    <%            }
    %>



    <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
    <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>




    <div class="container_16">
        <div id = "contents">
            <!-- LeftSide -->

            <div id="leftside" class="grid_3">

                <div>
                    <ul id="leftsideNav">
                        <li><a href="Dealer_dash_bord.jsp" ><strong>Dash Home</strong></a></li>
                        <li><a href="#" onclick="show('Dealer_product_all.jsp')"><strong>All Product</strong></a></li>
                    </ul>
                </div>

                <div class="adv">
         <!--           <a href="product.jsp?id=<%= 123%>"><img src="images/productImages/q1.jpeg" width="150" height="150" /></a> -->
                </div>
            </div>
        </div>

        <!-- Middle -->

        <div id="middle"class="grid_13">



        </div>

        <!--The Middle Content Div Closing -->
    </div>
    <!--The Center Content Div Closing -->
    <jsp:include page="includesPage/_footer.jsp"></jsp:include>

</body>

<script>
        
    var xhttp;
    xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (xhttp.readyState== 4 && xhttp.status == 200) {
            document.getElementById("middle").innerHTML = xhttp.responseText;
        }
    };
    xhttp.open("GET", "Dealer_all_price.jsp", true);
    xhttp.send();
        
</script>

</html>



