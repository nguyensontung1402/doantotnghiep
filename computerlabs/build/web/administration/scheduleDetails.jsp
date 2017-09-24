<%-- 
    Document   : scheduleDetails
    Created on : Apr 28, 2014, 3:22:05 PM
    Author     : User
--%>

<%@page import="processSchedule.classRequest"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="computerlabs.dbconnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/cssvalidate/validationEngine.jquery.css" type="text/css"/> 
        <link rel="stylesheet" href="../css/cssvalidate/template.css" type="text/css"/> 
        <script src="../js/jsvalidate/jquery-1.8.2.min.js" type="text/javascript"></script> 
        <script src="../js/jsvalidate/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script> 
        <script src="../js/jsvalidate/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script> 
        <script>jQuery(document).ready(function() {
                // binds form submission and fields to the validation engine 
                jQuery("#ajaxform").validationEngine();
            });</script>
        <script>
            function BASIC_SelectItem(id)
            {
                var getID = id;
                document.ajaxform.ID.value = getID;
            }


        </script>
        <script type="text/javascript">
            var xmlHttpRe;
            function setXMLHttpRe() {
                try {
                    xmlHttpRe = new ActiveXObject("Msxml2.XMLHTTP")
                }
                catch (e) {
                    try {
                        xmlHttpRe = new ActiveXObject("Microsoft.XMLHTTP")
                    }
                    catch (e2) {
                        xmlHttpRe = false;
                    }
                }
                if (!xmlHttpRe && typeof XMLHttpRequest !== 'undefined') {
                    xmlHttpRe = new XMLHttpRequest();
                }
                return xmlHttpRe;
            }
            function show(pagenumber, status) {
                new setXMLHttpRe();
                var getText = pagenumber;  //Used to prevent caching during ajax call
                var strStatus = "&searchstatus=" + status;
                var v_user = "";
                var v_fullname = "";
                var v_classname = "";
                v_user = document.ajaxform.txtSearchName.value;
                v_fullname = document.ajaxform.txtFullName.value;
                v_classname = document.ajaxform.txtClassName.value;
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../scheduleDetails?pageNumber=" + getText + strStatus + "&user=" + v_user + "&fullname=" + v_fullname + "&classname=" + v_classname, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function goPage(status)
            {
                var c_value = "";
                c_value = document.ajaxform.go.value;
                new setXMLHttpRe();
                var getText = c_value;  //Used to prevent caching during ajax call
                var strStatus = "&searchstatus=" + status;
                var v_user = "";
                var v_fullname = "";
                var v_classname = "";
                v_user = document.ajaxform.txtSearchName.value;
                v_fullname = document.ajaxform.txtFullName.value;
                v_classname = document.ajaxform.txtClassName.value;
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../scheduleDetails?pageNumber=" + c_value + strStatus + "&user=" + v_user + "&fullname=" + v_fullname + "&classname=" + v_classname, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function Search()
            {
                var v_user = "";
                var v_fullname = "";
                var v_status = "";
                var v_classname = "";
                v_user = document.ajaxform.txtSearchName.value;
                v_fullname = document.ajaxform.txtFullName.value;
                v_status = document.ajaxform.searchstatus.value;
                v_classname = document.ajaxform.txtClassName.value;
                new setXMLHttpRe();
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../scheduleDetails?user=" + v_user + "&fullname=" + v_fullname + "&searchstatus=" + v_status + "&classname=" + v_classname, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function handleResponse() {
                if (xmlHttpRe.readyState === 4) {
                    if (xmlHttpRe.status === 200) {
                        document.getElementById("fcuk").innerHTML = xmlHttpRe.responseText; //Update the HTML Form element
                    }
                    else {
                        alert("Can not connect Server");
                    }
                }
            }

        </script>
    </head>
    <body>
        <%!
            int pageSelected;
        %>
        <%
            List list = (List) session.getAttribute("scheRequest");
        %>  

        <%
            List pageNumbers = (List) session.getAttribute("pages");
        %>  

        <form id='ajaxform' name='ajaxform' action='../updateRequest' method='post'>
            <table cellpadding="1px" cellspacing="1px" id="fcuk" width="950px" align="center">  
                 
                <tr>  
                    <td colspan="7" align="right">  
                        <!--<form method="get" action="NewServlet">  -->
                        <table>  
                            <tr> 
                                <%--Fist--%>
                                <td>
                                    <div id="container" style="margin-bottom:20px">
                                        <div class="pagination">
                                            <%
                                                pageSelected = 1;
                                                if (request.getParameter("pageNumber") != null) {
                                                    pageSelected = Integer.parseInt(request.getParameter("pageNumber"));
                                                }
                                                if (pageSelected > 1) {

                                            %>
                                            <li class="active" onclick="javascript:show(1,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                First
                                            </li>
                                            <%                                    } else {
                                            %>
                                            <li class="active-max" onclick="javascript:show(1,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                First
                                            </li>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </td>
                                <%--Fist--%>
                                <%--Last--%>
                                <td>
                                    <div id="container" style="margin-bottom:20px">
                                        <div class="pagination">
                                            <%
                                                pageSelected = 1;
                                                if (request.getParameter("pageNumber") != null) {
                                                    pageSelected = Integer.parseInt(request.getParameter("pageNumber"));
                                                }
                                                if (pageSelected == Integer.parseInt((pageNumbers.size() + "").trim())) {

                                            %>
                                            <li class="active-max" onclick="javascript:show(<%=pageNumbers.size()%>,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                Last
                                            </li>
                                            <%
                                            } else {
                                            %>
                                            <li class="active" onclick="javascript:show(<%=pageNumbers.size()%>,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                Last
                                            </li>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </td>
                                <%--Last--%>

                                <%
                                    for (int i = 0; i < pageNumbers.size(); i++) {
                                %>  
                                <td width="27px">
                                    <div id="container" style="margin-bottom:20px">
                                        <div class="pagination">

<!--<a href="NewServlet?pageNumber=<%=pageNumbers.get(i)%>"><%=pageNumbers.get(i)%></a>-->
                                            <%
                                                if (pageSelected == Integer.parseInt(pageNumbers.get(i).toString())) {
                                            %>
                                            <li class="actived" onclick="javascript:show(<%=pageNumbers.get(i)%>,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                <%=pageNumbers.get(i)%>
                                            </li>
                                            <%
                                            } else {
                                            %>
                                            <li class="active" onclick="javascript:show(<%=pageNumbers.get(i)%>,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                <%=pageNumbers.get(i)%>
                                            </li>
                                            <%
                                                }
                                            %>

                                        </div>
                                    </div>
                                </td>  
                                <%
                                    }
                                %>  
                                <td>
                                </td>

                                <%--Next--%>
                                <td>

                                    <div id="container" style="margin-bottom:20px">
                                        <div class="pagination">
                                            <%
                                                int nextpage = pageSelected;
                                                if (nextpage == Integer.parseInt((pageNumbers.size() + "").trim())) {

                                            %>
                                            <li class="active-max" onclick="javascript:show(<%=nextpage%>,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                Next
                                            </li>

                                            <%
                                            } else {

                                            %>
                                            <li class="active" onclick="javascript:show(<%=(nextpage + 1)%>,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                Next
                                            </li>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </td>
                                <%--Next--%>
                                <%--Previous--%>
                                <td>

                                    <div id="container" style="margin-bottom:20px">
                                        <div class="pagination">
                                            <%
                                                int previous = pageSelected;
                                                if (previous == 1) {

                                            %>
                                            <li class="active-max" onclick="javascript:show(<%=previous%>,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                Previous
                                            </li>

                                            <%
                                            } else {

                                            %>
                                            <li class="active" onclick="javascript:show(<%=(previous - 1)%>,<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);">
                                                Previous
                                            </li>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </td>
                                <%--Previous--%>
                                <td>
                                    <input type="text" class="" name="go" id="go" size="3" value="" /><input type="button" class="button_example" height="23px" value="Go" onclick= "goPage(<%=request.getAttribute("statusSelected") == null ? 3 : request.getAttribute("statusSelected")%>);" />
                                </td>
                                <td><span>Page: 
                                        <%=pageSelected%>/<%=pageNumbers.size()%>
                                    </span></td>
                            </tr>  
                        </table>  
                        <!-- </form>   -->
                    </td>  
                </tr>  
                <tr >
                    <td style="height: 30px;width: 30px" >
                        <input type="text" value="manageruser" name="options" style="width: 30px; visibility: hidden;"/>
                    </td>
                    <td style="height: 30px" ><input id="txtSearchName" value="<%=request.getParameter("user") == null ? "" : request.getParameter("user")%>" name="txtSearchName" type="text" placeholder="Search by Username"  /></td>
                    <td style="height: 30px" ><input id="txtFullName" value="<%=request.getParameter("fullname") == null ? "" : request.getParameter("fullname")%>" name="txtFullName" type="text" placeholder="Search by Full Name"  /></td>
                    <td style="height: 30px" ><input id="txtClassName" value="<%=request.getParameter("classname") == null ? "" : request.getParameter("classname")%>" name="txtClassName" type="text" placeholder="Search by Class Name"  /></td>
                    <td style="height: 30px" >
                        <select name="searchstatus">
                            <%
                                if (request.getAttribute("statusSelected") != null) {
                                    if (Integer.parseInt(request.getAttribute("statusSelected").toString().trim()) == 0) {
                            %>
                            <option value="3" >ALL</option>
                            <option value="0" selected="selected" >Waiting</option>
                            <option  value="1" >Dissatisfactory</option>
                            <option  value="2" >Approved</option>
                            <%
                            } else if (Integer.parseInt(request.getAttribute("statusSelected").toString().trim()) == 1) {
                            %>
                            <option value="3" >ALL</option>
                            <option value="0" >Waiting</option>
                            <option selected="selected"  value="1" >Dissatisfactory</option>
                            <option  value="2" >Approved</option>
                            <%
                            } else if (Integer.parseInt(request.getAttribute("statusSelected").toString().trim()) == 2) {
                            %>
                            <option value="3" >ALL</option>
                            <option value="0" >Waiting</option>
                            <option  value="1" >Dissatisfactory</option>
                            <option selected="selected"  value="2" >Approved</option>
                            <%
                            } else {
                            %>
                            <option selected="selected" value="3" >ALL</option>
                            <option value="0" >Waiting</option>
                            <option  value="1" >Dissatisfactory</option>
                            <option  value="2" >Approved</option>
                            <%
                                }
                            } else {
                            %>
                            <option value="3" >ALL</option>
                            <option value="0" >Waiting</option>
                            <option  value="1" >Dissatisfactory</option>
                            <option  value="2" >Approved</option>
                            <%
                                }
                            %>

                        </select>
                    </td>
                    <td style="height: 30px" >
                        <input type="button" onclick="Search();" value="Search"/>
                    </td>
                    <td style="height: 30px;" colspan="3"></td>
                </tr> 
                <%
                    Connection cnn = null;
                    Statement st = null;
                    ResultSet rs = null;
                    int sID = 0;
                    SimpleDateFormat formarter = new SimpleDateFormat("MM/dd/yyyy");
                    if (session.getAttribute("scheID") != null) {
                        sID = Integer.parseInt(session.getAttribute("scheID").toString().trim());
                    }
                    String sql = "select TOP 1 u.username as username,c.className as className,r.courseName courseName,"
                            + "r.sendDate as sendDate,l.roomName roomName,s.shiftname as sName,s.starttime,s.endtime,d.dateword,u.fullname as fullname, r.status as restatus "
                            + "from tbl_request as r inner join tbl_user as u on r.userID=u.userID "
                            + "inner join tbl_class as c on r.classID=c.classID inner join tbl_schedule "
                            + "as sche on r.scheduleID=sche.scheduleID inner join tbl_shiftname as s on "
                            + " sche.shiftID=s.shiftID inner join tbl_labroom as l on sche.roomID=l.roomID "
                            + " inner join tbl_datework as d on sche.dateworkID=d.datewordID where r.scheduleID=" + sID;
                    cnn = dbconnect.Connect();
                    try {
                        st = cnn.createStatement();
                        rs = st.executeQuery(sql);
                        if (rs.next()) {
                            String roomName = rs.getString("roomName");
                            String sName = rs.getString("sName");
                            String starttime = rs.getTime("starttime").toString();
                            String endtime = rs.getTime("endtime").toString();
                            String dateword = formarter.format(rs.getDate("dateword"));
                            request.setAttribute("date", dateword);
                %>
                <tr>
                    <td align="left" colspan="6" ><span style="font-size: 13px;color: #AAA;font-style: italic;">Shift Name: <%=sName%> &nbsp; (<%=starttime.substring(0, 5) + "-" + endtime.substring(0, 5)%>)&nbsp;&nbsp; Room Name: <%=roomName%> &nbsp;&nbsp;&nbsp;Date Work: <%=dateword%></span></td>
                </tr>
                <%
                        }
                    } catch (Exception ex) {

                    } finally {
                        try {
                            rs.close();
                            st.close();
                            cnn.close();
                        } catch (Exception ex) {

                        }
                    }
                %>
                <tr bgcolor="#78bbe3">

                    <td style="width: 150px;height: 25px;color: white;" align="center" >Class Name</td>
                    <td style="width: 150px;height: 25px;color: white;" align="center" >Course Name</td>
                    <td style="width: 200px;height: 25px;color: white;" align="center" >User Name</td>
                    <td style="width: 200px;height: 25px;color: white;" align="center" >Full Name</td>
                    <td style="width: 50px;height: 25px;color: white;" align="center" >Date Send</td>
                    <td style="width: 100px;height: 25px;color: white;" align="center" >Status</td>
                    <td align="center" style="color: white;">Action</td>
                </tr>

                <%
                    String color = "style='background: #e7f5fe;height:30px'";
                    for (int i = 0; i < list.size(); i++) {
                        classRequest requestSche = (classRequest) list
                                .get(i);
                        if (i % 2 == 0) {
                %>
                <tr>

                    <td align="center" ><%=requestSche.getClassName()%></td>
                    <td align="center"><%=requestSche.getCourseName()%></td>
                    <td align="center" ><%=requestSche.getUsername()%></td>
                    <td align="center" ><%=requestSche.getFullname()%></td>
                    <td align="center" ><%=requestSche.getSendDate()%></td>
                    <td align="center" >
                        <select name="status<%=requestSche.getReqID()%>" >
                            <%
                                if (requestSche.getStatus().trim().equalsIgnoreCase("0")) {
                            %>
                            <option value="0" >Waiting</option>
                            <option value="1" >Dissatisfactory</option>
                            <option value="2" >approved</option>
                            <%
                            } else if (requestSche.getStatus().trim().equalsIgnoreCase("1")) {
                            %>
                            <option value="0" >Waiting</option>
                            <option selected="selected" value="1" >Dissatisfactory</option>
                            <option value="2" >approved</option>
                            <%
                            } else {
                            %>
                            <option value="0" >Waiting</option>
                            <option  value="1" >Dissatisfactory</option>
                            <option selected="selected" value="2" >approved</option>
                            <%
                                }
                            %>
                        </select>
                    </td >
                    <td align="center" ><input type="submit" class="button_example" height="20px" onclick="BASIC_SelectItem(<%=requestSche.getReqID()%>)" value="Update"/></td>
                </tr>
                <%                } else {
                %>
                <tr>

                    <td align="center" class="color-tabletd"><%=requestSche.getClassName()%></td>
                    <td align="center" class="color-tabletd"><%=requestSche.getCourseName()%></td>
                    <td align="center" class="color-tabletd"><%=requestSche.getUsername()%></td>
                    <td align="center" class="color-tabletd"><%=requestSche.getFullname()%></td>
                    <td align="center" class="color-tabletd"><%=requestSche.getSendDate()%></td>

                    <td align="center" class="color-tabletd">
                        <select name="status<%=requestSche.getReqID()%>" >
                            <%
                                if (requestSche.getStatus().trim().equalsIgnoreCase("0")) {
                            %>
                            <option value="0" >Waiting</option>
                            <option value="1" >Dissatisfactory</option>
                            <option value="2" >approved</option>
                            <%
                            } else if (requestSche.getStatus().trim().equalsIgnoreCase("1")) {
                            %>
                            <option value="0" >Waiting</option>
                            <option selected="selected" value="1" >Dissatisfactory</option>
                            <option value="2" >approved</option>
                            <%
                            } else {
                            %>
                            <option value="0" >Waiting</option>
                            <option  value="1" >Dissatisfactory</option>
                            <option selected="selected" value="2" >approved</option>
                            <%
                                }
                            %>
                        </select>
                    </td >
                    <td align="center" class="color-tabletd"><input type="submit" name="update" onclick="BASIC_SelectItem(<%=requestSche.getReqID()%>)" class="button_example" height="20px" value="Update"/></td>
                </tr>
                <%
                        }
                    }

                %> 
                <tr><td colspan="7" align="center"><input type="text" name="ID" id="ID" style="visibility: hidden"  /><div id='content'></div></td></tr>
            </table>
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
                        $('#content').show().html(result).delay(4000).fadeOut();

                    }
                });

                return false;
            }); </script>
    </body>
</html>