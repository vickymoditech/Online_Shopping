<script type ="text/javascript" src="js/headerJoinScript.js"></script>

<script langauge="javascript">
    
    function check()
    {
        var pass = document.getElementById("p1").value;
        var pass1 = document.getElementById("p2").value;
        if(pass != pass1)
        {
            document.getElementById("message").style.color = "red";
            document.getElementById("message").innerHTML = "Both passwords must match";
            return false;
        }
    }
    
</script>


<div id = "topWrapper">
    <div class="container_16">
        <div class="grid_16">
            <div id="logo" class="grid_6"> <a href="index.jsp"><img src="images/logo/icon.png" /></a>
            </div>
            <div class="grid_6" id="top">
                <ul>
                    <a href="#" id="join"><li id="greenBtn"  class ="Btn showForm"><strong>Join Now!!</strong></li></a>
                </ul>
            </div>
        </div>
    </div>
</div>

<div id = "topLogin">
    <div class="container_16">
        <div id="LoginBox" class="grid_16">

            <div class="grid_6" id = "loginForm">
                <form autocomplete="false" method="post" action="LoginServlet"  name="login">
                    <table>
                        <tr>
                            <td colspan="2">
                                <strong><h1 style="font-wieght:bold; text-align:left; padding:20px 0px; color:#FFF;">Login...</h1></strong>
                            </td>
                            <td>
                            </td>
                        </tr>
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
                                <label>Password</label>
                            </td>
                            <td>
                                <input type="password" name="pass" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;" required/><br/>
                            </td>
                        </tr><tr>
                            <td>

                            </td>
                            <td>
                                <input type="submit" value="Login!!" id="greenBtn" /><br/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                            </td>
                            <td>
                                <a href="Forgot_email_index.jsp" id="forgot"><ul id="greenBtn"  class ="Btn"><strong> Forgot PassWord </strong></ul></a>
                            </td>
                        </tr>


                    </table>
                </form>
            </div>

            <div class="grid_6 push_2" id = "RegisterForm">
                <form autocomplete="false" method="POST" action="RegisterServlet" name="registerServlet" onsubmit="return check()">
                    <table>
                        <tr>
                            <td colspan="2">
                                <strong><h1 style="font-wieght:bold; text-align:right; padding:20px 0px; color:#FFF;">Register Now!!</h1></strong>
                            </td>
                            <td>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Email</label>
                            </td>
                            <td>
                                <label><input type="email"  name="emailReg" placeholder="john_lee@xyz.com" maxlength="30" required/><br/></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Password</label>
                            </td>
                            <td>
                                <input type="password" id="p1" name="passReg" maxlength="20" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;" required/><br/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Password Again</label>
                            </td>
                            <td>
                                <input type="password" id="p2" name="passAgainReg" maxlength="20" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;" required/><br/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="submit" value="Register" id="greenBtn" /><br/>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <label id="message"></label> 
                            </td>
                        </tr>

                        <tr>
                            <td>
                            </td>
                            <td>
                                <a href="Add_product_dealer.jsp" id="forgot"><ul id="greenBtn"  class ="Btn"><strong> Add As Dealer </strong></ul></a>
                            </td>
                        </tr>


                    </table>

                </form>
            </div>
        </div>
    </div>
</div>