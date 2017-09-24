<%-- 
    Document   : testjquery
    Created on : Apr 16, 2014, 7:39:13 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
  <title>Simple Form Validation</title>
  <link rel="stylesheet" href="../css/cssvalidate/validationEngine.jquery.css" type="text/css"/> 
        <link rel="stylesheet" href="../css/cssvalidate/template.css" type="text/css"/> 
        <script src="../js/jsvalidate/jquery-1.8.2.min.js" type="text/javascript"></script> 
        <script src="../js/jsvalidate/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script> 
        <script src="../js/jsvalidate/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script> 
        <script>jQuery(document).ready(function(){ 
            // binds form submission and fields to the validation engine 
            jQuery("#frm1").validationEngine(); 
        });  </script>
        <script>
function BASIC_SelectItem()
{
            var isOK=false;
            if (document.ajaxform.chk.checked)
            {
                isOK=true;
            }
            if(isOK==true){
                document.ajaxform.rsCheckbox.value='checked';
            }
            else{
                document.ajaxform.rsCheckbox.value='nochecked';
            }
    }
    
    
</script>
  </head>
<body>
    <h1>Hello World!</h1>
        <form action="aa" method="post" id="frm1">
            <input type="text" name="user1"/><br/>
            <input type="password" name="pass1"/><br/>
            <input value="" class="validate[required] text-input" type="text" name="req" id="req" />  <br/>
            <input value="" class="validate[required] text-input" type="text" name="req1" id="req1" />  <br/>
            <input type="submit" value="Login"/>
            
        </form>
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
<%
//Liệt kê 1 số kiểu bắt lỗi
//validate[required] : bắt buộc nhập
//validate[required,custom[url]] : nhập theo định dạng vd url, phone, email ...
//validate[required,equals[password]] : So sánh password
//validate[required,funcCall[checkHELLO]] : dùng hàm xét điều kiện quy đinh
//validate[condRequired[dep1]] : điều kiện phụ thuộc vào 1 trường khác
//validate[required,minSize[6]] : số ký tự tối thiểu
//validate[maxSize[6]] : số ký tự tối đa
//validate[required,custom[integer],min[-5]] : giá trị tối thiểu
//validate[required,custom[integer],max[50]] : giá trị tối đa
//validate[custom[date],past[2010/01/01]] :ngày quá khứ
//validate[custom[date],future[NOW]] : ngày tương lai
        %>