<%-- 
    Document   : Add_to_cart
    Created on : Apr 3, 2016, 5:53:50 PM
    Author     : DELL
--%>

<%@page import="sun.misc.REException"%>
<%@page import="Add_To_Cart.Cart"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>SaiKiran BookStores - Cart</title>
        <!-- Default Stylesheets -->
        <link rel="shortcut icon" href="images/logo/ico.ico"/>

        <link rel="stylesheet" type="text/css" href="css/reset.css"/>
        <link rel="stylesheet" type="text/css" href="css/text.css"/>
        <link rel="stylesheet" type="text/css" href="css/960_16.css"/>
        <link rel="stylesheet" type="text/css" href="css/styles.css"/>
        <link rel="stylesheet" type="text/css" href="css/product.css"  />

        <script type="text/javascript" src="js/jquery.js"></script>

        <script type="text/javascript" src="js/myScript.js"></script>

        <script type="text/javascript">
            
            
            
            function validation(p_id,a_qty,index)
            {
              
                
                var u_qty = parseInt(document.getElementById("qty"+index).value);
                var v =  document.getElementById("qty"+index).value;
                var c = document.getElementById("edit"+index);
               
                if(v.match(/^[0-9]+$/))
                {
                }else{
                    document.getElementById("msg"+index).style.color = "red";
                    document.getElementById("msg"+index).innerHTML = " Invalid quantity ";
                    return false;
                }
               
               
               
                if(u_qty <= 0)
                {
                    document.getElementById("msg"+index).style.color = "red";
                    document.getElementById("msg"+index).innerHTML = " Invalid quantity ";
                    return false;
                }  
                
                
                if(u_qty > a_qty)
                {
                    document.getElementById("msg"+index).style.color = "red";
                    document.getElementById("msg"+index).innerHTML = " Please enter a quantity of "+ a_qty +" or less ";
                    return false;
                }
                else
                {
                    document.getElementById("msg"+index).innerHTML = "  ";
                    c.setAttribute("href", "Add_to_cart.jsp?pid="+p_id+"&cqty="+u_qty);
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

        <div class="container_16">
            <div class="grid_16" id="whiteBox">
                <div class="grid_8 push_3" >
                    <h1 class="push_2" style="padding:15px 60px">Products In your Cart</h1>

                    <%
                        if (session.getAttribute("user") == null) {
                    %>

                    <a href="#" id="join"><ul id="greenBtn"  class ="Btn showForm" style="padding:15px 80px"><strong>Please Login before buying...</strong></ul></a>


                    <%                } else {%>

                    <h3 class="push_2" style="padding:15px 60px" >Your Cart contains following...</h3>
                    <hr style="padding:00px 300px">


                    <%

                        // Write A code to display your Cart item 
                        //1. Add to cart button send id 
                        //2. data will fetch and add into hashMap
                        //3. total HashMap Related Item Will Be display


                        try {


                            HashMap<Integer, Cart> hm = (HashMap<Integer, Cart>) session.getAttribute("Cart");


                            int grand_total = 0;
                            String pid = request.getParameter("pid");
                            int id;
                            if (request.getParameter("pid") != null) {
                                boolean b = true;
                                String referer = request.getHeader("Referer");
                                if (referer.endsWith("LoginServlet") || referer.endsWith("RegisterServlet") || referer.startsWith("http://localhost:8080/Online_Shoping_java/Add_to_cart.jsp") || referer.startsWith("http://node14216-env-6807403.underjelastic.com.br/Add_to_cart.jsp")) {
                                    if (referer.equals(session.getAttribute("back_to_page").toString())) {
                                        session.setAttribute("back_to_page", "index.jsp");
                                    }

                                } else {



                                    session.setAttribute("back_to_page", referer);

                                }



                                String product_name = "";
                                int price = 0;
                                int total_price = 0;
                                int qty = 0;


                                if (request.getParameter("qty") != null) {
                                    qty = Integer.parseInt(request.getParameter("qty"));
                                    for (int i : hm.keySet()) {
                                        if (i == Integer.parseInt(request.getParameter("pid"))) {
                                            b = false;
                                        }
                                    }
                                } else {
                                    qty = Integer.parseInt(request.getParameter("cqty"));
                                }


                                id = Integer.parseInt(pid);

                                int oldsize = hm.size();
                                Database_connection obj_connection = new Database_connection();
                                Connection cnn = obj_connection.cnn;
                                Statement st = cnn.createStatement();
                                ResultSet rs = st.executeQuery("select * from tbl_product where p_id=" + pid);
                                while (rs.next()) {
                                    int tmp = rs.getInt(1);
                                    product_name = rs.getString(3);
                                    price = rs.getInt(5);
                                    if (b) {
                                        hm.put(tmp, new Cart(tmp, rs.getString(3), price, qty, rs.getString(7), rs.getString(8), rs.getInt(6)));
                                    }
                                }

                                int newsize = hm.size();


                                if (oldsize != newsize) {
                                    out.println("Product  <strong><font color='red'> " + product_name + " </strong></font> added !! with price of   <strong><font color='red'> " + qty * price + "</font></strong> <br/><br/> ");
                                } else {

                                    if (request.getParameter("cqty") != null) {
                                    } else {

                                        out.println("<strong><font color='red'>" + product_name + "</font></strong> All Ready added !! <strong><font color='red'> You can Change Product Quantity... </font></strong> <br/> <br/>");
                                    }
                                }

                            }

                            if (request.getParameter("r_pid") != null) {
                                int remove = Integer.parseInt(request.getParameter("r_pid"));
                                hm.remove(remove);
                            }


                    %>


                    <div>

                        <table width="150%">
                            <tr>
                                <td></td>
                                <td><h2>Name Of Product</h2></td>
                                <td><h2>Price</h2></td>
                                <td  colspan="2"><h2>Quantity</h2></td>
                                <td></td>
                            </tr>



                            <%
                                int index = 0;
                                for (int i : hm.keySet()) {
                                    Cart full_cart = (Cart) hm.get(i);
                                    grand_total += (full_cart.p_qty * full_cart.p_price);
                                    index++;

                            %>

                            <tr>
                                <td> <%= index%> <image src="<%= full_cart.p_img%>" height="73" width="73" /> </td>
                                <td> <%= full_cart.p_name%> </td>
                                <td> Rs.<%= full_cart.p_price%> </td>
                                <td> x<%= full_cart.p_qty%> </td>
                                <td> <%= Math.ceil((full_cart.p_qty) * (full_cart.p_price))%>  </td>
                                <td> <a href="Add_to_cart.jsp?r_pid=<%= full_cart.pid%>" onclick ="return confirm('Are you sure Rome this Item?')"><ui id="greenBtn"  class ="Btn showForm"><strong>Remove</strong></ui></a> 
                                    <a href="" id="<%= "edit" + index%>" onclick="return validation(<%= full_cart.pid%>,<%= full_cart.product_qty%>,<%= index%>)" ><ui id="greenBtn"  class ="Btn showForm"><strong>Edit</strong></ui></a> 
                                    <br/>
                                    <label id="label_qty"> <%= full_cart.product_qty%> </label> Quantity Available
                                    <br/>
                                    <input type="text" id="<%= "qty" + index%>" name="user_qty"  value="<%= full_cart.p_qty%>" ><br/>
                                    <label id="<%= "msg" + index%>"> </label> 
                                </td>
                            </tr>


                            <%
                                }

                            %>

                            <tr>
                                <td></td>
                                <td colspan="3"><strong>Total Price of your Cart</strong></td>
                                <td><%= Math.ceil(grand_total)%></td>
                                <td></td>
                            </tr>

                        </table>
                        <div class="clear"></div>



                        <br/>
                        <br/>


                        <% if (hm.size() != 0) {%>

                        <a href="buyItems.jsp">
                            <div class="grid_3" id="greenBtn">
                                <strong>Buy These Items</strong>
                            </div>
                        </a>

                        <% }%>


                        <a href=" <%= session.getAttribute("back_to_page").toString()%> ">
                            <div class="grid_3" id="greenBtn">
                                <strong>Continue Shopping</strong>
                            </div>
                        </a>

                    </div>

                    <br/>
                    <br/>


                    <br/>
                    <%

                            } catch (Exception ex) {
                                out.println(ex);
                            }
                        }

                    %>
                </div>
            </div>
        </div>
    </body>
</html>
