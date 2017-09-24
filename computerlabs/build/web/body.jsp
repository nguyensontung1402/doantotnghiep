<%
    String pagename = "home.jsp";
    if (request.getParameter("option") != null) {
        String opt = request.getParameter("option");
        if (opt.equalsIgnoreCase("login")) {
            pagename = "login.jsp";
        } else if (opt.equalsIgnoreCase("news")) {
            pagename = "news.jsp";
        } else if (opt.equalsIgnoreCase("timetable")) {
            if (session.getAttribute("Instructors") == null && session.getAttribute("Students") == null) {
                pagename = "login.jsp";
            } else if (session.getAttribute("Instructors") != null || session.getAttribute("Students") != null) {
                pagename = "indexSchedule.jsp";
            }
        } else if (opt.equalsIgnoreCase("sendRequest")) {
            if (session.getAttribute("Instructors") == null && session.getAttribute("Students") == null) {
                pagename = "login.jsp";
            } else if (session.getAttribute("Instructors") != null || session.getAttribute("Students") != null) {
                pagename = "sendRequest.jsp";
            }
        } else if (opt.equalsIgnoreCase("viewRequest")) {
            if (session.getAttribute("Instructors") == null && session.getAttribute("Students") == null) {
                pagename = "login.jsp";
            } else if (session.getAttribute("Instructors") != null || session.getAttribute("Students") != null) {
                pagename = "indexScheDetailsClient.jsp";
            }
        } else if (opt.equalsIgnoreCase("roomlab")) {
            if (session.getAttribute("Instructors") != null) {
                pagename = "indexRoomLab.jsp";
            } else {
                 pagename = "login.jsp";
            }
        }
        else if (opt.equalsIgnoreCase("sendComplaint")) {
            if (session.getAttribute("Instructors") != null) {
                pagename = "sendComplaint.jsp";
            } else {
                 pagename = "login.jsp";
            }
        }
        else if (opt.equalsIgnoreCase("listComplaint")) {
            if (session.getAttribute("TechnicalStaff") != null) {
                pagename = "indexComplaint.jsp";
            } else {
                 pagename = "login.jsp";
            }
        }
        else if (opt.equalsIgnoreCase("complaintDetails")) {
            if (session.getAttribute("TechnicalStaff") != null) {
                pagename = "complaintDetails.jsp";
            } else {
                 pagename = "login.jsp";
            }
        }
        else {
            pagename = "home.jsp";
        }
    }
%>
<jsp:include page="<%=pagename%>"/>