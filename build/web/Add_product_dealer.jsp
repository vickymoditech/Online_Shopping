<%-- 
    Document   : Add_product_dealer
    Created on : Apr 16, 2016, 10:47:45 PM
    Author     : Vicky
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SaiKiran BookStores</title>
    </head>
    <link rel="shortcut icon" href="images/logo/ico.ico"/>
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="css/text.css"/>
    <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
    <link rel="stylesheet" type="text/css" href="css/product.css"  />
    <link rel="stylesheet" type="text/css" href="css/styles.css"/>
    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/myScript.js"></script>



    <script langauge="javascript">
    
        function validation()
        {
            var fname = document.getElementById("txtfname").value;
            var lname = document.getElementById("lname").value;
            var mno = document.getElementById("mno").value;
            var add = document.getElementById("add").value;
            var country  = document.getElementById("country").value;
            var state = document.getElementById("state").value;
            var city = document.getElementById("city").value;
            var pincode = document.getElementById("pincode").value;
            var check = "true";
            document.getElementById("message1").innerHTML = " ";
            document.getElementById("messagefname").innerHTML = " ";
            document.getElementById("message2").innerHTML = " ";
            document.getElementById("message6").innerHTML = " ";
            var pass = document.getElementById("pass1").value;
            var pass1 = document.getElementById("pass2").value;
            
            
            if(fname.match(/^[A-Za-z]+$/))
            {
            }
            else
            {
                document.getElementById("messagefname").style.color = "red";
                document.getElementById("messagefname").innerHTML = "only characters are allowed";
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
            
            
            if(pass != pass1)
            {
                document.getElementById("messagepass").style.color = "red";
                document.getElementById("messagepass").innerHTML = "        Both passwords must match     ";
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

        <%@include file="includesPage/_search_navigationbar.jsp" %>

        <%@include file="includesPage/_facebookJoin.jsp" %>

        <div class="container_16">

            <div id="middle" class="grid_16">

                <div class="grid_16" id="whiteBox">

                    <div  class="grid_16">
                        <h1  style ="text-align: center; padding: 10px 0px 0px 0px;">Add New Dealer</h1><br/>
                    </div>

                    <div class="grid_15"  style="border-top: 5px #444 solid;">
                    </div>


                    <form method="post" action="RegisterServlet?type=dealer" onsubmit="return validation()" >

                        <!-- first Name -->
                        <center>

                            <br>
                            <br>

                            <table>

                                <tr>
                                    <td align="right">
                                        First Name
                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <input type="text" id="txtfname" name="fname" required/>
                                            <label id="messagefname"></label>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        Last Name

                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <input type="text" id="lname" name="lname" required/>
                                            <label id="message1"></label>
                                        </div>
                                    </td>
                                </tr>


                                <tr>
                                    <td align="right">
                                        Gender
                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <select name="gender" required>
                                                <option value="male">Male</option>
                                                <option value="female">Female</option>
                                            </select>
                                        </div>
                                    </td>
                                </tr>


                                <tr>
                                    <td align="right">
                                        Mobile No
                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <input type="text" id="mno" name="mobileNum" maxlength="10" required/>
                                            <label id="message2"></label>
                                        </div>
                                    </td>
                                </tr>


                                <tr>
                                    <td align="right">
                                        Address
                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <textarea name="address" id="add" required></textarea>
                                            <label id="messageadd"></label>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        Country
                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <input type="text" name="country" id="country" value="India" disabled/><br/>
                                            <label id="message3"></label>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        State
                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <input type="text" id="state" name="state" value="Gujarat" disabled/><br/>
                                            <label id="message4"></label>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        City

                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <input type="text" id="city" name="city" value="Surat"  disabled/><br>
                                            <label id="message5"></label>
                                        </div>

                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        Pin-code
                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <input type="text" id="pincode" name="pincode" maxlength="6" required/><br>
                                            <label id="message6"></label>
                                            
                                        </div>
                                    </td>
                                </tr>


                                <tr>
                                    <td align="right">
                                        Email
                                    </td>
                                    <td>
                                        <div class="grid_5">
                                            <input type="email" name="emailReg" required/>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        Password 
                                    </td>
                                    <td>
                                        <input type="password" id="pass1" name="passReg" required/>
                                    </td>
                                </tr>

                                <tr>
                                    <td align="right">
                                        Conform Password 
                                    </td>
                                    <td>
                                        <input type="password" id="pass2" name="passAgainReg" required/><br/><br/> 
                                        <input type="submit" id="greenBtn" value="Add Details"/>
                                    </td>
                                </tr>


                                <tr>
                                    <td>

                                    </td>
                                    <td>
                                        `   <label id="messagepass"></label>    
                                    </td>
                                </tr>

                            </table>

                        </center>
                    </form>

                </div>
            </div>

        </div>

        <jsp:include page="includesPage/_footer.jsp"></jsp:include>

    </body>
</html>
