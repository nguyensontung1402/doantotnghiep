<%-- 
    Document   : newjsp
    Created on : Apr 17, 2014, 9:17:35 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" media="screen" href="../css/popup.css" />
        <script type="text/javascript" src="../js/jquery.1.7.2.js"></script>
<script type="text/javascript" src="../js/jquery.popupMiendatweb.min.js"></script>
<script type="text/javascript" language="JavaScript">
	$(function(){
		/* khởi tạo popup */
        $('input[rel*=miendatwebPopup]').showPopup({ 
        	top : 200, //khoảng cách popup cách so với phía trên
        	closeButton: ".close_popup" , //khai báo nút close cho popup
			scroll : false, //cho phép scroll khi mở popup, mặc định là không cho phép
        	onClose:function(){            	
        		//sự kiện cho phép gọi sau khi đóng popup, cho phép chúng ta gọi 1 số sự kiện khi đóng popup, bạn có thể để null ở đây
        	}
        });	
	});
</script>
<style>
	.center {text-align:center;margin:0 auto;margin-left: auto;margin-right: auto;width:960px;}
	#open_popup {color: #FEF4E9;border: solid 1px #DA7C0C;background: #F78D1D;background: -webkit-gradient(linear, left top, left bottom, from(#FAA51A), to(#F47A20));background: -moz-linear-gradient(top, #FAA51A, #F47A20);filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');display: inline-block;outline: none;cursor: pointer;text-align: center;text-decoration: none;font: 12px/100% Arial, Helvetica, sans-serif;padding: .5em 2em .55em;text-shadow: 0 1px 1px rgba(0, 0, 0, .3);-webkit-border-radius: .5em;-moz-border-radius: .5em;border-radius: .5em;-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .2);-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
}
</style>
    </head>
    <body>
<div align="center" class="center">
	<input type="button" id="open_popup" name="open_popup" rel="miendatwebPopup" href="#popup_content" value="Mở popup"/>
</div>
<div id="popup_content" class="popup">
	<div class="popup-header">
		<h2>Tiêu Đề Popup</h2>
		<a class="close_popup" href="javascript:void(0)"></a>
		<p>Nội dung mô tả thêm cho tiêu đề (nếu có)</p>
	</div>
	<div class="info_popup">
		miendatwebPopup<br/>
		Phiên bản popup: 1.0<br/>
		Tác giả: Miền Đất Web<br/>
		Liên hệ: nguyentrungtinh29@gmail.com<br/>
		Ngày tạo: 22/07/2012
	</div>

</div>
</form>
    </body>
</html>
