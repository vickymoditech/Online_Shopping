<%-- 
    Document   : Admin_new_add
    Created on : Apr 29, 2016, 2:08:36 PM
    Author     : Vicky
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.*"%>
<%@page import="database.*"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>SaiKiran BookStores</title>
        <!-- Default Stylesheets -->
        <%@include file="includesPage/_stylesheets.jsp" %>

        <link rel="stylesheet" href="css/slider.css"  />

        <script type="text/javascript" src="js/jquery.js"></script>


        <script type="text/javascript" src="js/myScript.js"></script>

        <style type="text/css">
            .prodGrid {
                margin: 10px;
                margin-right: -12px;
                margin-left: 36px;
            }
        </style>

        <script>
            
            function checkname()
        {
            var fname = document.getElementById("fname").value;
                
            if(fname.match(/^[A-Za-z]+$/))
            {
                
            }
            else
            {
                document.getElementById("displaymsg").innerHTML = "only characters are allowed";
                return false;
            }
        }
            
            
        </script>



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





        <%@include file="includesPage/_search_navigationbar.jsp" %>

        <%@include file="includesPage/_facebookJoin.jsp" %>

        <!-- banner here include -->



        <div class="container_16">
            <div id = "contents">
                <!-- LeftSide -->


                <%
                    Database_connection obj_connection = new Database_connection();
                    Connection c = obj_connection.cnn;
                    Statement st = c.createStatement();
                    String getCategory = "select c_id,c_name from tbl_category";

                    ResultSet rs = st.executeQuery(getCategory);

                %>





            </div>

            <!-- Middle -->
            <span id="middle"class="grid_16">

                <div class="grid_16" id="productStrip"> 
                    <div class="ProductHeading">
                        <div class="grid_16" align="center">
                            <h2 class="heading"><center> Add New Admin !! </center></h2>
                        </div>
                    </div>
                    <div class="clear"></div>

                    <div id="productList"> 

                        <form  method="post" action="Admin_add"  name="Admin_add_new" onsubmit="return checkname()" >
                            <center>
                                <table>
                                    <tr>
                                        <td>
                                            <label>First Name</label>
                                        </td>
                                        <td>
                                            <label><input type="text" id="fname" name="fname" placeholder="john" maxlength="20" required/><br/></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label>Email</label>
                                        </td>
                                        <td>
                                            <label><input type="email" name="email" placeholder="john_lee@xyz.com" maxlength="30" required/><br/></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>

                                        </td>
                                        <td>
                                            <input type="submit" value="Submit" id="greenBtn" /><br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">

                                            <% if (request.getAttribute("msg") != null) {%>    

                                    <center> <label id="displaymsg"> <strong><font color="red"> <%= request.getAttribute("msg")%> </font></strong></label>  </center>

                                    <% }%>

                                    </td>
                                    </tr>
                                </table>
                            </center>
                        </form>
                    </div>
                </div>

            </span>
            <!--The Middle Content Div Closing -->
        </div>
        <!--The Center Content Div Closing -->

        <jsp:include page="includesPage/_footer.jsp"></jsp:include>

    </body>
</html>


