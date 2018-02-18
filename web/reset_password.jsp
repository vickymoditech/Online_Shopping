<%-- 
    Document   : reset_password
    Created on : Mar 26, 2016, 11:08:45 AM
    Author     : DELL
--%>

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

    <div id="productList" > 

        <form autocomplete="false" method="post" action="Reset_pass"  name="Reset_pass">
            <center>
                <table>
                    <tr>
                        <td>
                            <label>Password</label>
                        </td>
                        <td>
                            <label><input type="password" id="p1" name="pass" maxlength="20" required/><br/></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>Conform Password</label>
                        </td>
                        <td>
                            <label><input type="password" id="p2" name="cpass" maxlength="20" required/><br/></label>
                        </td>
                    </tr>
                    <tr>
                        <td>

                        </td>
                        <td>
                            <input type="submit" value="Submit" id="greenBtn"/><br/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                    <center><label id="message"></label></center>
                    </td>
                    </tr>
                </table>
            </center>
        </form>
    </div>
</div>   