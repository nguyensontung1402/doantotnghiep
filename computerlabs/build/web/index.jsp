<%    // logout
    if (request.getParameter("option") != null) {
        String op = request.getParameter("option");
        if (op.equalsIgnoreCase("logout")) {
            if (session.getAttribute("Instructors") != null) {
                session.removeAttribute("Instructors");
                response.sendRedirect("/computerlabs/?option=login");
            } else if (session.getAttribute("TechnicalStaff") != null) {
                session.removeAttribute("TechnicalStaff");
                response.sendRedirect("/computerlabs/?option=login");
            } else if (session.getAttribute("Students") != null) {
                session.removeAttribute("Students");
                response.sendRedirect("/computerlabs/?option=login");
            }
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/csspaging.css" />
        <link href="css/home.css" rel="stylesheet" type="text/css" />
        <link href="css/ddlevelsmenu-base.css" rel="stylesheet" type="text/css" />
        <link href="css/ddlevelsmenu-sidebar.css" rel="stylesheet" type="text/css" />
        <link href="css/ddlevelsmenu-topbar.css" rel="stylesheet" type="text/css" />
        <script src="js/ddlevelsmenu.js" type="text/javascript"></script>
        <link rel="stylesheet" href="assets/css/styles.css" />
        <link rel="stylesheet" href="assets/jquery.bubbleSlideshow/jquery.bubbleSlideshow.css" />
        <link href="css/styles.css" type="text/css" rel="stylesheet" />
        <script src="js/jquery-1.9.js" type="text/javascript"></script>
        <script src="js/general.js" type="text/javascript"></script>
    </head>
    <body>

        <div class="aaa"></div>
        <div class="main">
            <div class="site-elm1">
                <div class="site-eml1-top-menu" style="background-image: url('img/bg-menu.png')">
                    <div class="site-eml1-content-menu" style="background-image: url('img/menu.png')" >
                        <div class="site-eml1-content-leftmenu">
                            <div style="width:147px;height:20px;float:left">

                                <input id="TextBox1" class="site-eml1-content-search" name="txtseach" type="textbox" />
                            </div>
                            <div style="width:23px;height:20px;float:right;margin-top:13px;">
                                <a href="#"><img src="img/search.png" width="17px" style="height:17px" /></a>
                            </div>
                        </div>
                        <div class="site-eml1-content-rigthmenu">

                            <div id="ddtopmenubar" class="mattblackmenu">
                                <ul>
                                    <li><a href="#" >Hotline: 01649601455 - 09123456789</a></li>
                                    <li><a href="#" >Contacts</a></li>
                                    <li><a href="#" >News event</a></li>
                                    <li><a href="#" >Introduce</a></li>
                                    <li><a href="#">Home Page</a></li>
                                </ul>
                            </div>

                            <script type="text/javascript">
                                ddlevelsmenu.setup("ddtopmenubar", "topbar") //ddlevelsmenu.setup("mainmenuid", "topbar|sidebar")
                            </script>
                        </div>
                    </div>
                </div>
                <div class="site-eml1-banner" style="background-image: url('img/bg-banner.png');background-repeat: repeat-x;">
                    <div class="site-eml1-content-banner" style="background-image: url('img/banner-lt2.png')" >
                        <div class="site-eml1-content-bannerleft"></div>
                        <div class="site-eml1-content-bannerrigth">
                            <table cellpadding="0px" cellspacing="0px" width="480px" style="height: 90px" > 
                                <tr>
                                    <td><a href="?option=timetable"><img src="img/dichvu1.png" height="90px" width="168px" onmouseover="this.src = 'img/dichvu2.png';" onmouseout="this.src = 'img/dichvu1.png';" /></a></td>
                                    <td><a href="?option=roomlab"><img src="img/sp1.png" height="90px" width="174px" onmouseover="this.src = 'img/sp2.png';" onmouseout="this.src = 'img/sp1.png';" /></a> </td>
                                    <td>
                                        <%
                                            int check = 0;
                                            String user = "";
                                            String depart = "";
                                            if (session.getAttribute("Instructors") != null) {
                                                check = 2;
                                                user = session.getAttribute("Instructors").toString();
                                                depart = "Instructors";
                                            } else if (session.getAttribute("TechnicalStaff") != null) {
                                                check = 3;
                                                user = session.getAttribute("TechnicalStaff").toString();
                                                depart = "TechnicalStaff";
                                            } else if (session.getAttribute("Students") != null) {
                                                check = 4;
                                                user = session.getAttribute("Students").toString();
                                                depart = "Students";
                                            }
                                            if (check > 0) {
                                        %>
                                        <div class="ar login_popup">
                                            <a class="button" href="#" ><img src="img/login1.png" height="90px" width="138px"/></a>


                                            <div class="popup" style="width: 250px;height: 120px">

                                                <a href="#" class="close"><img src="img/not-available.png" /></a>
                                                <table style="width: 250px;height: 120px">
                                                    <tr>
                                                        <td colspan="2"><span style="color: black;">Hello: <%=user%></span> </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"><span style="color: black;">Department: <%=depart%></span> </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <span style="color: black;">
                                                                <%
                                                                    if (session.getAttribute("Instructors") != null || session.getAttribute("Students") != null) {
                                                                %>
                                                                <a href="?option=viewRequest">View Request</a>
                                                                <%
                                                                } else {
                                                                %>
                                                                <a href="?option=listComplaint">List Complaint</a>
                                                                <%
                                                                    }
                                                                %>
                                                            </span> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="120px">
                                                            <a href="?option=viewinfo" class="btnView"><span style="color: white;">View Info</span></a>
                                                        </td>
                                                        <td>  <a href="?option=logout" class="btnOut"><span style="color: white;">LogOut</span></a></td>
                                                    </tr>
                                                </table>
                                                <div style="width: 250px;height: 23px;margin: 0 auto;padding: 0px;background: url('img/login-footer.png');-moz-border-radius: 0 0 6px 6px;
                                                     -webkit-border-radius: 0 0 6px 6px;"></div>
                                            </div>
                                        </div>
                                        <%
                                        } else {
                                        %>
                                        <a href="/computerlabs/?option=login"><img src="img/da1.png" height="90px" width="138px" onmouseover="this.src = 'img/da2.png';" onmouseout="this.src = 'img/da1.png';" /></a>
                                            <%
                                                }
                                            %>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="site-eml1-slideshow">
                    <div class="site-eml1-slideshow-top">
                        <ul id="slideShow"></ul>
                        <!-- JavaScript includes -->
                        <script src="assets/ajaxslideshow.js"></script>
                        <script src="assets/jquery.bubbleSlideshow/bgpos.js"></script>
                        <script src="assets/jquery.bubbleSlideshow/jquery.bubbleSlideshow.js"></script>
                        <script src="assets/js/script.js"></script>
                    </div>
                    <div class="site-eml1-slideshow-bottom">
                        <div style="width:996px; height:7px; padding:0px; margin:0px auto;"></div>
                        <table align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td><a href="#"><img src="img/lg1.png" height="50px" width="150px" onmouseover="this.src = 'img/lg11.png';" onmouseout="this.src = 'img/lg1.png';" /></a></td>
                                <td><a href="#"><img src="img/lg2.png" height="50px" width="135px" onmouseover="this.src = 'img/lg22.png';" onmouseout="this.src = 'img/lg2.png';" /></a></td>
                                <td><a href="#"><img src="img/lg3.png" height="50px" width="157px" onmouseover="this.src = 'img/lg3.png';" onmouseout="this.src = 'img/lg3.png';" /></a></td>
                                <td><a href="#"><img src="img/lg4.png" height="50px" width="132px" onmouseover="this.src = 'img/lg4.png';" onmouseout="this.src = 'img/lg4.png';" /></a></td>
                                <td><a href="#"><img src="img/lg5.png" height="50px" width="130px" onmouseover="this.src = 'img/lg5.png';" onmouseout="this.src = 'img/lg5.png';" /></a></td>
                                <td><a href="#"><img src="img/lg6.png" height="50px" width="131px" onmouseover="this.src = 'img/lg6.png';" onmouseout="this.src = 'img/lg6.png';" /></a></td>
                                <td><a href="#"><img src="img/lg7.png" height="50px" width="155px" onmouseover="this.src = 'img/lg7.png';" onmouseout="this.src = 'img/lg7.png';" /></a></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="site-elm2">
                <div class="site-eml2-content">
                    <div class="site-eml2-contentleft">
                        <div class="site-eml2-contentlefttop" align="center">
                            <%
                                String title = "Home Page";
                                if (request.getParameter("option") != null) {
                                    String opt = request.getParameter("option");
                                    if (opt.equalsIgnoreCase("login")) {
                                        title = "Login From";
                                    } else if (opt.equalsIgnoreCase("news")) {
                                        title = "News";
                                    } else if (opt.equalsIgnoreCase("timetable")) {
                                        title = "Time Table";
                                    } else if (opt.equalsIgnoreCase("sendRequest")) {
                                        title = "Send Request";
                                    } else if (opt.equalsIgnoreCase("viewRequest")) {
                                        title = "View Request";
                                    } else if (opt.equalsIgnoreCase("roomlab")) {
                                        title = "Lab Room";
                                    } else if (opt.equalsIgnoreCase("sendComplaint")) {
                                        title = "Send Complaint";
                                    } else if (opt.equalsIgnoreCase("listComplaint")) {
                                        title = "List Complaint";
                                    } else if (opt.equalsIgnoreCase("complaintDetails")) {
                                        title = "Complaint Details";
                                    } else {
                                        title = "Home Page";
                                    }
                                }
                            %>
                            <span style="color:#ff9125;font-size: 16px;"><%=title %></span>
                        </div>
                        <div class="site-eml2-contentleftcontent">
                            <table class="site-eml2-contentleftcontent" valign="top">
                                <tr>
                                    <td align="center" valign="top"><jsp:include page="body.jsp"/></td>
                                </tr>

                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="site-elm3">
            </div>
        </div>
    </body>
</html>
