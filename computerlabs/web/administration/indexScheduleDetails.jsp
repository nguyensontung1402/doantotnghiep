<%
   if(request.getParameter("sid")!=null){
       int scheID=0;
       try{
           scheID=Integer.parseInt(request.getParameter("sid").toString().trim());
       }
       catch(Exception ex){
           scheID=0;
       }
       if(scheID>0){
           session.setAttribute("scheID",scheID);
       }else{
           response.sendRedirect("?options=ManagerSchedule");
       }
    }
   if(session.getAttribute("scheID")!=null){
    request.getRequestDispatcher("../scheduleDetails").forward(request, response);
   }
%>