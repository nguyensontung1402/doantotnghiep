<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/cssvalidate/validationEngine.jquery.css" type="text/css"/> 
        <link rel="stylesheet" href="css/cssvalidate/template.css" type="text/css"/> 
        <script src="js/jsvalidate/jquery-1.8.2.min.js" type="text/javascript"></script> 
        <script src="js/jsvalidate/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script> 
        <script src="js/jsvalidate/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script> 
        <script>jQuery(document).ready(function() {
                // binds form submission and fields to the validation engine 
                jQuery("#test").validationEngine();
            });</script>
<style>
    .login{
        width: 368px;height: 255px;margin: 0px auto;padding: 0px;-moz-border-radius: 5px;
-webkit-border-radius: 5px;background: url('img/bg-login.png');
    }
    .login-title{
        width: 351px;height: 39px;margin: 0 auto;padding: 0px;background: url('img/login-title.png');
    }
    .login-content{
        width: 351px;height: 193px;margin: 0 auto;padding: 0px;
    }
    .login-footer{
        width: 353px;height: 23px;margin: 0 auto;padding: 0px;background: url('img/login-footer.png');-moz-border-radius: 0 0 6px 6px;
-webkit-border-radius: 0 0 6px 6px;
    }
    .lable-td{
        width: 150px;height: 40px;color: #9d9d9d;text-align: center;
    }
    .lable-input{
        width: 250px;height: 40px;color: #9d9d9d;
    }
    .input-user{
        width:230px; height:22px;margin-top: 8px;-moz-border-radius: 13px;
-webkit-border-radius: 13px; border:1px solid #d1d1d1;
background: url('img/login-input.png');
            padding-left: 24px;
    }
    .input-pwd{
        width:230px; height:22px;margin-top: 8px;-moz-border-radius: 13px;
-webkit-border-radius: 13px; border:1px solid #d1d1d1;
background: url('img/login-pwd.png');
            padding-left: 24px;
    }

.myButton {
	-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
	box-shadow:inset 0px 1px 0px 0px #ffffff;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #ebe6eb));
	background:-moz-linear-gradient(top, #ffffff 5%, #ebe6eb 100%);
	background:-webkit-linear-gradient(top, #ffffff 5%, #ebe6eb 100%);
	background:-o-linear-gradient(top, #ffffff 5%, #ebe6eb 100%);
	background:-ms-linear-gradient(top, #ffffff 5%, #ebe6eb 100%);
	background:linear-gradient(to bottom, #ffffff 5%, #ebe6eb 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ebe6eb',GradientType=0);
	background-color:#ffffff;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #dcdcdc;
	display:inline-block;
	cursor:pointer;
	color:#7d707d;
	font-family:arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffffff;
}
.myButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ebe6eb), color-stop(1, #ffffff));
	background:-moz-linear-gradient(top, #ebe6eb 5%, #ffffff 100%);
	background:-webkit-linear-gradient(top, #ebe6eb 5%, #ffffff 100%);
	background:-o-linear-gradient(top, #ebe6eb 5%, #ffffff 100%);
	background:-ms-linear-gradient(top, #ebe6eb 5%, #ffffff 100%);
	background:linear-gradient(to bottom, #ebe6eb 5%, #ffffff 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ebe6eb', endColorstr='#ffffff',GradientType=0);
	background-color:#ebe6eb;
}
.myButton:active {
	position:relative;
	top:1px;
}


</style>
    <div class="login">
        <div class="login-title"></div>
        <div class="login-content">
            <br/>
            <form action="checklogin" id="test" name="test" method="POST">
                <table class="login-content">
                    <tr>
                        <td class="lable-input">
                            <input type="text" style="width:230px; height:22px;margin-top: 8px;-moz-border-radius: 13px;
-webkit-border-radius: 13px; border:1px solid #d1d1d1;
background: url('img/login-input.png');
            padding-left: 24px;" name="username" value="<%=request.getParameter("username")==null?"nguyensontung" :  request.getParameter("username")%>" class="validate[required,minSize[6]] text-input" />
                        </td>
                        <td class="lable-td">Username</td>
                    </tr>
                    <tr>
                        <td class="lable-input">
                            <input type="password" style="width:230px; height:22px;margin-top: 8px;-moz-border-radius: 13px;
-webkit-border-radius: 13px; border:1px solid #d1d1d1;
background: url('img/login-pwd.png');
            padding-left: 24px;" name="pwd" value="tung1234" class="validate[required,minSize[6]] text-input" />
                            <span style="color: red"><%=request.getAttribute("pwdnull")==null?"" :  request.getAttribute("pwdnull")%></span>
                            <span style="color: red"><%=request.getAttribute("loginfail")==null?"" :  request.getAttribute("loginfail")%></span>
                        </td>
                        <td class="lable-td">Password</td>
                    </tr>
                    <tr>
                        <td>  
                            <table class="lable-input">
                                <tr>
                                    <td class="lable-td"><input type="checkbox" name="remember" id="remember" />&nbsp;&nbsp;Remember Me</td>
                                    <td align="right"><input type="submit" value="Login" class="myButton"  /></td>
                                </tr>
                            </table>
                        </td>
                        <td></td>
                    </tr>
                    
                </table>
            </form>

        </div>
        <div class="login-footer"></div>
    </div>