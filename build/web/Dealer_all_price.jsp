<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*"%>

<!DOCTYPE html>

<html>
    <head>
        <link rel="shortcut icon" href="images/logo/ico.ico"/>
        <link rel="stylesheet" type="text/css" href="css/reset.css"/>
        <link rel="stylesheet" type="text/css" href="css/text.css"/>
        <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
        <link rel="stylesheet" type="text/css" href="css/product.css"  />
        <link rel="stylesheet" type="text/css" href="css/styles.css"/>
        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/myScript.js"></script>



        <style type="text/css">
            .alert {
                box-shadow: +20px 0px 0px #C00;
            }
        </style>


        <style type="text/css">
            .prodGrid {
                margin: 10px;
                margin-right: -12px;
                margin-left: 36px;
            }
        </style>



    </head>
    <body>



        <!--     <div class="container_16"> -->

        <div   class="grid_13" id="productStrip" >

            <div id="middle" class="grid_13">




                <%
                    boolean b = false;
                    Database_connection obj_connection = new Database_connection();
                    Connection cnn = obj_connection.cnn;
                    Statement tmpst = cnn.createStatement();
                    ResultSet tmprs = tmpst.executeQuery("select * from tbl_dealer where l_id = " + session.getAttribute("dealer"));
                    while (tmprs.next()) {
                        b = true;
                    }
                %>



                <% if (b) {%>

                <div  class="grid_13">
                    <h1  style ="text-align: center; padding: 10px 0px 0px 0px;">All Your Price</h1><br/>
                </div>

                <% } else {%>


                <div  class="grid_13">
                    <h1  style ="text-align: center; padding: 10px 0px 0px 0px;"> Add Your Price </h1><br/>
                </div>


                <% }%>

                <style>
                    p {
                        margin: 10px 0px;
                    }
                </style>

                <div class="ProductHeading">
                    <div class="grid_12">
                        <h1 class="grid_8">

                        </h1>

                        <%



                            Statement st1 = cnn.createStatement();

                            if (request.getParameter("did") != null) {
                                st1.execute("delete from tbl_dealer where p_id = " + request.getParameter("did") + " and l_id = " + session.getAttribute("dealer"));
                            }




                        %>



                    </div>
                </div>


                <div id="vicky"> 


                    <%

                        Statement st = cnn.createStatement();
                        String query = "";
                        query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,tbl_product.p_id,tbl_dealer.d_price from tbl_product,tbl_category,tbl_sub_cat,tbl_dealer where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.p_id = tbl_dealer.p_id and tbl_dealer.l_id = " + session.getAttribute("dealer") + " and tbl_product.status = 'true' limit 0,10";
                        int total_page = 0;
                        if (request.getParameter("total") == null && request.getParameter("page") == null) {
                            Statement st2 = cnn.createStatement();
                            ResultSet rs1 = st2.executeQuery("select count(*) from tbl_product,tbl_category,tbl_sub_cat,tbl_dealer where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.p_id = tbl_dealer.p_id and tbl_dealer.l_id = " + session.getAttribute("dealer"));
                            while (rs1.next()) {
                                int tmp = rs1.getInt(1);
                                total_page = tmp / 10;
                                if (tmp % 10 != 0) {
                                    total_page++;
                                }
                            }
                        }
                        else
                        {
                            int tmp_page = Integer.parseInt(request.getParameter("page"));
                            query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,tbl_product.p_id,tbl_dealer.d_price from tbl_product,tbl_category,tbl_sub_cat,tbl_dealer where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.p_id = tbl_dealer.p_id and tbl_dealer.l_id = " + session.getAttribute("dealer") + " and status = 'true' limit "+ (tmp_page-1)*10 +",10";
                        }



                    %>



                    <div class="grid_16 productListing">
                        <div class="clear"></div>
                        <div id="productContent">

                            <%

                                //  String query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id";
                                ResultSet rs = st.executeQuery(query);

                                while (rs.next()) {
                                    int product_id = rs.getInt(10);

                                    String product_name = rs.getString(2);

                                    String sub_category_name = rs.getString(4);

                                    String category_name = rs.getString(3);

                                    String company_name = rs.getString(1);

                                    int price = rs.getInt(6);

                                    String summary = rs.getString(7);

                                    int qty = rs.getInt(5);

                                    String image_name = rs.getString(8);

                                    String type = rs.getString(9);

                                    int d_price = rs.getInt(11);

                                    String alert = "";

                            %>
                            <div class="clear"></div>



                            <div class="grid_13 <%= alert%>">

                                <div class="grid_2">
                                    <a href="Admin_manage_product.jsp?pid=<%=product_id%>"><img src="<%= image_name%>" /></a>
                                </div>
                                <div class="grid_6">
                                    <p id="info"><a href="Admin_manage_product.jsp?pid=<%=product_id%>"><h3><span class="blue"> <%=product_name%></span></h3></a>By <%= company_name%><br/><span class="red">Rs. <%= price%></span></p>

                                </div>
                                <div class="grid_4">
                                    <p>Your Rs.</p>
                                    <div class="grid_4" >
                                        <h1 style="display: inline;"><%= d_price%></h1> <a target="_blank" href="Admin_manage_product.jsp?pid=<%= product_id%>" id="greenBtn" style="display: inline;"><strong>Edit Your Price</strong></a>
                                    </div>
                                    <a href="#" id="greenBtn" onclick="return d_delete(<%= product_id%>)" style="display: inline;"><strong>[x] Delete</strong></a>
                                    <p>.</p>
                                </div>
                            </div>





                            <div class="clear"></div>
                            <%
                                }
                            %>
                        </div>
                    </div>

                </div>    





                <%
                    int page_no = 0;
                    if (request.getParameter("page") == null) {
                        page_no = 1;
                    } else {
                        page_no =
                                Integer.parseInt(request.getParameter("page"));
                        total_page =
                                Integer.parseInt(request.getParameter("total"));
                    }
                %>

               

                <div class="grid_13" align="center">
                    <div class="grid_12"  style="border-top: 1px #444 solid;"></div>
                    <br>



                    <% if (page_no > 1) {%>

                    <a href="#" data-parsley-required="true" onclick="return limitback(<%= 2 %>,<%= total_page %>)"> <img src="images/icons/prev_last.png" width="60px" height="30px"> </a>
                    <a href="#" data-parsley-required="true" onclick="return limitback(<%= page_no%>,<%= total_page %>)"> <img src="images/icons/prev.png" width="60px" height="30px"> </a>

                    <% }%>

                    <% if (total_page > page_no) {%>

                    <a href="#" data-parsley-required="true" onclick="return limitnext(<%= page_no%>,<%= total_page %>)"> <img src="images/icons/next.png" width="60px" height="30px" > </a>
                    <a href="#" data-parsley-required="true" onclick="return limitnext(<%= total_page-1 %>,<%= total_page %>)"> <img src="images/icons/next_last.png" width="60px" height="30px"> </a>  

                    <% }%>




                    <br>
                    <br>

                </div>

              





            </div>
        </div>

    </body>
</html>
