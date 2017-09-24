<%-- 
    Document   : userDetails
    Created on : May 1, 2014, 4:00:23 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/popup.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../js/ajaxpopup.js"></script>
 <script type="text/javascript" src="../js/jspopup.js"></script>


</head><body>
<div style="font-size: 10px; color: rgb(204, 204, 204);"></div>
<%
    if(request.getParameter("userID")!=null){
%>
<div id="boxes">
<div style="top: 199.5px; left: 551.5px; display: none;" id="dialog" class="window">
    <%=request.getParameter("userID") %>
<a href="#" class="close">Close it</a>
</div>
<!-- Mask to cover the whole screen -->
<div style="width: 1478px; height: 602px; display: none; opacity: 0.8;" id="mask"></div>
</div>
<%
    }
%>
    </body>
</html>
