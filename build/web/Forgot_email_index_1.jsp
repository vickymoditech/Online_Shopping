<%-- 
    Document   : Forgot_email_index_1
    Created on : Mar 26, 2016, 12:29:13 PM
    Author     : DELL
--%>

<!DOCTYPE HTML>
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
        
      
    </head>
    <body>

        <%
            if (session.getAttribute("Tmp_Email") == null) {

                response.sendRedirect(request.getContextPath() + "/Forgot_email_index.jsp");
            }%>




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
            <div id = "contents">
                <!-- LeftSide -->

                <%
                    Database_connection obj_connection = new Database_connection();
                    Connection c = obj_connection.cnn;
                    Statement st = c.createStatement();
                    String getCategory = "select c_id,c_name from tbl_category where status = 'true'";

                    ResultSet rs = st.executeQuery(getCategory);

                %>
                <div id="leftside" class="grid_3">
                    <div>
                        <ul id="leftsideNav">
                            <li><a href="index.jsp"><strong>Home</strong></a></li>

                            <%
                                while (rs.next()) {
                                    int cid = rs.getInt(1);
                                    String category = rs.getString(2);
                                    if(category.equals("Special Offer")){ } else{

                            %>
                            <li><a href="viewProducts.jsp?id=<%= cid%>&c_name=<%= category%>"><strong><%= category%></strong></a></li>
                            <%
                                } }
                            %>

                        </ul>
                    </div>



                    <div class="adv">
                 <!--       <h2><br/>This is The Header of an Advertisement</h2>
                        <p>We offer Advertisement display here </p> -->
                    </div>
                </div>
            </div>

            <!-- Middle -->
            <span id="middle"class="grid_13">

                <jsp:include page="Forgot_email_code.jsp"></jsp:include>

            </span>
            <!--The Middle Content Div Closing -->
        </div>
        <!--The Center Content Div Closing -->

        <jsp:include page="includesPage/_footer.jsp"></jsp:include>

    </body>
</html>




