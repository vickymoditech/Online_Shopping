<%-- 
    Document   : Forgot_email
    Created on : Mar 25, 2016, 2:07:41 PM
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

    <div id="productList"> 

        <form autocomplete="false" method="post" action="Forgot_email"  name="login">
            <center>
                <table>
                    <tr>
                        <td>
                            <label>Email</label>
                        </td>
                        <td>
                            <label><input type="email" name="email" placeholder="john_lee@xyz.com" required/><br/></label>
                        </td>
                    </tr>
                    <tr>
                        <td>

                        </td>
                        <td>
                            <input type="submit" value="Submit" id="greenBtn" /><br/>
                        </td>
                    </tr>
                </table>
            </center>
        </form>
    </div>
</div>   