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



        <!--  <div class="container_16"> -->

        <div   class="grid_13" id="productStrip" >

            <div id="middle" class="grid_13">

                <!--   <div class="grid_16" id="whiteBox"> -->

                <div  class="grid_13">
                    <h1  style ="text-align: center; padding: 10px 0px 0px 0px;">All Product</h1><br/>
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

                        <%

                            Database_connection obj_connection = new Database_connection();
                            Connection cnn = obj_connection.cnn;
                            Statement st1 = cnn.createStatement();
                            ResultSet rs1 = st1.executeQuery("select c_id,c_name from tbl_category where status = 'true'");

                        %>


                        <div align="right">
                            <select id="d_Category" style="margin:  +2px" data-parsley-required="true"  onchange="d_cat(this.value)">
                                <option value="">select Category</option>
                                
                                <% while (rs1.next()) {%>

                                <option value="<%= rs1.getInt(1)%>"><%= rs1.getString(2)%></option>

                                <% }%>
                            </select>
                        </div> 

                        <% if (request.getParameter("cid") != null) {%>     

                        <div align="right">
                            <select id="d_sub" style="margin:  +2px" data-parsley-required="true"  onchange="d_sub(this.value)">
                                <option value="">select Sub-Category</option>

                                <%
                                    rs1 = st1.executeQuery("select sub_id,sub_name from tbl_sub_cat where c_id = " + request.getParameter("cid")+" and status = 'true'");
                                    while (rs1.next()) {%>

                                <option value="<%= rs1.getInt(1)%>"><%= rs1.getString(2)%></option>

                                <% }%>

                            </select>
                        </div>

                        <% }%>        

                    </div>
                </div>


                <div id="vicky"> 


                    <%

                    
                    // 1. default all product related page count and next page values send to the query String 
                    // 2. check the query String 
                    // 3. you can set the value of limit 
                    
                    
                    
                        Statement st = cnn.createStatement();
                        String productId = request.getParameter("pid");
                        String query = "";
                        int total_page = 0;
                        if (request.getParameter("sid") == null  || request.getParameter("sid").equals("nothing")) {

                            if (request.getParameter("total") == null && request.getParameter("page") == null) {
                             //   out.println("if part");
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
                           //     out.println("else in part");
                                int tmp_page = Integer.parseInt(request.getParameter("page"));
                                query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.status = 'true' limit "+ (tmp_page-1)*20 +",20";
                            }

                        } else {

                            if (request.getParameter("total") == null && request.getParameter("page") == null) {
                            //    out.println("select product if");
                                query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.sub_id =" + request.getParameter("sid") + " and tbl_product.status = 'true' limit 0,20";
                                Statement st2 = cnn.createStatement();
                                ResultSet rs2 = st2.executeQuery("select count(*) from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.sub_id =" + request.getParameter("sid")+" and tbl_product.status = 'true'");
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
                                query = "select p_company,p_name,c_name,sub_name,p_qty,p_price,p_desc,p_img,p_type,p_id from tbl_product,tbl_category,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_product.sub_id =" + request.getParameter("sid") + " and tbl_product.status = 'true' limit " + (tmp_page - 1) * 20 + ",20";
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

                            %>
                            <div class="clear"></div>


                            <div class="grid_13 <%= alert%>">

                                <div class="grid_2">
                                    <a href="Admin_manage_product.jsp?pid=<%=product_id%>"><img src="<%= image_name%>" /></a>
                                </div>
                                <div class="grid_6">
                                    <p id="info"><a href="Admin_manage_product.jsp?pid=<%=product_id%>"><h3><span class="blue"> <%=product_name%></span></h3></a>By <%= company_name%>

                                </div>
                                <div class="grid_4">
                                    <p>Rs.</p>
                                    <div class="grid_3" style="display: inline;">
                                        <h1 style="display: inline;"><%= price%></h1> <a target="_blank" href="Admin_manage_product.jsp?pid=<%= product_id%>" id="greenBtn" style="display: inline;"><strong>Add Your Price</strong></a> 
                                    </div>
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
                    String sid = "nothing";

                    if (request.getParameter("sid") != null) {
                        sid = request.getParameter("sid");
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

                    <a href="#" data-parsley-required="true" onclick="return limitallback(<%= 2%>,<%= total_page%>,'<%= sid%>')"> <img src="images/icons/prev_last.png" width="60px" height="30px"> </a>
                    <a href="#" data-parsley-required="true" onclick="return limitallback(<%= page_no%>,<%= total_page%>,'<%= sid%>')"> <img src="images/icons/prev.png" width="60px" height="30px"> </a>

                    <% }%>

                    <% if (total_page > page_no) {%>

                    <a href="#" data-parsley-required="true" onclick="return limitallnext(<%= page_no%>,<%= total_page%>,'<%= sid%>')"> <img src="images/icons/next.png" width="60px" height="30px" > </a>
                    <a href="#" data-parsley-required="true" onclick="return limitallnext(<%= total_page - 1%>,<%= total_page%>,'<%= sid%>')"> <img src="images/icons/next_last.png" width="60px" height="30px"> </a>  

                    <% }%>




                    <br>
                    <br>

                </div>



            </div>
        </div>

    </body>
</html>
