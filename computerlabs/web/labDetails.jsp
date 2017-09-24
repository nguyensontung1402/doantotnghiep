


<%@page import="labroomclient.classDeviceClient"%>
<%@page import="device.checkExits"%>

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
        <title>Manager</title>  
        <script>
            function BASIC_SelectItem()
            {
                var v_room = "";
                for (var i = 0; i < document.test.chk.length; i++)

                {
                    if (document.test.chk[i].checked)
                    {
                        v_room += (v_room ? '/' : '') + document.test.chk[i].value;
                    }
                }
                if(v_room!=""){
                    window.location.href='?option=sendComplaint&listDevice='+v_room;
                }else{
                    alert('Please you choose one accessory!');
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

                    xmlHttpRe.open("GET", "showDeviceClient?pageNumber=" + getText + strCate + strStatus + "&name=" + v_name, true);// chú ý
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

                    xmlHttpRe.open("GET", "showDeviceClient?pageNumber=" + c_value + strStatus + strRoom + strCate + "&name=" + v_name, true);// chú ý
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

                    xmlHttpRe.open("GET", "showDeviceClient?name=" + v_name + "&status=" + v_status + "&cateID=" + v_cateID + "&roomID=" + v_roomID, true);// chú ý
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

        <form action="" name="test" id="test" method="post">
            <table cellpadding="1px" border="0" cellspacing="1px" id="fcuk" width="950px" align="center">  


                <tr>  

                    <td colspan="8" align="right">  
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

                    <td style="height: 30px" colspan="8">
                        <input id="txtSearchName" value="<%=request.getParameter("name") == null ? "" : request.getParameter("name")%>" name="txtSearchName" type="text" placeholder="Search by Device"  />
                        <select name="roomID" style="width: 200px;">
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

                        <select name="cateID" style="width: 200px;">
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

                        <input type="button" class="button_example" onclick="Search();" value="Search"/>
                        <select name="status" style="width: 200px;visibility: hidden"><%--Bo?--%>
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
                </tr>  
                <tr bgcolor="#78bbe3" >
                    <td class="td-show" width="50px" align="center"></td>
                    <td class="td-show" width="50px" align="center">ID</td>
                    <td class="td-show" width="240px" align="center">Device name</td>
                    <td class="td-show" width="240px" align="center">Category</td>
                    <td class="td-show" width="150px" align="center">Warranty to</td>
                    <td class="td-show" width="150px" align="center">Warranty From</td>
                    <td class="td-show" width="70px" align="center">Status</td>
                </tr>  
                <%
                    String color = "style='background: #e7f5fe;height:30px'";
                    for (int i = 0; i < list.size(); i++) {
                %>  
                <tr>  
                    <%
                        classDeviceClient deviceDTO = (classDeviceClient) list
                                .get(i);
                        if (i % 2 == 0) {
                    %>
                    <td style="height:30px" align="center">
                        <input type="checkbox" id="chk" name="chk" value="<%=deviceDTO.getdID()%>" title="<%=deviceDTO.getdID()%>" />
                    </td>
                    <%
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
                    <%
                    } else {
                    %>
                    <td style="height:30px;background: #e7f5fe;" align="center">
                        <input type="checkbox" id="chk" name="chk" value="<%=deviceDTO.getdID()%>" title="<%=deviceDTO.getdID()%>" />
                    </td>
                    <%
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
                    <%
                        }

                    %>  
                </tr>  
                <%                }
                %>  
                <tr>
                    <td colspan="8" align="center">
                        <input type="button" name="send" id="send" class="button_example" onclick="BASIC_SelectItem();" value="Send Complaint"  />
                       
                    </td>
                </tr>
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
