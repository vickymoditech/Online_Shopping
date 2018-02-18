<%-- 
    Document   : Admin_dash_bord
    Created on : Apr 8, 2016, 9:36:19 PM
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
            
            function babu(str)
            {
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Admin_manage_product_all.jsp?sq="+str , true);
                xhttp.send();
            }
            
            function babu1(str,v)
            {
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "top10_sold_product.jsp?month="+v+"&&year="+str, true);
                xhttp.send();
            }
            
            function babu2(oldc,newc)
            {
                document.getElementById("msgcat").innerHTML = " ";  
                var msg = "Successfully updated";
                if(oldc != "" && oldc != null)
                {
                    if(newc != "" && newc != null)
                    {
                        var xhttp;
                        xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() {
                            if (xhttp.readyState== 4 && xhttp.status == 200) {
                                document.getElementById("middle").innerHTML = xhttp.responseText;
                            }
                        };
                        
                        xhttp.open("GET", "Admin_manage_category.jsp?changecat="+newc+"&&oldcat="+oldc+"&&msg="+msg, true);
                        xhttp.send();
                        
                    }
                    else
                    {
                        document.getElementById("msgcat").style.color = "red";
                        document.getElementById("msgcat").innerHTML = "Invalid Category";
                        return false;
                    }
                }
                else
                {
                    document.getElementById("msgcat").style.color = "red";
                    document.getElementById("msgcat").innerHTML = "Select First Any Category";
                    return false;
                }
                
            }
            
            function babu3(str)
            {
                if(str != "" && str != "")
                {
                    var xhttp;
                    var msg = "Successfully Add New Category";
                    xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (xhttp.readyState== 4 && xhttp.status == 200) {
                            document.getElementById("middle").innerHTML = xhttp.responseText;
                        }
                    };
                        
                    xhttp.open("GET", "Admin_manage_category.jsp?addcat="+str+"&&msg="+msg, true);
                    xhttp.send();
                }
                else
                {
                    document.getElementById("msgcat").style.color = "red";
                    document.getElementById("msgcat").innerHTML = "Invalid Category";
                    return false;
                }
            }
            
            
            function babu4(str)
            {
                if(str != "" && str != "")
                {
                    var xhttp;
                    var msg = "Successfully Delete";
                    xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (xhttp.readyState== 4 && xhttp.status == 200) {
                            document.getElementById("middle").innerHTML = xhttp.responseText;
                        }
                    };
                        
                    xhttp.open("GET", "Admin_manage_category.jsp?delcat="+str+"&&msg="+msg, true);
                    xhttp.send();
                }
                else
                {
                    document.getElementById("msgcat").style.color = "red";
                    document.getElementById("msgcat").innerHTML = "Invalid Category";
                    return false;
                }
            }
            
            function babu5(str)
            {
                document.getElementById("txtcategory").value = str;
            }
            
            function subscat(str)
            {
                document.getElementById("txtsubcategory").value = str;
            }
            
            
            function babu6(oldsub,newsub,cid)
            {
                document.getElementById("msgsubcat").innerHTML = " ";    
                if(oldsub != "" && oldsub != null)
                {
                    if(newsub != "" && newsub != null)
                    {
                        if(cid != "" && cid != null)
                        {
                            var xhttp;
                            var msg = "Successfully updated";
                            xhttp = new XMLHttpRequest();
                            xhttp.onreadystatechange = function() {
                                if (xhttp.readyState== 4 && xhttp.status == 200) {
                                    document.getElementById("middle").innerHTML = xhttp.responseText;
                                }
                            };
                        
                            xhttp.open("GET", "Admin_manage_subcategory.jsp?changesubcat="+newsub+"&&oldsubcat="+oldsub+"&&cid="+cid+"&&msg="+msg, true);
                            xhttp.send();
                        }
                        else
                        {
                            document.getElementById("msgsubcat").style.color = "red";
                            document.getElementById("msgsubcat").innerHTML = "Select First Any Category";
                            return false;
                        }
                    }
                    else
                    {
                        document.getElementById("msgsubcat").style.color = "red";
                        document.getElementById("msgsubcat").innerHTML = "Invalid Sub-Category";
                        return false;
                    }
                }
                else
                {
                    document.getElementById("msgsubcat").style.color = "red";
                    document.getElementById("msgsubcat").innerHTML = "Select First Any Sub-Category";
                    return false;
                }
            }
            
            function babu7(addsub,catid)
            {
                document.getElementById("msgsubcat").innerHTML = " ";    
                if(addsub != "" && addsub != null)
                {
                    if(catid != "" && catid != null)
                    {
                        var xhttp;
                        var msg = "Successfully Add New Sub-Category";
                        xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() {
                            if (xhttp.readyState== 4 && xhttp.status == 200) {
                                document.getElementById("middle").innerHTML = xhttp.responseText;
                            }
                        };
                        
                        xhttp.open("GET", "Admin_manage_subcategory.jsp?addsub="+addsub+"&&catid="+catid+"&&msg="+msg, true);
                        xhttp.send();
                        return false;
                    }
                    else
                    {
                        document.getElementById("msgsubcat").style.color = "red";
                        document.getElementById("msgsubcat").innerHTML = "Select Category";
                        return false;
                    }
                }
                else
                {
                    document.getElementById("msgsubcat").style.color = "red";
                    document.getElementById("msgsubcat").innerHTML = "Invalid Sub-Category";
                    return false;
                }
            }
        
        
            function babu8(delsub,catid)
            {
                document.getElementById("msgsubcat").innerHTML = " ";    
                if(delsub != "" && delsub != null)
                {
                    var xhttp;
                    var msg = "Successfully Delete";
                    xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (xhttp.readyState== 4 && xhttp.status == 200) {
                            document.getElementById("middle").innerHTML = xhttp.responseText;
                        }
                    };
                        
                    xhttp.open("GET", "Admin_manage_subcategory.jsp?delsub="+delsub+"&&catid="+catid+"&&msg="+msg, true);
                    xhttp.send();
                }
                else
                {
                    document.getElementById("msgsubcat").style.color = "red";
                    document.getElementById("msgsubcat").innerHTML = "Select First Any Sub-Category";
                    return false;
                }
            }
        
         
            function sendcid(cid)
            {
                if(cid != "" && cid != null)
                {
                    var xhttp;
                    xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (xhttp.readyState== 4 && xhttp.status == 200) {
                            document.getElementById("middle").innerHTML = xhttp.responseText;
                        }
                    };
                        
                    xhttp.open("GET", "Admin_manage_subcategory.jsp?subcid="+cid, true);
                    xhttp.send();
                    return false;
                }
                else
                {
                    document.getElementById("msgsubcat").style.color = "red";
                    document.getElementById("msgsubcat").innerHTML = "Select First Any Category";
                    return false;
                }
            }
            
            function pending_order()
            {
                var v = document.getElementsByName("pending").value;   
                alert(v);
            }
           
           
            function refresh()
            {
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "top10_sold_product.jsp?ref=true", true);
                xhttp.send(); 
                
                
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "loader.jsp", true);
                xhttp.send(); 
                
                
                
                
                move();       // Thread Wiil be Call But Chart is old Then Once Again Load This Page 
                
            }      
            
          
            function move() {                // some time after call this page and load chart images  Refresh Code
                var time = 0;
                //      alert("vicky");
                var id = setInterval(frame, 10000);
                function frame() {
                    if (time == 1) {
                        clearInterval(id);
                    } else {
                        location.href = "Admin_dash_bord.jsp";
                        time++; 
                    }
                }
            }
            
            function limitallback(p,t,sq)
            {
                //       alert(p-1);
                //       alert(t);
                //       alert(sq);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Admin_manage_product_all.jsp?sq="+sq+"&page="+(p-1)+"&total="+t , true);
                xhttp.send();
            }
            
            
            function limitallnext(p,t,sq)
            {
                //        alert(p+1);
                //        alert(t);
                //         alert(sq);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Admin_manage_product_all.jsp?sq="+sq+"&page="+(p+1)+"&total="+t , true);
                xhttp.send();
            }
            
            
            
            
            function limitallbackspecial(p,t,sq)
            {
                //       alert(p-1);
                //       alert(t);
                //       alert(sq);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Admin_All_Special.jsp?sq="+sq+"&page="+(p-1)+"&total="+t , true);
                xhttp.send();
            }
            
            
            function limitallnextspecial(p,t,sq)
            {
                //        alert(p+1);
                //        alert(t);
                //         alert(sq);
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Admin_All_Special.jsp?sq="+sq+"&page="+(p+1)+"&total="+t , true);
                xhttp.send();
            }
            
            
            
            
            
            
            function refresh_year()
            {
                var xhttp;
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "Admin_year_graph.jsp?ref=true", true);
                xhttp.send(); 
                
                
                xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (xhttp.readyState== 4 && xhttp.status == 200) {
                        document.getElementById("middle").innerHTML = xhttp.responseText;
                    }
                };
                xhttp.open("GET", "loader.jsp", true);
                xhttp.send(); 
                
                
                move_year();       // Thread Wiil be Call But Chart is old Then Once Again Load This Page 
                
            }      
            
          
            function move_year() {                // some time after call this page and load chart images  Refresh Code
                var time = 0;
                //      alert("vicky");
                var id = setInterval(frame, 10000);
                function frame() {
                    if (time == 1) {
                        clearInterval(id);
                    } else {
                        
                        var xhttp;
                        xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() {
                            if (xhttp.readyState== 4 && xhttp.status == 200) {
                                document.getElementById("middle").innerHTML = xhttp.responseText;
                            }
                        };
                        xhttp.open("GET", "Admin_year_graph.jsp", true);
                        xhttp.send();
                        
                        time++; 
                    }
                }
            }
            
            
            
            
            
            
            
           
        </script>




    </script>


    <style type="text/css">

        #leftside {
            cursor: pointer;
            position: absolute;
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
            <div id = "contents">
                <!-- LeftSide -->

                <div id="leftside" class="grid_3">

                    <div>
                        <ul id="leftsideNav">
                            <li><a href="Admin_dash_bord.jsp" ><strong>Dash Home</strong></a></li>
                            <li><a target="_blank" href="Admin_add_new_product.jsp"><strong>Add Product</strong></a></li>
                            <li><a href="#" onclick="show('Admin_manage_category.jsp')"><strong>Manage Category</strong></a></li>
                            <li><a href="#" onclick="show('Admin_manage_subcategory.jsp')"><strong>Sub-Category</strong></a></li>
                            <li><a href="#" onclick="show('Admin_manage_product_all.jsp')"><strong>Manage Product</strong></a></li>
                            <li><a target="_blank" href="Admin_pendingOrders.jsp"><strong>Pending Orders</strong></a></li>
                            <li><a target="_blank" href="Admin_deliver_order.jsp"><strong>Approved Orders</strong></a></li>
                            <li><a target="_blank" href="Admin_finish_order.jsp"><strong>Delivered Orders</strong></a></li>
                            <li><a target="_blank" href="Admin_new_add.jsp"><strong>Add New Admin</strong></a></li>
                            <li><a href="#" onclick="show('Admin_All_Special.jsp')"><strong>Manage Special</strong></a></li>
                            <li><a href="#" onclick="show('Admin_year_graph.jsp')"><strong>Year wish Report</strong></a></li>
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


    <!-- footer here insert -->



</body>

<script>
        
    var xhttp;
    xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (xhttp.readyState== 4 && xhttp.status == 200) {
            document.getElementById("middle").innerHTML = xhttp.responseText;
        }
    };
    xhttp.open("GET", "top10_sold_product.jsp", true);
    xhttp.send();
        
</script>

</html>
