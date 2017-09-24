<%-- 
    Document   : newjsp1
    Created on : Apr 30, 2014, 2:12:09 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
<link rel="stylesheet" href="../css/cssvalidate/validationEngine.jquery.css" type="text/css"/> 
        <link rel="stylesheet" href="../css/cssvalidate/template.css" type="text/css"/> 
        <script src="../js/jsvalidate/jquery-1.8.2.min.js" type="text/javascript"></script> 
        <script src="../js/jsvalidate/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script> 
        <script src="../js/jsvalidate/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script> 
        <script>jQuery(document).ready(function(){ 
            // binds form submission and fields to the validation engine 
            jQuery("#ajaxform").validationEngine(); 
        });  </script>
<%--check username--%>

    </head>
    <body>
        <form id='ajaxform' name='ajaxform' action='../testche' method='post'>
            <h1>Hello World!</h1>
            <input type="submit" class="button_example" height="20px" value="Update"/><div id='content'></div>
        </form>
        <script type="text/javascript">

    var form = $('#ajaxform');
    form.submit(function() {

        $.ajax({
            type: form.attr('method'),
            url: form.attr('action'),
            data: form.serialize(),
            success: function(data) {
                var result = data;
                $('#content').html(result);

            }
        });

        return false;
    }); </script>
    </body>
</html>
