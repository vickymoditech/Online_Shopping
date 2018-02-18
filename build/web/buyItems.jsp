<%-- 
    Document   : User_info
    Created on : Mar 27, 2016, 7:06:54 PM
    Author     : DELL
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

    <script langauge="javascript">
    
        function validation()
        {
            var fname = document.getElementById("fname").value;
            var mno = document.getElementById("mno").value;
            var add = document.getElementById("add").value;
            var pincode = document.getElementById("pincode").value;
            var check = "true";
            document.getElementById("message3").innerHTML = " ";
            document.getElementById("message").innerHTML = " ";
            document.getElementById("message2").innerHTML = " ";
            document.getElementById("message6").innerHTML = " ";
            
            if(fname.match(/^[A-Za-z]+$/))
            {
            }
            else
            {
                document.getElementById("message").style.color = "red";
                document.getElementById("message").innerHTML = "only characters are allowed";
                check = "false";
            }
            
            if(mno.match(/^[0-9]+$/))
            {
            }
            else
            {
                document.getElementById("message2").style.color = "red";
                document.getElementById("message2").innerHTML = "only Digit are allowed";
                check = "false";
            }
            
            if(pincode.match(/^[0-9]+$/))
            {
            }
            else
            {
                document.getElementById("message6").style.color = "red";
                document.getElementById("message6").innerHTML = "only Digit are allowed";
                check = "false";      
            }
            
            if(mno.length < 10)
            {
                document.getElementById("message2").style.color = "red";
                document.getElementById("message2").innerHTML = "Invalid Mobile Number";
                check = "false";
            }
            
            if(pincode.length < 6)
            {
                document.getElementById("message6").style.color = "red";
                document.getElementById("message6").innerHTML = "Invalid PinCode Number";
                check = "false";
            } 
            
            if(add.length < 10)
            {
                document.getElementById("message3").style.color = "red";
                document.getElementById("message3").innerHTML = "Invalid Address";
                check = "false";
            }
            
            
            if(check == "false")
            {
                return false;
            }
            
        }

    </script>




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

        <%
            //   user User;
            String email = null;
            if ((session.getAttribute("user") == null)) {
                response.sendRedirect("index.jsp");
            } else {

                String MobileNum = null;
                String Address = null;
                String Username = null;
                int pincode = 0;

                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                Statement st = cnn.createStatement();
                ResultSet rs = st.executeQuery("select u_fname,u_contact,u_add,u_pincode from tbl_user_detail where l_id=" + session.getAttribute("user"));
                while (rs.next()) {
                    Username = rs.getString(1);
                    MobileNum = rs.getString(2);
                    Address = rs.getString(3);
                    pincode = rs.getInt(4);
                }

        %>
        <div class="container_16">
            <%   HashMap<Integer, Cart> hm = (HashMap<Integer, Cart>) session.getAttribute("Cart");
                if (hm.size() != 0) {%>

            <div class="grid_16" id="whiteBox" style="padding: 10px;">
                <div class="grid_8">
                    <h1>Buy Items</h1> <br/>
                    <form method="post" action="Buy_items"  onsubmit="return validation()">
                        <div class="grid_2">
                            Name
                        </div>
                        <div class="grid_5">
                            <input type="text" id="fname" class="name"  name="name" maxlength="20" required/><br/>
                            <label id="message"></label>
                        </div>
                        <div class="clear"></div><br/>
                        <div class="grid_2">
                            Mobile No
                        </div>
                        <div class="grid_5">
                            <input type="text" id="mno" class="mobile" maxlength="10" name="mobile" required/><br/><br/>
                            <label id="message2"></label>
                        </div>
                        <div class="grid_2">
                            Address
                        </div>
                        <div class="grid_5">
                            <textarea class="address" id="add"  name="address" maxlength="50" required></textarea><br/><br/>
                            <label id="message3"></label>
                        </div>
                        <div class="grid_2">
                            Pincode
                        </div>
                        <div class="grid_5">
                            <input type="text" id="pincode" class="pincode"  maxlength="6" name="pincode" required/><br/><br/>
                            <label id="message6"></label>
                        </div>
                        <div class="grid_2">
                            City
                        </div>
                        <div class="grid_5">
                            <input  type="text" value="Surat" disabled/> We Do not accept any orders outside Surat
                        </div>
                        <div class="clear"></div><br/>
                        <div class="grid_5" >
                            <input  type="submit" id="greenBtn" value="Add Details"/>
                        </div>
                    </form>
                </div>
                <%
                    if (Address != null && MobileNum != null && Username != null) {
                %>
                <div class="grid_7 shippingAddress" id="useInfo">
                    <h1> <strong></strong>This is my Shipping Address</h1> <br/>
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
                        Address
                    </div>
                    <div class="grid_5">
                        <span id ="useAddress"><%= Address%></span> 
                    </div>
                    <div class="grid_1">
                        Pincode
                    </div>
                    <div class="grid_5">
                        <span id ="pincode"><%= pincode%></span> 
                    </div>
                    <div class="clear"></div>
                </div>
                <script type="text/javascript" src="js/jquery.js"></script>
                <script type="text/javascript">
                    $(document).ready(function (){
                        $('#useInfo').click(function (){
                            var userName = $('#userName').text();
                            var mobile = $('#mobile').text();
                            var address = $('#useAddress').text();
                            var pincode = $('#pincode').text();
                           
                            //alert (userName +" "+mobile+" "+address);
                            $('.name').attr('value', userName);
                            $('.address').attr('value', address);
                            $('.mobile').attr('value', mobile);
                            $('.pincode').attr('value', pincode);
          
                        });
                    });
                </script>
                <%
                } else {
                %>
                <div class="grid_7 shippingAddress">
                    <h1> <strong></strong>Add your Details for quick Checkout</h1>
                </div>
                <%                                                                     }

                } else {%>



                <div class="container_16">
                    <div class="grid_12 push_2" id="whiteBox">
                        <br/><h1>No Product Invoice to Display</h1><hr/><br/>
                    </div>
                </div>


                <%    }
                   }%>
            </div>
        </div>
    </body>
</html>
