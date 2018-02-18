
<link rel="stylesheet" type="text/css" href="css/reset.css"/>
<link rel="stylesheet" type="text/css" href="css/text.css"/>
<link rel="stylesheet" type="text/css" href="css/960_16.css"/>
<link rel="stylesheet" type="text/css" href="css/product.css"  />

<link rel="stylesheet" type="text/css" href="css/lightbox.css"  />

<link rel="stylesheet" type="text/css" href="css/styles.css"/>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*"%>
<%
    String sqlSearch = "";
    if (request.getParameter("searchbar") != null) {
        String searchText = request.getParameter("searchbar");
        String searches[] = searchText.split(" ");
        if (searchText.length() >= 0) {


            sqlSearch = "select tbl_product.p_id,p_name,p_desc,p_price,p_img,p_company,sub_name,p_qty,tbl_product.sub_id from tbl_product,tbl_sub_cat where tbl_product.sub_id=tbl_sub_cat.sub_id and tbl_product.status = 'true' and ";


            if (searches.length <= 2) {
                for (int i = 0; i < searches.length; i++) {                 // check the length over the 2 digit after then searching
                    if (searches[i].trim().length() > 2) {
                        if (i == 0) {
                            sqlSearch += "p_name LIKE '%" + searches[i] + "%'";
                        } else {
                            sqlSearch += " and tbl_product.p_company LIKE '%" + searches[i] + "%'";
                        }
                    }

                }
            } else {
                String joint = "";
                for (int i = 0; i < searches.length; i++) {
                    if (searches[i].trim().length() > 1) 
                    {
                        joint += searches[i];
                        if(i<searches.length-1)
                        {
                            joint += " ";
                        }
                    }
                }
             //   out.println(joint);
             //   out.println(searches.length);
                sqlSearch += "p_name LIKE '%" + joint + "%'";
            //    out.println(sqlSearch);
            }
%>

<!-- Middle -->
<div class="container_16">
    <div class="grid_15 push_1">
        <div class="grid_14" id="whiteBox">

            <%


                Database_connection obj_connection = new Database_connection();
                Connection cnn = obj_connection.cnn;
                Statement st = cnn.createStatement();
                ResultSet rs = st.executeQuery(sqlSearch);

                while (rs.next()) {
                    int product_id = rs.getInt(1);

                    String product_name = rs.getString(2);

                    String summary = rs.getString(3);

                    int price = rs.getInt(4);

                    String image_name = rs.getString(5);

                    String company_name = rs.getString(6);

                    String sub_category_name = rs.getString(7);

                    int qty = rs.getInt(8);
                    
                    int sub_id = rs.getInt(9);
                    
                    
                    if(sub_id != 71) {
                    
                    
                    

            %>
            <div class="clear"></div>
            <div class="grid_2">

            </div>
            <div class="grid_14">
                <div class="grid_10">
                    <p id="info"> <a target="_blank" href="product.jsp?id=<%=product_id%>"><img src="<%= image_name%>" height="73" width="73" /></a> <br/> <%= product_name%> <br/> By <%= company_name%> <br/> sub_category_name <%= sub_category_name%> <br/> <span class="red">Rs. <%= price%></span></p>
                </div>

                <div class="grid_3">
                    <% if (qty > 0) {%>
                    <br/> <a style="margin-right: 10px;" href="Add_to_cart.jsp?pid=<%= product_id%>&qty=1" id="greenBtn"><strong>Add to cart</strong></a>
                    <% } else {%>
                    <ul  style="padding:10px 10px"><strong><span class="red">Out Of Stock</span></strong></ul>
                    <% }
                        if (session.getAttribute("admin") != null) {%>
                    <a style="margin-right: 10px;" href="Admin_manage_product.jsp?pid=<%= product_id%>" id="greenBtn"><strong>Edit</strong></a>
                    <a target="_blank" style="margin-right: 10px;" href="dealer_price_view.jsp?pid=<%= product_id%>&pname=<%= product_name%>" id="greenBtn"><strong>View All Dealer Price</strong></a>
                    <% }%>


                    <% if (session.getAttribute("dealer") != null) {%>
                    <a style="margin-right: 10px;" href="Admin_manage_product.jsp?pid=<%= product_id%>" id="greenBtn"><strong>Add Your Price</strong></a>
                    <% }%>

                </div>
            </div>
            <div class="clear"></div>
            <%
                           } }
                rs.close();
                st.close();
                cnn.close();

            %>


            <div class="clear"></div>
        </div></div>
</div>
<%
    }
%><%


    }
%>