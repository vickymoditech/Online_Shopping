<%-- 
    Document   : Admin_image_upload
    Created on : May 1, 2016, 2:56:14 PM
    Author     : Vicky
--%>



<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.Database_connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>SaiKiran BookStores</title>


    <link rel="shortcut icon" href="images/logo/ico.ico"/>
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="css/text.css"/>
    <link rel="stylesheet" type="text/css" href="css/960_16.css"/>

    <link rel="stylesheet" type="text/css" href="css/product.css"  />
    <link rel="stylesheet" type="text/css" href="css/time_pass.css"  />


    <link rel="stylesheet" type="text/css" href="css/lightbox.css"  />

    <link rel="stylesheet" type="text/css" href="css/styles.css"/>



    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/lightbox.js"></script>
    <script src="js/myScript.js"></script>



    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/myScript.js"></script>

    <script>
        
        function img_check()
        {
            
            document.getElementById("msgimg").innerHTML = " ";
            var check = "true"; 
            var fuData = document.getElementById('fileChooser');
            var FileUploadPath = fuData.value;


            if (FileUploadPath == '') 
            {
                document.getElementById("msgimg").style.color = "red";
                document.getElementById("msgimg").innerHTML = " Please upload an image";
                check = "false";

            } else {
                var Extension = FileUploadPath.substring(
                FileUploadPath.lastIndexOf('.') + 1).toLowerCase();



                if (Extension == "png" || Extension == "jpeg" || Extension == "jpg" || Extension == "PNG" || Extension == "JPG")
                {
                    
                    return true;

                } 
                else {
                    
                    document.getElementById("msgimg").style.color = "red";
                    document.getElementById("msgimg").innerHTML = " Photo only allows file types of png, PNG, JPG, JPEG ";
                    check = "false";
                }
            }
            
            if(check == "false")
            {
                return false;
            }
        }
            
        function img_check_more()
        {
            document.getElementById("msgdimg").innerHTML = " ";
            var check = "true"; 
            var fuData = document.getElementById('fileChooser1');
            var FileUploadPath = fuData.value;


            if (FileUploadPath == '') 
            {
                document.getElementById("msgdimg").style.color = "red";
                document.getElementById("msgdimg").innerHTML = " Please upload an image";
                check = "false";

            } else {
                var Extension = FileUploadPath.substring(
                FileUploadPath.lastIndexOf('.') + 1).toLowerCase();



                if (Extension == "png" || Extension == "jpeg" || Extension == "jpg" || Extension == "PNG" || Extension == "JPG")
                {
                    
                    return true;

                } 
                else {
                    
                    document.getElementById("msgdimg").style.color = "red";
                    document.getElementById("msgdimg").innerHTML = " Photo only allows file types of png, PNG, JPG, JPEG ";
                    check = "false";
                }
            }
            
            if(check == "false")
            {
                return false;
            }
            
        }
        
        
    </script>

    
    <% 
    
    String p_id = null;
    if(request.getParameter("mid")!=null)
    {
        p_id = request.getParameter("mid");
    }
    else
    {
        p_id = request.getAttribute("p_id").toString();
    }
    
    %>


    <style type="text/css">
        .imageGallery {
            width: 270px;
            margin: 11px;
            padding: 8px;
            border: 1px solid #CCC;
            text-align: center;
        }
        .alert {
            box-shadow: -20px 0px 0px #C00;
        }
    </style>
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

        if (session.getAttribute("admin") == null) {
            {
                response.sendRedirect("index.jsp");
            }
        }
    %>

    <jsp:include page="includesPage/_search_navigationbar.jsp"></jsp:include>
    <jsp:include page="includesPage/_facebookJoin.jsp"></jsp:include>
    <div class="container_16">
        <div class="grid_16" style="padding: 10px;" id="whiteBox">

            <br/>

            <h1 class="grid_15">Upload Product Images</h1><hr/>


        </div>


        <div class="grid_13"  style="padding: 10px 0px 10px 0px;" id="whiteBox">


            <form method="post" action="<%= "upload?pid=" + p_id %>" onsubmit="return img_check()" enctype="multipart/form-data" >
                <div class="clear"></div><br/>
                <div class="grid_13"  style="padding: 10px; ">


                    <div class="grid_3">
                        Main Product Image
                    </div>
                    <div class="grid_5">
                        <input type="file" name="file" id="fileChooser"><br>
                        <label id="msgimg"></label>

                        <% if (request.getAttribute("msg") != null) {%>

                        <label><font color="red"><%= request.getAttribute("msg")%></font></label>

                        <% }%>

                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_5">
                        <input type="submit" id="greenBtn" value="Upload Image" />
                    </div><br>

                    <% Database_connection obj_connection = new Database_connection();
                        Connection cnn1 = obj_connection.cnn;
                        Statement st1 = cnn1.createStatement();
                        ResultSet rs1 = st1.executeQuery("select p_img from tbl_product where p_id =" + p_id);
                        while (rs1.next()) {

                            String tmp = rs1.getString(1);
                            if (tmp != null) {

                    %>



                    <img src="<%= tmp%>"><br>


                    <% }
                        }%>

                </div>
            </form>
        </div>





        <div class="grid_13"  style="padding: 10px 0px 10px 0px;" id="whiteBox">


            <form method="post" action="<%= "upload_more_img?pid=" + p_id %>" onsubmit="return img_check_more()" enctype="multipart/form-data" >
                <div class="clear"></div><br/>
                <div class="grid_13"  style="padding: 10px; ">


                    <div class="grid_3">
                        Extra Product Image
                    </div>
                    <div class="grid_5">
                        <input type="file" name="file" id="fileChooser1">
                        <label id="msgdimg"></label>

                        <% if (request.getAttribute("msg1") != null) {%>

                        <label><font color="red"><%= request.getAttribute("msg1")%></font></label>

                        <% }%>


                    </div>
                    <div class="clear"></div><br/>


                    <div class="grid_5">
                        <input type="submit" id="greenBtn" value=" Extra Images Upload" />
                    </div>
                    <br>

                    <div class="grid_5">



                        <%
                            Connection cnn = obj_connection.cnn;
                            Statement st = cnn.createStatement();
                            ResultSet rs = st.executeQuery("select d_img_id,d_img_name from tbl_display_img where p_id =" + p_id);
                            boolean b = false;
                            int i = 1;
                            while (rs.next()) {
                                b = true;
                        %>


                        <img src="<%= rs.getString(2)%>">
                        <a href="<%= "Admin_delete_img?pid="+p_id+"&imgid="+rs.getInt(1)%>"><ul id="greenBtn"  class ="Btn"><strong> [x] Delete Image </strong></ul></a>
                        <br>

                        <%  i++;
                            }
                            if (b) {%>



                        


                        <% }%>

                    </div>

                </div>
            </form>
        </div>



</body>
</html>


