


<%@page import="device.checkExits"%>
<%@page import="device.classDevice"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="computerlabs.dbconnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="java.util.List"%>  


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>  
    <head>  
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <title>Manager User</title>  
        <link href="css/popup.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../js/ajaxpopup.js"></script>
        <script type="text/javascript" src="../js/jspopup.js"></script>
        <%----%>
        <link rel="stylesheet" href="../css/cssvalidate/validationEngine.jquery.css" type="text/css"/> 
        <link rel="stylesheet" href="../css/cssvalidate/template.css" type="text/css"/> 
        <script src="../js/jsvalidate/jquery-1.8.2.min.js" type="text/javascript"></script> 
        <script src="../js/jsvalidate/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script> 
        <script src="../js/jsvalidate/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script> 
        <script>jQuery(document).ready(function() {
                // binds form submission and fields to the validation engine 
                jQuery("#test").validationEngine();
            });</script>
        <script>
            function BASIC_SelectItem(act, id)
            {
                var getID = id;
                var getACT = act;
                //document.test.ID.value = getID;
                //document.test.act.value = getACT;
                if (act == 'delete') {
                    if (confirm("I want deleted?") == true) {
                        document.test.ID.value = getID;
                        document.test.act.value = getACT;
                    } else {
                        //window.location.href = "?options=ManagerAccessory";
                    }
                } else {
                    document.test.ID.value = getID;
                    document.test.act.value = getACT;
                }
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
            function show(pagenumber, cateID, status) {
                new setXMLHttpRe();
                var getText = pagenumber;  //Used to prevent caching during ajax call
                var strStatus = "&status=" + status;
                var strCate = "&cateID=" + cateID;
                var v_name = "";
                v_name = document.test.txtSearchName.value;
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showDevice?pageNumber=" + getText + strCate + strStatus + "&name=" + v_name, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function goPage(roomID, cateID, status)
            {
                var c_value = "";
                c_value = document.test.go.value;
                var strRoom = "&roomID=" + roomID;
                var strStatus = "&status=" + status;
                var strCate = "&cateID=" + cateID;
                var v_name = "";
                v_name = document.test.txtSearchName.value;
                new setXMLHttpRe();
                var getText = c_value;  //Used to prevent caching during ajax call
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showDevice?pageNumber=" + c_value + strStatus + strRoom + strCate + "&name=" + v_name, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function Search()
            {
                var v_name = "";
                var v_status = "";
                var v_roomID = "";
                var v_cateID = "";
                v_name = document.test.txtSearchName.value;
                v_cateID = document.test.cateID.value;
                v_status = document.test.status.value;
                v_roomID = document.test.roomID.value;
                new setXMLHttpRe();
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showDevice?name=" + v_name + "&status=" + v_status + "&cateID=" + v_cateID + "&roomID=" + v_roomID, true);// chú ý
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
            List list = (List) session.getAttribute("deviceInfo");
        %>  

        <%
            List pageNumbers = (List) session.getAttribute("pages");
        %>  

        <form action="../deleteDe" name="test" id="test" method="post">
            <table cellpadding="1px" border="0" cellspacing="1px" id="fcuk" width="950px" align="center">  

               
                <tr>  
                    <td colspan="2" align="center"><a class="button_example" href="?options=CreateDevice">Create Device</a>  </td>
                    <td colspan="6" align="right">  
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
                                            <li class="active" onclick="javascript:show(1,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                First
                                            </li>
                                            <%                                    } else {
                                            %>
                                            <li class="active-max" onclick="javascript:show(1,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                            <li class="active-max" onclick="javascript:show(<%=pageNumbers.size()%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                Last
                                            </li>
                                            <%
                                            } else {
                                            %>
                                            <li class="active" onclick="javascript:show(<%=pageNumbers.size()%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                            <li class="actived" onclick="javascript:show(<%=pageNumbers.get(i)%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                <%=pageNumbers.get(i)%>
                                            </li>
                                            <%
                                            } else {
                                            %>
                                            <li class="active" onclick="javascript:show(<%=pageNumbers.get(i)%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                            <li class="active-max" onclick="javascript:show(<%=nextpage%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                Next
                                            </li>

                                            <%
                                            } else {

                                            %>
                                            <li class="active" onclick="javascript:show(<%=(nextpage + 1)%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                            <li class="active-max" onclick="javascript:show(<%=previous%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                Previous
                                            </li>

                                            <%
                                            } else {

                                            %>
                                            <li class="active" onclick="javascript:show(<%=(previous - 1)%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                    <input type="text" class="" name="go" id="go" size="3" value="" /><input type="button" value="Go" onclick= "goPage(<%=request.getAttribute("RoomSelected") == null ? 1 : request.getAttribute("RoomSelected")%>,<%=request.getAttribute("CateSelected") == null ? 0 : request.getAttribute("CateSelected")%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);" />
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
                    <td style="height: 30px" ><input id="txtSearchName" value="<%=request.getParameter("name") == null ? "" : request.getParameter("name")%>" name="txtSearchName" type="text" placeholder="Search by Device"  /></td>
                    <td style="height: 30px">
                        <select name="status">
                            <%
                                if (request.getAttribute("statusSelected") != null) {
                                    if (Integer.parseInt(request.getAttribute("statusSelected").toString().trim()) == 0) {
                            %>
                            <option value="2">Status ALL</option>
                            <option selected="selected" value="0">Hide</option>
                            <option value="1">Show</option>
                            <%
                            } else if (Integer.parseInt(request.getAttribute("statusSelected").toString().trim()) == 1) {
                            %>
                            <option value="2">Status ALL</option>
                            <option  value="0">Hide</option>
                            <option selected="selected" value="1">Show</option>
                            <%
                            } else {
                            %>
                            <option selected="selected" value="2">Status ALL</option>
                            <option  value="0">Hide</option>
                            <option  value="1">Show</option>
                            <%
                                }
                            } else {
                            %>
                            <option value="2">Status ALL</option>
                            <option value="0">Hide</option>
                            <option value="1">Show</option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td style="height: 30px" >
                        <select name="roomID">
                            <%
                                Connection cnn = null;
                                Statement st = null;
                                ResultSet rs = null;
                                String sql = "select * from tbl_labroom ";
                                cnn = dbconnect.Connect();
                                try {
                                    st = cnn.createStatement();
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {
                                        int rsID = rs.getInt("roomID");
                                        String rsName = rs.getString("roomName");
                                        checkExits check = new checkExits();
                                        if (check.checkExit("tbl_device", "roomID", rsID) > 0) {
                                            if (request.getAttribute("RoomSelected") != null) {
                                                if (rsID == Integer.parseInt(request.getAttribute("RoomSelected").toString().trim())) {
                            %>
                            <option selected="selected" value="<%=rsID%>"><%=rsName%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=rsID%>"><%=rsName%></option>
                            <%
                                }
                            } else {
                            %>

                            <option value="<%=rsID%>"><%=rsName%></option>
                            <%
                                            }
                                        }
                                    }

                                } catch (Exception ex) {

                                } finally {
                                    try {
                                        rs.close();
                                        st.close();
                                        cnn.close();
                                    } catch (Exception ex1) {

                                    }
                                }

                            %>
                        </select>
                    </td>
                    <td style="height: 30px" >
                        <select name="cateID">
                            <option value="0">ALL Category</option>
                            <%                            Connection cnn1 = null;
                                Statement st1 = null;
                                ResultSet rs1 = null;
                                String sql1 = "select * from tbl_category ";
                                cnn1 = dbconnect.Connect();
                                try {
                                    st1 = cnn1.createStatement();
                                    rs1 = st1.executeQuery(sql1);
                                    while (rs1.next()) {
                                        int rsID = rs1.getInt("cateID");
                                        String rsName = rs1.getString("cateName");
                                        checkExits check = new checkExits();
                                        if (check.checkExit("tbl_device", "cateID", rsID) > 0) {
                                            if (request.getAttribute("CateSelected") != null) {
                                                if (rsID == Integer.parseInt(request.getAttribute("CateSelected").toString().trim())) {
                            %>
                            <option selected="selected" value="<%=rsID%>"><%=rsName%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=rsID%>"><%=rsName%></option>
                            <%
                                }
                            } else {
                            %>

                            <option value="<%=rsID%>"><%=rsName%></option>
                            <%
                                            }
                                        }
                                    }
                                } catch (Exception ex) {

                                } finally {
                                    try {
                                        rs1.close();
                                        st1.close();
                                        cnn1.close();
                                    } catch (Exception ex1) {

                                    }
                                }
                            %>
                        </select>
                    </td>
                    <td style="height: 30px" >
                        <input type="button" onclick="Search();" value="Search"/>
                    </td>
                    <td style="height: 30px;" colspan="3"></td>
                </tr>  
                <tr bgcolor="#78bbe3" >
                    <td class="td-show" width="50px" align="center">ID</td>
                    <td class="td-show" width="200px" align="center">Device name</td>
                    <td class="td-show" width="200px" align="center">Category</td>
                    <td class="td-show" width="150px" align="center">Warranty to</td>
                    <td class="td-show" width="150px" align="center">Warranty From</td>
                    <td class="td-show" width="70px" align="center">Status</td>
                    <td class="td-show" width="120px" align="center" colspan="2" >Action</td>
                </tr>  
                <%
                    String color = "style='background: #e7f5fe;height:30px'";
                    for (int i = 0; i < list.size(); i++) {
                %>  
                <tr>  
                    <%
                        classDevice deviceDTO = (classDevice) list
                                .get(i);
                        if (i % 2 == 0) {
                            out.println("<td style='height:30px' align=\"center\">" + deviceDTO.getdID()
                                    + "</td>");
                            out.println("<td style='height:30px' align=\"center\"> " + deviceDTO.getdName()
                                    + "</td>");
                            out.println("<td style='height:30px' align=\"center\">" + deviceDTO.getCateName()
                                    + "</td>");
                            out.println("<td style='height:30px' align=\"center\">" + deviceDTO.getwTo()
                                    + "</td>");
                            out.println("<td style='height:30px' align=\"center\">" + deviceDTO.getwFrom()
                                    + "</td>");
                            out.println("<td style='height:30px' align=\"center\">" + deviceDTO.getStatus()
                                    + "</td>");
                    %>
                    <td align='center'><a href="?options=DeviceInfo&id=<%=deviceDTO.getdID()%>"><img src="../img/edit.png" width="23px" height="23px" /></a></td>
                    <td align='center'><input title="Delete" type="submit"  name="delete" style="background: url('../img/delete.png');width: 23px;height: 23px;" onclick="BASIC_SelectItem('delete',<%=deviceDTO.getdID() %>)" class="button_img" height="20px" value="" /></td>
                        <%
                            //out.println("<td style='height:30px' align=\"center\"><a href=\"?options=manageruser&id=" + studentDetailsDTO.getId() + "\" title=\"Delete User\"><img src=\"../img/delete.png\" width=\"20px\" height=\"20px\"></a></td>");
                        } else {
                            out.println("<td " + color + " style='height:30px' align=\"center\">" + deviceDTO.getdID()
                                    + "</td>");
                            out.println("<td " + color + " style='height:30px' align=\"center\"> " + deviceDTO.getdName()
                                    + "</td>");
                            out.println("<td " + color + " style='height:30px' align=\"center\">" + deviceDTO.getCateName()
                                    + "</td>");
                            out.println("<td " + color + " style='height:30px' align=\"center\">" + deviceDTO.getwTo()
                                    + "</td>");
                            out.println("<td " + color + " style='height:30px' align=\"center\">" + deviceDTO.getwFrom()
                                    + "</td>");
                            out.println("<td " + color + " style='height:30px' align=\"center\">" + deviceDTO.getStatus()
                                    + "</td>");
                        %>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;"><a href="?options=DeviceInfo&id=<%=deviceDTO.getdID()%>"><img src="../img/edit.png" width="23px" height="23px" /></a></td>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;"><input title="Delete" type="submit"  name="delete" style="background: url('../img/delete.png');width: 23px;height: 23px;" onclick="BASIC_SelectItem('delete',<%=deviceDTO.getdID() %>)" class="button_img" height="20px" value="" /></td>
                        <%
                                //out.println("<td " + color + " align=\"center\"><a href=\"?options=manageruser&id=" + studentDetailsDTO.getId() + "\" title=\"Delete User\"><img src=\"../img/delete.png\" width=\"20px\" height=\"20px\"></a></td>");
                            }

                        %>  
                </tr>  
                <%                }
                %>  

                <tr>
                    <td colspan="8" align="center">
                        <input type="text" name="ID" id="ID" style="visibility: hidden"  />
                        <input type="text" name="act" id="act" style="visibility: hidden"  />
                    </td>
                </tr>
                <tr>
                    <td colspan="8" align="center">
                        <div id='content' ></div>
                    </td>
                </tr>
            </table> 
        </form>
    </body>  
</html>  
<script type="text/javascript">

    var form = $('#test');
    $('#content').hide();//chu y
    form.submit(function() {



        $.ajax({
            type: form.attr('method'),
            url: form.attr('action'),
            data: form.serialize(),
            success: function(data) {
                var result = data;
                $('#content').show().html(result).fadeOut(3000, function() {
                    window.location.href = "?options=ManagerDevice";
                });

            }
        });

        return false;
    }); </script>
