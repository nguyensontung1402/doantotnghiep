<%
    String pagename = "indexSchedule.jsp";
    if (request.getParameter("options") != null) {
        String opt = request.getParameter("options");
        if (opt.equalsIgnoreCase("manageruser")) {
            pagename = "indexUser.jsp";
        } else if (opt.equalsIgnoreCase("CreateUser")) {
            pagename = "createuser.jsp";
        } else if (opt.equalsIgnoreCase("userDetails")) {
            pagename = "userDetails.jsp";
        } else if (opt.equalsIgnoreCase("search")) {
            pagename = "indexUser.jsp";
        } else if (opt.equalsIgnoreCase("ManagerSchedule")) {
            pagename = "indexSchedule.jsp";
        } else if (opt.equalsIgnoreCase("CreateSchedule")) {
            pagename = "createSchedule.jsp";
        } else if (opt.equalsIgnoreCase("scheDetails")) {
            pagename = "indexScheduleDetails.jsp";
        } else if (opt.equalsIgnoreCase("ManagerShift")) {
            pagename = "managerShiftName.jsp";
        } else if (opt.equalsIgnoreCase("ManagerCategoryDevice")) {
            pagename = "indexCategory.jsp";
        } else if (opt.equalsIgnoreCase("ManagerTypeAccessory")) {
            pagename = "indexTypeAccessory.jsp";
        } else if (opt.equalsIgnoreCase("ManagerClasses")) {
            pagename = "indexClass.jsp";
        } else if (opt.equalsIgnoreCase("ManagerLab")) {
            pagename = "indexLabroom.jsp";
        }
        else if (opt.equalsIgnoreCase("ManagerAccessory")) {
            pagename = "indexAccessory.jsp";
        }
         else if (opt.equalsIgnoreCase("ManagerDevice")) {
            pagename = "indexDevice.jsp";
        }
         else if (opt.equalsIgnoreCase("CreateDevice")) {
            pagename = "createDevice.jsp";
        }
          else if (opt.equalsIgnoreCase("DeviceInfo")) {
            pagename = "editDevice.jsp";
        }
           else if (opt.equalsIgnoreCase("ManagerComplaint")) {
            pagename = "indexComplaint.jsp";
        }
            else if (opt.equalsIgnoreCase("complaintDetails")) {
            pagename = "complaintDetails.jsp";
        }
        else {
            pagename = "indexSchedule.jsp";
        }
    }
%>
<jsp:include page="<%=pagename%>"/>