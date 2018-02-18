<%-- 
    Document   : User_info
    Created on : Mar 27, 2016, 7:06:54 PM
    Author     : DELL
--%>

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
        <link rel="stylesheet" type="text/css" href="css/product.css"  />

        <link rel="stylesheet" type="text/css" href="css/lightbox.css"  />

        <link rel="stylesheet" type="text/css" href="css/styles.css"/>

        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/lightbox.js"></script>
        <script src="js/myScript.js"></script>

        <script langauge="javascript">
    
            function check()
        {
            var pass = document.getElementById("p1").value;
            var pass1 = document.getElementById("p2").value;
            if(pass != pass1)
            {
                document.getElementById("messagepass").style.color = "red";
                document.getElementById("messagepass").innerHTML = "        Both passwords must match     ";
                return false;
            }
            else
            {
                alert("password successfully changed");
                return true;
            }
        }
    
        </script>

        <script langauge="javascript">
    
        function validation()
        {
            var fname = document.getElementById("fname").value;
            var lname = document.getElementById("lname").value;
            var mno = document.getElementById("mno").value;
            var add = document.getElementById("add").value;
            var country  = document.getElementById("country").value;
            var state = document.getElementById("state").value;
            var city = document.getElementById("city").value;
            var pincode = document.getElementById("pincode").value;
            var check = "true";
            document.getElementById("message1").innerHTML = " ";
            document.getElementById("message").innerHTML = " ";
            document.getElementById("message2").innerHTML = " ";
            document.getElementById("message6").innerHTML = " ";
            document.getElementById("messageadd").innerHTML = " ";
            
            if(fname.match(/^[A-Za-z]+$/))
            {
            }
            else
            {
                document.getElementById("message").style.color = "red";
                document.getElementById("message").innerHTML = "only characters are allowed";
                check = "false";
            }
            
            if(lname.match(/^[A-Za-z]+$/))
            {
            }
            else
            {
                document.getElementById("message1").style.color = "red";
                document.getElementById("message1").innerHTML = "only characters are allowed";
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
                document.getElementById("messageadd").style.color = "red";
                document.getElementById("messageadd").innerHTML = "Invalid Address";
                check = "false";
            }
            
            
            
            if(check == "false")
            {
                return false;
            }
            
        }

        </script>






        <style type="text/css">

            #leftside {
                cursor: pointer;
                position: fixed;
            }
        </style>
        <script type="text/javascript">
        $(document).ready(function (){
            var MyOrders = $('#MyOrders');
            var MyAccount = $('#Account');
            var MySettings = $('#Settings');
            var MyUserInfo = $('#userInfo');
                
            var Orders = $('.MyOrders');
            var Account = $('.Account');
            var Settings = $('.Settings');
                
            Orders.slideDown(0);
            Account.slideUp(0);
            Settings.slideUp(0);
                
                
            MyOrders.click(function (){
                Orders.slideDown(700);
                Account.slideUp(700);
                Settings.slideUp(700);
            });
            MyAccount.click(function (){
                Orders.slideUp(700);
                Account.slideDown(700);
                Settings.slideUp(700);
            });
            MySettings.click(function (){
                Orders.slideUp(700);
                Account.slideUp(700);
                Settings.slideDown(700);
            });
            MyUserInfo.click(function (){
                Orders.slideDown(700);
                Account.slideDown(700);
                Settings.slideDown(700);
            });
                
        });
        </script>

    </head>
    <body>

        <%
            if (session.getAttribute("user") == null) {                   // THen new user, show join now

                response.sendRedirect(request.getContextPath() + "/index.jsp");

            } else {
        %>

        <jsp:include page="includesPage/_logout.jsp"></jsp:include>

        <% }%>

        <% {
                String userName = null;
                String email = null;
                String ulname = null;

                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                Statement st = cnn.createStatement();
                ResultSet rs = st.executeQuery("select l_email,u_fname,u_lname from tbl_login,tbl_user_detail where tbl_login.l_id = tbl_user_detail.l_id and tbl_login.l_id =" + session.getAttribute("user"));
                while (rs.next()) {
                    email = rs.getString(1);
                    userName = rs.getString(2);
                    ulname = rs.getString(3);
                }

                String printName;                       // check form full feel or not 
                if (userName == null) {
                    printName = email;               // not feel than email display
                } else {
                    printName = userName;   // name display
                }
        %>

        <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
        <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>

            <div class="container_16">
                <div id="leftside" class="grid_3">
                    <ul id="leftsideNav">
                        <li><a id="userInfo"><strong>User Profile</strong></a></li>

                        <li><a id="Account"><strong>Account</strong></a></li>
                        <li><a id="MyOrders"><strong>My Orders</strong></a></li>
                        <li><a id="Settings"><strong>Settings</strong></a></li>
                    </ul>
                </div>
                <div class="grid_13 push_3" id="whiteBox">
                    <div  class="grid_13">
                        <h1  style ="text-align: center; padding: 10px 0px 0px 0px;">Hello <%= printName%></h1>  
                    <p  style ="text-align: center;"> 
                        Enter in the personal information for your Account to have quick checkouts during any transaction 
                    </p>
                </div>
            </div>


            <div id="whiteBox" class="grid_13 push_3">

                <div  style ="text-align: center; border-top: 20px #444 solid; padding: 10px 0px 10px 0px;" class="grid_12 MyOrders">

                    <h1 style ="padding: 10px 0px 10px 0px;">My Orders</h1>  

                    <div id="CartTable" style="padding:10px 00px" class="grid_12">
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
                            rs = st.executeQuery(" select o_id,order_date from tbl_order where l_id="+session.getAttribute("user")+" order by o_id desc");
                            while(rs.next())
                            {
                                billno = rs.getInt(1);
                                order_date = rs.getString(2);
                            
                            
                                               
                        %>
                        

                        <div class="grid_12"  style="border-top: 2px #444 solid;">
                            <div  class="grid_1">
                                <a class="blue" href="showMyBill.jsp?oid=<%= billno %>"><font color="red"><%= billno %></font></a>
                            </div>

<%

   // joint query write here tbl_oder_detail and tbl_product joint id = p_id
    Statement st1 = cnn.createStatement();
    ResultSet rs1;
    int count = 1;
    rs1 = st1.executeQuery(" select p_name,p_price,user_qty from tbl_product,tbl_order_detail where tbl_product.p_id = tbl_order_detail.p_id and o_id="+billno);
    while(rs1.next())
               {
                String p_name = rs1.getString(1);
                int p_price = rs1.getInt(2);
                int user_qty = rs1.getInt(3);
%>                                                                       
                            

                            <!-- second item -->

                            <div class="grid_12">
                                <div class="push_1">
                                    <div class="grid_7">
                                        <div class="grid_4 ">
                                            <%= p_name %> 
                                        </div>
                                        <div class="grid_2">
                                            Rs. <%= p_price %> x<%= user_qty %>
                                        </div>
                                    </div>
                                    <div class="grid_3">
                                        <%= order_date %>
                                    </div>
                            </div>
                            </div>
                                    
                          <%  } %>          

                        </div>
                          <% } %>
                    </div>
                </div>

                <!-- user info -->

                <% if (userName == null) {%>

                <div class="clear"></div>
                <div  style ="text-align: center; border-top: 20px #444 solid; padding: 10px 0px 10px 0px;" class="grid_9 push_1 Account">
                    <h1 style ="padding: 10px 0px 10px 0px;">User Account</h1>  

                    <form method="post" action="addUserDetalsServlet" onsubmit="return validation()" >

                        <!-- first Name -->

                        <div class="grid_3">
                            First Name
                        </div>
                        <div class="grid_5">
                            <input type="text" id="fname" name="fname" maxlength="20" required/>
                             <label id="message"></label>
                        </div>
                        <div class="clear"></div><br/>

                        <!-- Last Name -->

                        <div class="grid_3">
                            Last Name
                        </div>
                        <div class="grid_5">
                            <input type="text" id="lname" name="lname" maxlength="20" required/>
                             <label id="message1"></label>
                        </div>
                        <div class="clear"></div><br/>

                        <!-- Gender -->

                        <div class="grid_3">
                            Gender
                        </div>
                        <div class="grid_5">
                            <select name="gender" required>
                                <option value="male">Male</option>
                                <option value="female">Female</option>
                            </select>
                        </div>
                        <div class="clear"></div><br/>

                        <!-- Mobile No -->

                        <div class="grid_3">
                            Mobile No
                        </div>
                        <div class="grid_5">
                            <input type="text" id="mno" name="mobileNum" maxlength="10" required/>
                             <label id="message2"></label>
                        </div>
                        <div class="clear"></div><br/>


                        <!-- Address -->

                        <div class="grid_3">
                            Address
                        </div>
                        <div class="grid_5">
                            <textarea name="address" id="add" maxlength="50" required></textarea>
                            <label id="messageadd"></label>
                        </div>
                        <div class="clear"></div><br/>


                        <div class="grid_3">
                            Country
                        </div>
                        <div class="grid_5">
                            <input type="text" name="country" value="India" id="country" disabled/><br/>
                             <label id="message3"></label>
                        </div>
                        <div class="clear"></div><br/>


                        <!-- State of Country -->

                        <div class="grid_3">
                            State
                        </div>
                        <div class="grid_5">
                            <input type="text" id="state" name="state" value="Gujarat" disabled/><br/>
                             <label id="message4"></label>
                        </div>
                        <div class="clear"></div><br/>


                        <!-- City -->

                        <div class="grid_3">
                            City
                        </div>
                        <div class="grid_5">
                            <input type="text" id="city" name="city" value="Surat"  disabled/>
                             <label id="message5"></label>
                        </div>
                        <div class="clear"></div><br/>

                        <div class="grid_3">
                            Pin-code
                        </div>
                        <div class="grid_5">
                            <input type="text" id="pincode" name="pincode" maxlength="6" required/>
                             <label id="message6"></label>
                            <br/> <br/>
                            <input type="submit" id="greenBtn" value="Add Details"/>
                        </div>
                        <div class="clear"></div><br/>
                    </form>

                </div>
                <div class="clear"></div>


                <% } else {

                    String fname = "";
                    String lname = "";
                    String add = "";
                    String city = "";
                    String state = "";
                    String country = "";
                    String contact = "";
                    String gen = "";

                    int pincode = 0;

                    rs = st.executeQuery("select * from tbl_user_detail where l_id = " + session.getAttribute("user"));
                    while (rs.next()) {

                        fname = rs.getString(3);
                        lname = rs.getString(4);
                        gen = rs.getString(5);
                        contact = rs.getString(6);
                        add = rs.getString(7);
                        city = rs.getString(8);
                        state = rs.getString(9);
                        country = rs.getString(10);
                        pincode = rs.getInt(11);
                    }
                    if(lname==null && gen==null && contact==null && add==null && pincode==0)
                    {
                        lname = "";
                        gen = "male";
                        contact = "";
                        add = "";
                 
                    }

                %>


                <div class="clear"></div>
                <div  style ="text-align: center; border-top: 20px #444 solid; padding: 10px 0px 10px 0px;" class="grid_9 push_1 Account">
                    <h1 style ="padding: 10px 0px 10px 0px;">User Account</h1>  

                    <form method="post" action="addUserDetalsServlet" onsubmit="return validation()" >

                        <!-- first Name -->

                        <div class="grid_3">
                            First Name
                        </div>
                        <div class="grid_5">
                            <input type="text" id="fname" name="fname" value="<%= fname%>" required/>
                             <label id="message"></label>
                        </div>
                        <div class="clear"></div><br/>

                        <!-- Last Name -->

                        <div class="grid_3">
                            Last Name
                        </div>
                        <div class="grid_5">
                            <input type="text" id="lname" name="lname" value="<%= lname%>" required/>
                            <label id="message1"></label>
                        </div>
                        <div class="clear"></div><br/>

                        <!-- Gender -->

                        <div class="grid_3">
                            Gender
                        </div>
                        <div class="grid_5">
                            <select name="gender" required>

                                <% if (gen.equals("male")) {%>

                                <option value="male" selected>Male</option>
                                <option value="female">Female</option>

                                <% } else {%>

                                <option value="male" >Male</option>
                                <option value="female" selected>Female</option>

                                <% }%>
                            </select>
                        </div>
                        <div class="clear"></div><br/>

                        <!-- Mobile No -->

                        <div class="grid_3">
                            Mobile No
                        </div>
                        <div class="grid_5">
                            <input type="text" id="mno" name="mobileNum" maxlength="10" value="<%= contact%>" required/>
                            <label id="message2"></label>
                        </div>
                        <div class="clear"></div><br/>


                        <!-- Address -->

                        <div class="grid_3">
                            Address
                        </div>
                        <div class="grid_5">
                            <textarea name="address" id="add" required><%=add%></textarea>
                            <label id="messageadd"></label>
                        </div>
                        <div class="clear"></div><br/>


                        <div class="grid_3">
                            Country
                        </div>
                        <div class="grid_5">
                            <input type="text" id="country" name="country" value="<%= "India"%>" required/><br/>
                            <label id="message3"></label>
                        </div>
                        <div class="clear"></div><br/>


                        <!-- State of Country -->

                        <div class="grid_3">
                            State
                        </div>
                        <div class="grid_5">
                            <input type="text" id="state" name="state" value="<%= "Gujarat"%>" required/><br/>
                            <label id="message4"></label>
                        </div>
                        <div class="clear"></div><br/>


                        <!-- City -->

                        <div class="grid_3">
                            City
                        </div>
                        <div class="grid_5">
                            <input type="text" id="city" name="city" value="<%= "Surat"%>"  required/>
                            <label id="message5"></label>
                        </div>
                        <div class="clear"></div><br/>

                        <div class="grid_3">
                            Pin-code
                        </div>
                        <div class="grid_5">
                            <input type="text" id="pincode" name="pincode" value="<%= pincode%>" maxlength="6" required/>
                            <label id="message6"></label>
                            <br/> <br/>
                            <input type="submit" id="greenBtn" value="Add Details"/>
                        </div>
                        <div class="clear"></div><br/>
                    </form>

                </div>
                <div class="clear"></div>



                <% }%>

                <!-- change the password -->        



                <div  style ="text-align: center; border-top: 20px #444 solid; padding: 10px 0px 10px 0px;" class="grid_9 push_1 Settings">

                    <h1 style ="padding: 10px 0px 10px 0px;">Settings</h1>  

                    <form method="post" action="ChangeMyPass" onsubmit="return check()">
                        <div class="grid_3">
                            Email 
                        </div>
                        <div class="grid_5">
                            <input type="text" name="cemail" value="<%= email%>" readonly />
                        </div>
                        <div class="clear"></div><br/>
                        <div class="grid_3">
                            Password
                        </div>
                        <div class="grid_5">
                            <input type="password" id="p1" name="pass" maxlength="20" required/><br/><br/> 
                        </div>
                        <div class="grid_3">
                            Conform Password
                        </div>
                        <div class="grid_5">
                            <input type="password" id="p2" name="cpass" maxlength="20" required/><br/><br/> 
                            <input id="greenBtn" type="submit" value="Change My Password"/>
                        </div>
                        <div class="clear"></div><br/>

                        <div class="grid_3">

                        </div>
                        <div class="grid_5">
                            <label id="messagepass"></label>
                        </div>


                    </form>
                </div>
                <div class="clear"></div>


            </div>
        </div>
        <% }%>
        <jsp:include page="includesPage/_footer.jsp"></jsp:include>

    </body>
</html>



