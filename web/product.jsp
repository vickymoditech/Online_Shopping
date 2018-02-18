
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*, database.*" %>
<%@ page import="database.*"%>

<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>SaiKiran BookStores</title>
        <link rel="shortcut icon" href="images/logo/ico.ico"/>

        <link rel="stylesheet" type="text/css" href="css/reset.css"/>
        <link rel="stylesheet" type="text/css" href="css/text.css"/>
        <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
        <link rel="stylesheet" type="text/css" href="css/styles.css"/>
        <link rel="stylesheet" type="text/css" href="css/product.css"  />

        <link rel="stylesheet" type="text/css" href="css/lightbox.css"  />

        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/lightbox.js"></script>


        <script type="text/javascript">
            
            
            
            function validation(str)
            {
                document.getElementById("msg").innerHTML = "  ";
                var v = document.getElementById("qty").value;
                var c = document.getElementById("add_to_cart");
                var i  = parseInt(document.getElementById("label_qty").textContent);
                
                
                if(v.match(/^[0-9]+$/))
                {
                }
                else
                {
                    document.getElementById("msg").style.color = "red";
                    document.getElementById("msg").innerHTML = " Invalid quantity ";
                    return false;
                }
                
                if(v <= 0)
                {
                    document.getElementById("msg").style.color = "red";
                    document.getElementById("msg").innerHTML = " Invalid quantity ";
                    return false;
                }
                
                
                if(v > i)
                {
                    document.getElementById("msg").style.color = "red";
                    document.getElementById("msg").innerHTML = " Please enter a quantity of "+ i +" or less ";
                    return false;
                }
                else
                {
                    c.setAttribute("href", "Add_to_cart.jsp?pid="+str+"&qty="+v);
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
        <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
        <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>

        <%

            Database_connection obj_connection = new Database_connection();
            Connection cnn = obj_connection.cnn;





            int id = Integer.parseInt(request.getParameter("id"));
            if (request.getParameter("id") == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {


                Statement st2 = cnn.createStatement();
                ResultSet rs2 = st2.executeQuery("select * from tbl_special_product where p_id = " + id);
                boolean b = false;
                while (rs2.next()) {
                    b = true;
                }
                if (b) {
                    Statement st3 = cnn.createStatement();
                    ResultSet rs3 = st3.executeQuery("select * from tbl_special_product where l_id = " + session.getAttribute("user"));
                    boolean login_check = true;
                    while (rs3.next()) {

                        login_check = false;

                    }
                    if (login_check) {

                        response.sendRedirect(request.getContextPath()+"/index.jsp");
                    }
                } //else {


                    int product_id = id;
                    String product_name = null, sub_category_name = null, category_name = null, company_name = null, summary = null, image_name = null;
                    int price = 0;
                    int p_qty = 0;



                    Statement st = cnn.createStatement();


                    String getProductQuery = "select p_id,p_name,p_price,p_desc,p_img,sub_name,c_name,p_company,p_qty from tbl_product,tbl_sub_cat,tbl_category where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and p_id = " + id;

                    ResultSet rs = st.executeQuery(getProductQuery);

                    while (rs.next()) {
                        //out.println(""+rs.getString("product-name"));
                        product_name = rs.getString(2);

                        price = rs.getInt(3);

                        summary = rs.getString(4);

                        image_name = rs.getString(5);

                        sub_category_name = rs.getString(6);

                        category_name = rs.getString(7);

                        company_name = rs.getString(8);

                        p_qty = rs.getInt(9);

                    }

        %>


        <div class="container_16">


            <div class="grid_16" id="productStrip">
                <div class="ProductHeading">
                    <div class="grid_16">
                        <h2 class="heading"><%= product_name%>- <%=company_name%> <%= category_name%></h2>
                    </div>
                </div>

                <div class="grid_10">
                    <div class="grid_10">
                        <br/>
                        <h5>Category :<a href="#"><span class="blue"><%= category_name%></span></a> > <a href="#"><span class="blue"><%= sub_category_name%></span></a></h5>
                        <div class="clear"></div>
                        <br/>
                        <h5>Priced At <span class="BigRed">Rs. <%= price%></span></h5>
                        <br/>
                        <label id="label_qty"> <%= p_qty%> </label> Quantity Available
                        <br/>

                        <%
                            if (session.getAttribute("admin") != null) {
                        %>

                        <a href="Admin_manage_product.jsp?pid=<%= product_id%>">
                            <div class="grid_1" id="buy">
                                <strong>Edit</strong>
                            </div>
                        </a>
                        <%
                            }
                        %>

                        <%
                            if (session.getAttribute("dealer") != null) {
                        %>

                        <a href="Admin_manage_product.jsp?pid=<%= product_id%>">
                            <div class="grid_1" id="buy">
                                <strong>Add Your Price</strong>
                            </div>
                        </a>
                        <%
                            }
                        %>






                        <a href="" id="add_to_cart" onclick="return validation(<%= product_id%>)">
                            <div class="grid_3" id="buy">
                                <strong>Buy This Product Now</strong>
                            </div>
                        </a>





                        <br/>

                        <input type="text" id="qty" name="user_qty" value="1"><br/>
                        <label id="msg"> </label>    



                        <br/>
                        <br/>

                        <h1>Summary Of this item</h1>
                        <div class="clear"></div>
                        <p>Summary of <%= product_name%>

                            <%= summary%>


                        <h1>Brief Description</h1>
                        <br/>
                        <table class="grid_6" id="descripTable">
                            <tr class="grid_6">
                                <td>Name:</td>
                                <td><%= product_name%></td>
                            </tr>
                            <tr class="grid_6">
                                <td>Category</td>
                                <td><%= category_name%></td>
                            </tr>
                            <tr class="grid_6">
                                <td>Sub-Category</td>
                                <td><%= sub_category_name%></td>
                            </tr>
                            <tr class="grid_6">
                                <td>Company </td>
                                <td><%= company_name%></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div  class="grid_5">
                    <div id="productImages">
                        <!-- Images with T are thumbs Images While with Q are The actual source Images -->

                        <img class="BigProductBox" alt="<%= product_name%>" src="<%= image_name%>" />

                        <div class="clear"></div>

                        <%
                            String getImages = "select d_img_name from tbl_display_img where p_id = " + product_id;

                            rs.close();

                            rs = st.executeQuery(getImages);

                            // GET THE REST OF THE PRODUCT IMAGES

                            while (rs.next()) {
                                image_name = rs.getString(1);

                        %>


                        <a href="<%= image_name%>" rel="lightbox[product]" title="Click on the right side of the image to move forward.">
                            <img class="SmallProductBox" alt="<%= image_name%> 1 of 8 thumb" src="<%= image_name%>" />
                        </a>

                        <%
                                    }

                                    // write A code to hit generate update query 

                             //   }
                            }
                        %>
                    </div>
                    <div class="clear"></div>

                </div>

            </div>


            <!-- includesPage/mainHeaders/topMostViewedProducts_5_1.jsp -->
        </div>



        <jsp:include page="includesPage/_footer.jsp"></jsp:include>



    </body>
</html>
