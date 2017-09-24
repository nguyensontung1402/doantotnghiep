<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ajax form Example</title>
</head>
<body>
<form id='ajaxform' name='ajaxform' action='ajaxformexample' method='post'>

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