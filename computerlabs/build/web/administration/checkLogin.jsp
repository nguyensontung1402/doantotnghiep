<%
    if(session.getAttribute("useradmin")==null){
        response.sendRedirect("/computerlabs/?option=login");
    }
    
%>