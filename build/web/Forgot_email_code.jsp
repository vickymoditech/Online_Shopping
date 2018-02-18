<%-- 
    Document   : Forgot_email_code
    Created on : Mar 26, 2016, 12:41:44 AM
    Author     : DELL
--%>
<%@page import="java.util.Locale.Category"%>

<style type="text/css">
    .prodGrid {
        margin: 10px;
        margin-right: -12px;
        margin-left: 36px;
    }
</style>


<div class="grid_13" id="productStrip"> 
        <div class="ProductHeading">
            <div class="grid_12">
                <h2 class="heading">Forgot PassWord !!</h2>
            </div>
        </div>
    <div class="clear"></div>

    <div id="productList"> 

            <form autocomplete="false" method="post" action="Code_check"  name="login">
                <center>
                <table>
                    <tr>
                        <td>
                            <label>Code</label>
                        </td>
                        <td>
                            <label><input type="text" name="code" placeholder="4 Digit Code insert" maxlength="4" required/><br/></label>
                        </td>
                    </tr>
                    <tr>
                        <td>

                        </td>
                        <td>
                            <input type="submit" value="Submit" id="greenBtn"/><br/>
                        </td>
                    </tr>
                </table>
            </center>
            </form>
    </div>
</div>   