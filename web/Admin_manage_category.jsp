<%-- 
    Document   : Admin_manage_category
    Created on : Apr 10, 2016, 11:09:54 PM
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

<script>
    function babu2()
    {
        alert("i am vicky");
    }
    
</script>

<%
    Database_connection obj_connection = new Database_connection();
    Connection cnn = obj_connection.cnn;
    Statement st = cnn.createStatement();

    String msg = "";
    if (request.getParameter("msg") != null) {
        msg = request.getParameter("msg");
    }

    if (request.getParameter("addcat") != null) {
        st.execute("insert into tbl_category values(null,'" + request.getParameter("addcat") + "','true')");
    }
    if (request.getParameter("changecat") != null && request.getParameter("oldcat") != null) {
        st.execute("update tbl_category set c_name = '" + request.getParameter("changecat") + "' where c_name = '" + request.getParameter("oldcat") + "'");
    }
    if (request.getParameter("delcat") != null) {
        try {
            ResultSet rs = st.executeQuery("select p_id from tbl_product,tbl_sub_cat,tbl_category where tbl_product.sub_id = tbl_sub_cat.sub_id and tbl_sub_cat.c_id = tbl_category.c_id and tbl_category.c_name = '" + request.getParameter("delcat") + "'");
            while (rs.next()) {
                new Product_delete_after_inform(rs.getInt(1)).start();
            }
        } catch (Exception ex) {
            out.println(ex);
        } finally {
            int cid = 0;
            ResultSet rs = st.executeQuery("select c_id from tbl_category where c_name = '" + request.getParameter("delcat") + "'");
            while (rs.next()) {
                cid = rs.getInt(1);
            }
            //   st.execute("delete from tbl_sub_cat where c_id =" + cid);
            //   st.execute("delete from tbl_category where c_id =" + cid);

            st.execute("update tbl_category set status = 'false' where c_id =" + cid);
            st.execute("update tbl_sub_cat set status = 'false' where c_id =" + cid);
            
        }
    }

    ResultSet rs = st.executeQuery("select c_id,c_name from tbl_category where status = 'true'");
%>



<div class="grid_13" id="productStrip"> 
    <div class="ProductHeading">
        <div class="grid_12">
            <h2 class="heading">Manage Category !!</h2>
        </div>
    </div>

    <div class="clear"></div>

    <div id="productList" > 
        <center>
            <table>
                <tr>
                    <td colspan="2">
                        <select id="selectcat" style="margin:  +2px" data-parsley-required="true" onchange="babu5(this.value)">
                            <option value="">select Category</option>
                            <% while (rs.next()) {%>
                            <option value="<%= rs.getString(2)%>"><%= rs.getString(2)%></option>
                            <% }%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Category Name</label>
                    </td>
                    <td>
                        <label><input type="text" name="category" id="txtcategory" maxlength="30" required/><br/></label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a href="#" data-parsley-required="true" onclick="return babu2(document.getElementById('selectcat').value,document.getElementById('txtcategory').value)"><ul id="greenBtn" class ="Btn showForm"><strong>Change Category</strong></ul></a> 
                        <a href="#"  data-parsley-required="true"  onclick="return babu3(document.getElementById('txtcategory').value) "><ul id="greenBtn" class ="Btn showForm"><strong>Add New Category</strong></ul></a>
                        <a href="#"  data-parsley-required="true"  onclick="return babu4(document.getElementById('txtcategory').value) "><ul id="greenBtn" class ="Btn showForm"><strong>Delete Category</strong></ul></a> 
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <label id="msgcat"><%= msg%></label>
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
                        <br/>
                    </td>
                </tr>
            </table>
        </center>
    </div>
</div>