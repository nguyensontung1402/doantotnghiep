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
    </head>
    <body>
        <form id='ajaxformfrm' name='ajaxform' action='ajaxformexample' method='post'>

 Class Name: <input type='text' id='classname' name='classname' size='30'required/><br/>
 <input type='Submit'/> 
 <div id='content'>
</div>
</form>
<script src="js/ajaxsubmit.js"></script>
  
 <script type="text/javascript">

 var form = $('#ajaxform');
 form.submit(function () {

 $.ajax({
 type: form.attr('method'),
 url: form.attr('action'),
 data: form.serialize(),
 success: function (data) {
 var result=data;
 $('#content').html(result);

 }
 });

 return false;
 }); </script>
</body>
</html>