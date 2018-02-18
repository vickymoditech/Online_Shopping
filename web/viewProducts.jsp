
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
    
            function show(str,c)
            {
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Product_view.jsp?sid="+str+"&sc_name="+c, true);
                xhttp.send();
            }
            
            
            function limitnext(p,sid,str,t)
            {
               // alert(p+1);
               // alert(sid);
               // alert(str);
               // alert(t);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Product_view.jsp?sid="+sid+"&sc_name="+str+"&page="+(p+1)+"&total="+t, true);
                xhttp.send();
                return false;
            }
            
            
            function limitback(p,sid,str,t)
            {
               // alert(p-1);
               // alert(sid);
               // alert(str);
               // alert(t);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Product_view.jsp?sid="+sid+"&sc_name="+str+"&page="+(p-1)+"&total="+t, true);
                xhttp.send();
                return false;
            }
            
            
            
            
        </script>


        <script>
            
            function babu()
            {
                alert("i am vicky");
            }
            
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
            if (session.getAttribute("user") == null) {// THen new user, show join now
        %>
        <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
        <%        } else {
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

                    <%

                        Database_connection obj_connection = new Database_connection();
                        Connection cnn = obj_connection.cnn;
                        Statement st = cnn.createStatement(); // Some Changes Here 
                        ResultSet rs = st.executeQuery("select sub_id,sub_name from tbl_sub_cat where c_id = " + request.getParameter("id")+" and status = 'true'");

                    %>
                    <div>
                        <ul id="leftsideNav">
                            <li><a href="index.jsp"><strong>Home</strong></a></li>
                            <%
                                while (rs.next()) {
                                    String tmp = rs.getString(2);
                            %>
                            <li><a href="#" onclick="show('<%= rs.getInt(1)%>','<%= tmp%>')"><strong><%= tmp%></strong></a></li>      
                            <%
                                }%>
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
        
        function getParamValuesByName (querystring) {
            var qstring = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < qstring.length; i++) {
                var urlparam = qstring[i].split('=');
                if (urlparam[0] == querystring) {
                    return urlparam[1];
                }
            }
        }
        var id = getParamValuesByName('id');
        var c_name = getParamValuesByName('c_name');
    
        var xhttp;
        xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState== 4 && xhttp.status == 200) {
                document.getElementById("middle").innerHTML = xhttp.responseText;
            }
        };
        xhttp.open("GET", "Product_view.jsp?id="+id+"&c_name="+c_name, true);
        xhttp.send();
    </script>

</html>
