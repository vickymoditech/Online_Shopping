
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.*"%>
<%@page import="Add_To_Cart.*"%>

<style type="text/css">
    .backRed {
        background: #CC0000;
        padding: 3px 7px;
        margin-right: 3px;
    }
</style>
<%
    {
        HashMap<Integer, Cart> hm = (HashMap<Integer, Cart>) session.getAttribute("Cart");

        int totalQty = hm.size();
        String email = "";
        String userName = null;
        int uid = (Integer) session.getAttribute("user");


        Database_connection obj_connection = new Database_connection();
        Connection cnn = obj_connection.cnn;
        Statement st = cnn.createStatement();
        ResultSet rs = st.executeQuery("select l_email,u_fname from tbl_login,tbl_user_detail where tbl_login.l_id = tbl_user_detail.l_id and tbl_login.l_id =" + session.getAttribute("user"));
        while (rs.next()) {
            email = rs.getString(1);
            userName = rs.getString(2);
        }

        String printName;                       // check form full feel or not 
        if (userName == null) {
            printName = email;               // not feel than email display
        } else {
            printName = userName;   // name display
        }
%>
<div id = "topWrapper">
    <div class="container_16">
        <div class="grid_16">
            <div id="logo" class="grid_6"> <a href="index.jsp"><img src="images/logo/icon.png" /></a>
            </div>
            <div class="grid_9" id="top">
                <ul>
                    <a href="LogoutServlet"><li id="greenBtn" class ="Btn showForm"><strong>Logout</strong></li></a> 

                    <a href="User_info.jsp"><li class ="Btn showForm"><%= printName%></li></a>

                    <%
                        if (session.getAttribute("admin") != null) {
                    %>
                    <a href="Admin_dash_bord.jsp"><li class ="Btn showForm">Administrator: </li></a>
                    <%                                    }
                    %>

                    <%
                        if (session.getAttribute("dealer") != null) {
                    %>
                    <a href="Dealer_dash_bord.jsp"><li class ="Btn showForm">Dealer: </li></a>
                    <%                                    }
                    %>





                    <a href="Add_to_cart.jsp"><li class ="Btn showForm"><span class="backRed"><%= totalQty%></span> in My Cart </li></a>


                    <%  if (session.getAttribute("admin") != null) {%>


                    <%  int total_low = 0;
                        int total_msg = 0;
                        int total_pending = 0;
                        int total_approve = 0;
                        ArrayList<String> msg = new ArrayList<String>();
                        String[] url = new String[10];

                        Statement st1 = cnn.createStatement();
                        ResultSet rs1 = st1.executeQuery("select count(*) from tbl_product where  status = 'true' and p_qty < 5");
                        while (rs1.next()) {
                            total_low = rs1.getInt(1);
                        }

                        if (total_low > 0) {
                            url[total_msg] = "Admin_dash_bord.jsp";
                            total_msg++;
                            msg.add("Total " + total_low + " Products are low quantity");

                        }

                        ResultSet rs2 = st1.executeQuery(" select count(*) from tbl_order where order_status = 'pending' and order_date = CURDATE();");
                        while (rs2.next()) {
                            total_pending = rs2.getInt(1);
                        }

                        if (total_pending > 0) {
                            url[total_msg] = "Admin_pendingOrders.jsp";
                            total_msg++;
                            msg.add("New " + total_pending + " Orders Pending Today");

                        }

                        ResultSet rs3 = st1.executeQuery(" select count(*) from tbl_order where order_status = 'approve' and order_date = CURDATE();");
                        while (rs3.next()) {
                            total_approve = rs3.getInt(1);
                        }

                        if (total_approve > 0) {
                            url[total_msg] = "Admin_deliver_order.jsp";
                            total_msg++;
                            msg.add("Total " + total_approve + " Orders Approve Today");

                        }
                         
                       Statement st2 = cnn.createStatement();
                        ResultSet resultset = st2.executeQuery("select p_name,tbl_special_product.p_id from tbl_product,tbl_special_product where tbl_product.p_id = tbl_special_product.p_id and tbl_special_product.l_id = " + session.getAttribute("user")+" and tbl_product.status = 'true'");
                        int total_special = 0;
                        while (resultset.next()) {
                            
                            msg.add("Special Offer for "+resultset.getString(1));
                            url[total_msg] = "product.jsp?id="+resultset.getInt(2);
                            total_msg ++;
                            
                        }
                        
                        


                    %>


                    <div class="dropdown">
                        <button class="dropbtn"><li class ="Btn"><span class="backRed"><%= total_msg%></span> Message </li></button>
                        <div class="dropdown-content">

                            <% Iterator i = msg.iterator();
                                int count = 0;
                                while (i.hasNext()) {
                            %>

                            <a href="<%= url[count]%>"><%= i.next()%></a>


                            <% count++;
                                }%>

                        </div>
                    </div>

                    <% } else {

                        ArrayList<String> p_name = new ArrayList<String>();
                        ArrayList<Integer> p_id = new ArrayList<Integer>();
                        Statement st1 = cnn.createStatement();
                        ResultSet rs1 = st1.executeQuery("select p_name,tbl_special_product.p_id from tbl_product,tbl_special_product where tbl_product.p_id = tbl_special_product.p_id and tbl_product.status = 'true' and tbl_special_product.l_id = " + session.getAttribute("user"));
                        int total_special = 0;
                        while (rs1.next()) {
                            
                            p_name.add(rs1.getString(1));
                            p_id.add(rs1.getInt(2));
                            total_special ++;
                            
                        }
                        
                        Iterator ipname = p_name.iterator();
                        Iterator ipid = p_id.iterator();
                        
                    %>


                    <div class="dropdown">
                        <button class="dropbtn"><li class ="Btn"><span class="backRed"><%= total_special %></span> Message </li></button>
                        <div class="dropdown-content">
                            
                            <% while(ipname.hasNext()) { %>
                        
                            
                            <a href="<%="product.jsp?id="+ipid.next()%>"> <%= "Special Offer for "+ipname.next() %> </a>
                        
                            <% } %>
                        
                        
                        </div>
                    </div>

                    <% }%>

                </ul>
            </div>
        </div>
    </div>
</div>
<% }%>