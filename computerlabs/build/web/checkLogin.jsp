<%
    if(session.getAttribute("Instructors")==null && session.getAttribute("TechnicalStaff")==null && session.getAttribute("Students")==null){
        //response.sendRedirect("?option=login");
        out.println("<script>alert('aa')</script>");
    }
    
%>