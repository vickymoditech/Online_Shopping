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
                    <h1  style ="text-align: center; padding: 10px 0px 0px 0px;">Manage Product</h1><br/>
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


                        <div align="right">
                            <select id="sortBy" style="margin:  +2px" data-parsley-required="true"  onchange="babu(this.value)">
                                <option value="">select Any One</option>
                                <option value="qa">Quantity Low to High</option>
                                <option  value="qd">Quantity High to Low</option>
                                <option value="pa">Price Low to High</option>
                                <option  value="pd">Price High to Low</option>
                            </select>
                        </div> 


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
                        if (request.getParameter("sq") == null || request.getParameter("sq").equals("nothing")) {

                            if (request.getParameter("total") == null && request.getParameter("page") == null) {
                                //    out.println("select product if");
                                query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' limit 0,20";
                                Statement st2 = cnn.createStatement();
                                ResultSet rs2 = st2.executeQuery("select count(*) from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true'");
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
                                query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' limit " + (tmp_page - 1) * 20 + ",20";
                            }





                        } else {
                            String tmp = request.getParameter("sq");
                            if (tmp.equals("qa")) {



                                if (request.getParameter("total") == null && request.getParameter("page") == null) {
                                    //    out.println("select product if");
                                    query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' order by tbl_product.p_qty asc limit 0,20";
                                    Statement st2 = cnn.createStatement();
                                    ResultSet rs2 = st2.executeQuery("select count(*) from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true'");
                                    while (rs2.next()) {
                                        int tmp1 = rs2.getInt(1);
                                        total_page = tmp1 / 20;
                                        if (tmp1 % 20 != 0) {
                                            total_page++;
                                        }
                                    }
                                } else {
                                    //    out.println("select product else");
                                    int tmp_page = Integer.parseInt(request.getParameter("page"));
                                    query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' order by tbl_product.p_qty asc limit " + (tmp_page - 1) * 20 + ",20";
                                }

                            }
                            if (tmp.equals("qd")) {


                                if (request.getParameter("total") == null && request.getParameter("page") == null) {
                                    //    out.println("select product if");
                                    query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' order by tbl_product.p_qty desc limit 0,20";
                                    Statement st2 = cnn.createStatement();
                                    ResultSet rs2 = st2.executeQuery("select count(*) from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true'");
                                    while (rs2.next()) {
                                        int tmp1 = rs2.getInt(1);
                                        total_page = tmp1 / 20;
                                        if (tmp1 % 20 != 0) {
                                            total_page++;
                                        }
                                    }
                                } else {
                                    //    out.println("select product else");
                                    int tmp_page = Integer.parseInt(request.getParameter("page"));
                                    query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' order by tbl_product.p_qty desc limit " + (tmp_page - 1) * 20 + ",20";
                                }

                            }
                            if (tmp.equals("pa")) {



                                if (request.getParameter("total") == null && request.getParameter("page") == null) {
                                    //    out.println("select product if");
                                    query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' order by tbl_product.p_price asc limit 0,20";
                                    Statement st2 = cnn.createStatement();
                                    ResultSet rs2 = st2.executeQuery("select count(*) from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true'");
                                    while (rs2.next()) {
                                        int tmp1 = rs2.getInt(1);
                                        total_page = tmp1 / 20;
                                        if (tmp1 % 20 != 0) {
                                            total_page++;
                                        }
                                    }
                                } else {
                                    //    out.println("select product else");
                                    int tmp_page = Integer.parseInt(request.getParameter("page"));
                                    query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' order by tbl_product.p_price asc limit " + (tmp_page - 1) * 20 + ",20";
                                }

                            }
                            if (tmp.equals("pd")) {


                                if (request.getParameter("total") == null && request.getParameter("page") == null) {
                                    //    out.println("select product if");
                                    query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' order by tbl_product.p_price desc limit 0,20";
                                    Statement st2 = cnn.createStatement();
                                    ResultSet rs2 = st2.executeQuery("select count(*) from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true'");
                                    while (rs2.next()) {
                                        int tmp1 = rs2.getInt(1);
                                        total_page = tmp1 / 20;
                                        if (tmp1 % 20 != 0) {
                                            total_page++;
                                        }
                                    }
                                } else {
                                    //    out.println("select product else");
                                    int tmp_page = Integer.parseInt(request.getParameter("page"));
                                    query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' order by tbl_product.p_price desc limit " + (tmp_page - 1) * 20 + ",20";
                                }

                            }
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
                                    <a target="_blank" href="Admin_manage_product.jsp?pid=<%=product_id%>"><img src="<%= image_name%>" /></a>
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

                    <a href="#" data-parsley-required="true" onclick="return limitallback(<%= 2%>,<%= total_page%>,'<%= sq%>')"> <img src="images/icons/prev_last.png" width="60px" height="30px"> </a>
                    <a href="#" data-parsley-required="true" onclick="return limitallback(<%= page_no%>,<%= total_page%>,'<%= sq%>')"> <img src="images/icons/prev.png" width="60px" height="30px"> </a>

                    <% }%>

                    <% if (total_page > page_no) {%>

                    <a href="#" data-parsley-required="true" onclick="return limitallnext(<%= page_no%>,<%= total_page%>,'<%= sq%>')"> <img src="images/icons/next.png" width="60px" height="30px" > </a>
                    <a href="#" data-parsley-required="true" onclick="return limitallnext(<%= total_page - 1%>,<%= total_page%>,'<%= sq%>')"> <img src="images/icons/next_last.png" width="60px" height="30px"> </a>  

                    <% }%>




                    <br>
                    <br>

                </div>



            </div>
        </div>

    </body>
</html>
