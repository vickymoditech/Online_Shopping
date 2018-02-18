<%-- 
    Document   : Admin_manage_subcategory
    Created on : Apr 11, 2016, 1:43:24 PM
    Author     : Vicky
--%>

<%@ page import="database.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="Admin.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style type="text/css">
    .prodGrid {
        margin: 10px;
        margin-right: -12px;
        margin-left: 36px;
    }
</style>


<%
    Database_connection obj_connection = new Database_connection();
    Connection cnn = obj_connection.cnn;
    Statement st = cnn.createStatement();

    String msg = "";
    if (request.getParameter("msg") != null) {
        msg = request.getParameter("msg");
    }


    if (request.getParameter("addsub") != null && request.getParameter("catid") != null) {
        st.execute("insert into tbl_sub_cat values(null," + request.getParameter("catid") + ",'" + request.getParameter("addsub") + "','true')");
    }
    if (request.getParameter("changesubcat") != null && request.getParameter("oldsubcat") != null && request.getParameter("cid") != null) {
        st.execute("update tbl_sub_cat set sub_name = '" + request.getParameter("changesubcat") + "' where sub_name = '" + request.getParameter("oldsubcat") + "' and c_id = " + request.getParameter("cid"));
    }
    if (request.getParameter("delsub") != null && request.getParameter("catid") != null) {

        try {
            ResultSet rs = st.executeQuery("select p_id from tbl_product,tbl_sub_cat where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.sub_name = '" + request.getParameter("delsub") + "' and tbl_sub_cat.c_id = " + request.getParameter("catid"));
            while (rs.next()) {
                new Product_delete_after_inform(rs.getInt(1)).start();
            }
        } catch (Exception ex) {
            out.println(ex);
        } finally {
            //        st.execute("delete from tbl_sub_cat where sub_name = '" + request.getParameter("delsub") + "' and c_id = " + request.getParameter("catid"));
            st.execute("update tbl_sub_cat set status = 'false' where sub_name = '" + request.getParameter("delsub") + "' and c_id = " + request.getParameter("catid"));

        }


    }

    int subcid = 0;
    if (request.getParameter("subcid") != null) {
        subcid = Integer.parseInt(request.getParameter("subcid"));
    }


%>



<div class="grid_13" id="productStrip"> 
    <div class="ProductHeading">
        <div class="grid_12">
            <h2 class="heading">Manage Sub-Category !!</h2>
        </div>
    </div>

    <div class="clear"></div>

    <div id="productList" > 
        <center>
            <table>
                <tr>
                    <td>
                        <label>Category Name</label>
                    </td>
                    <td>
                        <%  ResultSet rs = st.executeQuery("select c_id,c_name from tbl_category where status = 'true'");%>

                        <select id="subccat" style="margin:  +2px" data-parsley-required="true" onchange="sendcid(this.value)">

                            <option value="">select Category</option>

                            <% while (rs.next()) {%>

                            <% if (subcid == rs.getInt(1)) {%>

                            <option value="<%= rs.getInt(1)%>" selected><%= rs.getString(2)%></option>

                            <% } else {%>

                            <option value="<%= rs.getInt(1)%>"><%= rs.getString(2)%></option>

                            <% }
                                }%>

                        </select>

                    </td>
                </tr>
                <% if (request.getParameter("subcid") != null) {%>
                <tr>
                    <td>
                        <label>Sub-Category Name</label>
                    </td>
                    <td>

                        <%
                            rs = st.executeQuery("select sub_id,c_id,sub_name from tbl_sub_cat where c_id = " + request.getParameter("subcid")+" and status = 'true'");%>

                        <select id="subcat" style="margin:  +2px" data-parsley-required="true" onchange="subscat(this.value)">

                            <option value="">select Sub-Category</option>
                            <% while (rs.next()) {%>

                            <option value="<%= rs.getString(3)%>"><%= rs.getString(3)%></option>

                            <% }
                                }%>
                        </select>

                    </td>

                <tr>
                    <td>
                        <label>Sub-Category Name</label>
                    </td>
                    <td>
                        <label><input type="text" name="subcategory" id="txtsubcategory" maxlength="30" required/><br/></label>
                    </td>
                </tr>


                </tr>
                <tr>
                    <td colspan="2">
                        <a href="#"  data-parsley-required="true"  onclick="return babu6(document.getElementById('subcat').value,document.getElementById('txtsubcategory').value,document.getElementById('subccat').value)"><ul id="greenBtn" class ="Btn showForm"><strong>Change Sub-Category</strong></ul></a> 
                        <a href="#"  data-parsley-required="true"  onclick="return babu7(document.getElementById('txtsubcategory').value,document.getElementById('subccat').value)"><ul id="greenBtn" class ="Btn showForm"><strong>Add New Sub-Category</strong></ul></a>
                        <a href="#"  data-parsley-required="true"  onclick="return babu8(document.getElementById('txtsubcategory').value,document.getElementById('subccat').value) "><ul id="greenBtn" class ="Btn showForm"><strong>Delete Sub-Category</strong></ul></a> 
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <label id="msgsubcat"><%= msg%></label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                    </td>
                </tr>


            </table>
        </center>
    </div>
</div>