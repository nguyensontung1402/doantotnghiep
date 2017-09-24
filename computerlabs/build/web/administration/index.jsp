<%-- 
    Document   : index
    Created on : Apr 14, 2014, 1:31:18 PM
    Author     : User
--%>
<%@include file="checkLogin.jsp" %>
<%    //administrations logout
    if (request.getParameter("option") != null) {
        String op = request.getParameter("option");
        if (op.equalsIgnoreCase("logout")) {
            session.removeAttribute("useradmin");
            response.sendRedirect("/computerlabs/?option=login");
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administration Page</title>
        <link href="css/pageadmin.css" rel="stylesheet" type="text/css" />
        <link href="css/csspaging.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/contentcss.css" type="text/css"/>
    </head>
    <body>
        <div class="main">
            <div class="main-eml">
                <table class="main-top">
                    <tr>
                        <td></td>
                        <td valign="middle"  style="width: 200px;height: 31px;"><a href="#" class="link-admin">Welcome to: <%=session.getAttribute("useradmin") == null ? "" : session.getAttribute("useradmin")%></a></td>
                        <td style="width: 36px;height: 31px;"><a href="#"><img src="../img/info.png" width="36px" height="31px" /></a></td>
                        <td style="width: 36px;height: 31px;"><a href="#"><img src="../img/changepwd.png" width="36px" height="31px" /></a></td>
                        <td style="width: 33px;height: 31px;"><a href="?option=logout"><img src="../img/close.png" width="33px" height="31px" onclick="return confirm('Administration Logout?');" /></a></td>
                    </tr>
                </table>
                <div class="main-content">
                    <div class="main-content-left">
                        <table class="logo">
                            <tr>
                                <td rowspan="2" style="width: 47px;height: 72px"><img src="../img/logoadmin.png" width="47px" height="72px" /></td>
                                <td align="center"><span style="font-size: 22px;color: white;">Management</span></td>
                            </tr>
                            <tr>
                                <td align="center" valign="top"><span style="font-size: 22px;color: white;">Computer Labs</span></td>
                            </tr>
                        </table>
                        <table class="left-menu">
                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title">
                                        <div class="text-title-chil">Report Infomation</div>               
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title">
                                        <div class="text-title-chil"><a href="?options=ManagerComplaint" class="text-title-chil">Manager Complaint</a></div>               
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title">
                                        <div class="text-title-chil"> <a class="text-title-chil" href="?options=ManagerSchedule">Manager Schedule Work</a></div>               
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title2">
                                        <a href="?options=manageruser" class="text-title">Manager User</a>               
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title2">
                                        <div class="text-title"> <a href="?options=ManagerShift" class="text-title">Manager Shift Name</a></div>               
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title2">
                                        <div class="text-title"><a href="?options=ManagerCategoryDevice" class="text-title">Manager Category</a></div>               
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title2">
                                        <div class="text-title"><a href="?options=ManagerTypeAccessory" class="text-title">Manager Type Accessory</a></div>               
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title2">
                                        <div class="text-title"> <a href="?options=ManagerAccessory" class="text-title">Manager Accessory</a></div>               
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title2">
                                        <div class="text-title"> <a href="?options=ManagerDevice" class="text-title">Manager Device</a></div>               
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title2">
                                        <div class="text-title"> <a href="?options=ManagerLab" class="text-title">Manager Labs Room</a></div>               
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="bg-title-td">
                                    <div class="bg-title2">
                                        <div class="text-title"><a href="?options=ManagerClasses" class="text-title"> Manager Class</a></div>               
                                    </div>
                                </td>
                            </tr>

                        </table>

                    </div>
                    <div class="main-content-right">
                        <table class="main-content-right" valign="top">
                            <tr>
                                <td align="center" valign="top" >
                                    <div class="khung-user">
                                        <%

                                            String title = "Home Page";
                                            if (request.getParameter("options") != null) {
                                                String opt = request.getParameter("options");
                                                if (opt.equalsIgnoreCase("manageruser")) {
                                                    title = "Manager User";
                                                } else if (opt.equalsIgnoreCase("CreateUser")) {
                                                    title = "Admin Create User";
                                                } else if (opt.equalsIgnoreCase("userDetails")) {
                                                    title = "User Details";
                                                } else if (opt.equalsIgnoreCase("search")) {
                                                    title = "Search";
                                                } else if (opt.equalsIgnoreCase("ManagerSchedule")) {
                                                    title = "Manager Schedule";
                                                } else if (opt.equalsIgnoreCase("CreateSchedule")) {
                                                    title = "Create Schedule";
                                                } else if (opt.equalsIgnoreCase("scheDetails")) {
                                                    title = "Schedule Details";
                                                } else if (opt.equalsIgnoreCase("ManagerShift")) {
                                                    title = "Manager Shoft Name";
                                                } else if (opt.equalsIgnoreCase("ManagerCategoryDevice")) {
                                                    title = "Manager Category Device";
                                                } else if (opt.equalsIgnoreCase("ManagerTypeAccessory")) {
                                                    title = "Manager Type Accessory";
                                                } else if (opt.equalsIgnoreCase("ManagerClasses")) {
                                                    title = "Manager Classes";
                                                } else if (opt.equalsIgnoreCase("ManagerLab")) {
                                                    title = "Manager Computer Labs";
                                                } else if (opt.equalsIgnoreCase("ManagerAccessory")) {
                                                    title = "Manager Accessory";
                                                } else if (opt.equalsIgnoreCase("ManagerDevice")) {
                                                    title = "Manager Device";
                                                } else if (opt.equalsIgnoreCase("CreateDevice")) {
                                                    title = "Create Device";
                                                } else if (opt.equalsIgnoreCase("DeviceInfo")) {
                                                    title = "Device Infomation";
                                                } else if (opt.equalsIgnoreCase("ManagerComplaint")) {
                                                    title = "Manager Complaint";
                                                } else if (opt.equalsIgnoreCase("complaintDetails")) {
                                                    title = "Complaint Infomation";
                                                } else {
                                                    title = "Home Page";
                                                }
                                            }
                                        %>
                                        <div class="title"><%=title%></div>
                                        <div class="content-main">
                                            <jsp:include page="body.jsp"/>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
