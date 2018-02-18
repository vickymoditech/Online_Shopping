<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*"%>

<style type="text/css">
    .prodGrid {
        margin: 10px;
        margin-right: -12px;
        margin-left: 36px;
    }
</style>

<%  int total_page = 0;
    {
        Database_connection obj_connection = new Database_connection();
        Connection cnn = obj_connection.cnn;
        Statement st = cnn.createStatement();
        String query = "";
        String cname = "";
        try {

            if (request.getParameter("id") != null) {
                query = "select tbl_product.p_id,p_name,p_desc,p_price,p_img,p_company,sub_name,p_qty,old_price from tbl_product,tbl_sub_cat where tbl_product.sub_id=tbl_sub_cat.sub_id and tbl_sub_cat.c_id=" + request.getParameter("id") + " and tbl_product.p_type='special' and tbl_product.status ='true'";
                cname = request.getParameter("c_name");
            } else {
                query = "select tbl_product.p_id,p_name,p_desc,p_price,p_img,p_company,sub_name,p_qty,old_price from tbl_product,tbl_sub_cat where tbl_product.sub_id=tbl_sub_cat.sub_id and tbl_product.sub_id=" + request.getParameter("sid") + " and tbl_product.status = 'true' limit 0,12";

                if (request.getParameter("page") != null) {
                    int pageno = Integer.parseInt(request.getParameter("page"));
                    query = "select tbl_product.p_id,p_name,p_desc,p_price,p_img,p_company,sub_name,p_qty,old_price from tbl_product,tbl_sub_cat where tbl_product.sub_id=tbl_sub_cat.sub_id and tbl_product.sub_id=" + request.getParameter("sid") + " and tbl_product.status = 'true' limit " + ((pageno - 1) * 12) + ",12";
                } else {

                    Statement st1 = cnn.createStatement();
                    ResultSet rs1 = st1.executeQuery("select count(*) from tbl_product where sub_id = " + request.getParameter("sid")+" and status = 'true'");
                    while (rs1.next()) {
                        int tmp = rs1.getInt(1);
                        total_page = tmp / 12;
                        if (tmp % 12 != 0) {
                            total_page++;
                        }
                    }
                }


                // login of product display 0-4,1*4-4,2*4-4 
                
                
                
                cname = request.getParameter("sc_name");
            }
%>


<div class="grid_13" id="productStrip"> 
    <div class="ProductHeading">
        <div class="grid_12">
            <h2 class="heading"><center> <%= cname%> Products </center></h2>
        </div>
    </div>
    <div class="clear"></div>


    <%

        ResultSet rs = st.executeQuery(query);
        while (rs.next()) {
            int pid = rs.getInt(1);
            String name = rs.getString(2);
            String company = rs.getString(6);
            String catagory = rs.getString(7);
            String imagename = rs.getString(5);
            int price = rs.getInt(4);
            int qty = rs.getInt(8);
            int old_price = rs.getInt(9);

    %>


    <div id="productList" class="grid_3 prodGrid"> 
        <a target="_blank" href="product.jsp?id=<%= pid%>"><img src="<%= imagename%>" /></a>
        <p id="info">
            <span class="red"><%= name%></span><br/>
            By <%= company%> <%= catagory%><br/>
            Available Quantity : <strong><span class="red"><%= qty%></span></strong> <br/> 
            <% if(old_price != 0){ %>
             <strong><font color="black" class="under_line"> Old Rs. <%= old_price %></font></strong><br>
            <% } else { %>
               <strong><font color="black" class="under_line"></font></strong><br>
             <% } %>
            <strong><span class="red">Rs. <%= price%></span></strong>
        </p>
        <% if (qty > 0) {%>
        <a href="Add_to_cart.jsp?pid=<%= pid%>&qty=1"><ul id="greenBtn"  class ="Btn" style="padding:10px 35px"><strong>Add To Cart</strong></ul></a>
        <% } else {%>
        <a href="#"><ul id="greenBtn"  class ="Btn" style="padding:10px 30px"><strong><font color="#f90606">Out Of Stock</font></strong></ul></a>
                    <% }%>
    </div>

    <%
                }
            } catch (Exception ex) {
                out.println(ex);
            }
        }%>






    <%
        int page_no = 0;
        if (request.getParameter("page") == null) {
            page_no = 1;
        } else {
            page_no = Integer.parseInt(request.getParameter("page"));
            total_page = Integer.parseInt(request.getParameter("total"));
        }
    %>

    <% if (request.getParameter("sid") != null) {%>

    <div class="grid_13" align="center">
        <div class="grid_12"  style="border-top: 1px #444 solid;"></div>
        <br>



        <% if (page_no > 1) {%>

        <a href="#" data-parsley-required="true" onclick="return limitback(<%= 2 %>,<%= request.getParameter("sid")%>,'<%= request.getParameter("sc_name")%>',<%= total_page%>)"> <img src="images/icons/prev_last.png" width="60px" height="30px"> </a>
        <a href="#" data-parsley-required="true" onclick="return limitback(<%= page_no%>,<%= request.getParameter("sid")%>,'<%= request.getParameter("sc_name")%>',<%= total_page%>)"> <img src="images/icons/prev.png" width="60px" height="30px"> </a>

        <% }%>

        <% if (total_page > page_no) {%>

        <a href="#" data-parsley-required="true" onclick="return limitnext(<%= page_no%>,<%= request.getParameter("sid")%>,'<%= request.getParameter("sc_name")%>',<%= total_page%>)"> <img src="images/icons/next.png" width="60px" height="30px" > </a>
        <a href="#" data-parsley-required="true" onclick="return limitnext(<%= total_page-1 %>,<%= request.getParameter("sid")%>,'<%= request.getParameter("sc_name")%>',<%= total_page%>)"> <img src="images/icons/next_last.png" width="60px" height="30px"> </a>  

        <% }%>




        <br>
        <br>

    </div>

    <% }%>

</div>



