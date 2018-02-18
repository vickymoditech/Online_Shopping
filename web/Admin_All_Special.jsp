<%-- 
    Document   : Admin_All_Special
    Created on : May 2, 2016, 10:04:24 AM
    Author     : Vicky
--%>
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



        <!--    <div class="container_16"> -->

        <div   class="grid_13" id="productStrip" >

            <div id="middle" class="grid_13">

                <!--       <div class="grid_16" id="whiteBox"> -->

                <div  class="grid_13">
                    <h1  style ="text-align: center; padding: 10px 0px 0px 0px;">All Special Product</h1><br/>
                </div>


                <style>
                    p {
                        margin: 10px 0px;
                    }
                </style>

                <div class="ProductHeading">
                    <div class="grid_12">
                        <h1 class="grid_8">

                        </h1>

                    </div>
                </div>


                <div id="vicky"> 


                    <%

                        Database_connection obj_connection = new Database_connection();
                        Connection cnn = obj_connection.cnn;
                        Statement st = cnn.createStatement();
                        String productId = request.getParameter("pid");
                        String query = "";
                        int total_page = 0;
                        if (request.getParameter("total") == null && request.getParameter("page") == null) {
                            //    out.println("select product if");
                            query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_category.c_name = 'Special Offer' and tbl_product.status = 'true' limit 0,20";
                            Statement st2 = cnn.createStatement();
                            ResultSet rs2 = st2.executeQuery("select count(*) from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_category.c_name='Special Offer' and tbl_product.status = 'true'");
                            while (rs2.next()) {
                                int tmp = rs2.getInt(1);
                                total_page = tmp / 20;
                                if (tmp % 20 != 0) {
                                    total_page++;
                                }
                            }
                        } else {
                            //    out.println("select product else");
                            int tmp_page = Integer.parseInt(request.getParameter("page"));
                            query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_category.c_name = 'Special Offer' and tbl_product.status = 'true' limit " + (tmp_page - 1) * 20 + ",20";
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

                                    String alert = "";

                                    if (qty < 5) {
                                        alert = "alert";
                                    }
                            %>
                            <div class="clear"></div>


                            <div class="grid_13 <%= alert%>">

                                <div class="grid_2">
                                    <a target="_blank" href="Admin_manage_special.jsp?pid=<%=product_id%>"><img src="<%= image_name%>" /></a>
                                </div>
                                <div class="grid_6">
                                    <p id="info"><a href="Admin_manage_product.jsp?pid=<%=product_id%>"><h3><span class="blue"> <%=product_name%></span></h3></a>By <%= company_name%><br/><span class="red">Rs. <%= price%></span></p>

                                </div>
                                <div class="grid_4">
                                    <p><%=sub_category_name%></p>
                                    <div class="grid_3" style="display: inline;">
                                        <h1 style="display: inline;"><%= qty%></h1> <a target="_blank" href="Admin_manage_product.jsp?pid=<%= product_id%>" id="greenBtn" style="display: inline;"><strong>Edit Product</strong></a> 
                                    </div>
                                    <a target="_blank" href="dealer_price_view.jsp?pid=<%= product_id%>&pname=<%= product_name%>" id="greenBtn" style="display: inline;"><strong>View All Dealer Price</strong></a>
                                    <p>Quantity</p>
                                </div>
                            </div>


                            <div class="clear"></div>
                            <%
                                }
                            %>
                        </div>
                    </div>

                </div>    

                <!--          </div> -->



                <%
                    int page_no = 0;
                    String sq = "nothing";

                    if (request.getParameter("sq") != null) {
                        sq = request.getParameter("sq");
                    }

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

                    <a href="#" data-parsley-required="true" onclick="return limitallbackspecial(<%= 2%>,<%= total_page%>,'<%= sq%>')"> <img src="images/icons/prev_last.png" width="60px" height="30px"> </a>
                    <a href="#" data-parsley-required="true" onclick="return limitallbackspecial(<%= page_no%>,<%= total_page%>,'<%= sq%>')"> <img src="images/icons/prev.png" width="60px" height="30px"> </a>

                    <% }%>

                    <% if (total_page > page_no) {%>

                    <a href="#" data-parsley-required="true" onclick="return limitallnextspecial(<%= page_no%>,<%= total_page%>,'<%= sq%>')"> <img src="images/icons/next.png" width="60px" height="30px" > </a>
                    <a href="#" data-parsley-required="true" onclick="return limitallnextspecial(<%= total_page - 1%>,<%= total_page%>,'<%= sq%>')"> <img src="images/icons/next_last.png" width="60px" height="30px"> </a>  

                    <% }%>




                    <br>
                    <br>

                </div>



            </div>
        </div>

    </body>
</html>
