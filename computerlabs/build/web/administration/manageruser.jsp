


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="computerlabs.dbconnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="computerlabs.deleteUser"%>
<%@page import="computerlabs.classUser"%>
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
            function BASIC_SelectItem(id)
            {
                var getID = id;
                document.test.ID.value = getID;
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
            function show(pagenumber) {
                new setXMLHttpRe();
                var getText = pagenumber;  //Used to prevent caching during ajax call
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showUser?pageNumber=" + getText, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function goPage()
            {
                var c_value = "";
                c_value = document.test.go.value;
                new setXMLHttpRe();
                var getText = c_value;  //Used to prevent caching during ajax call
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showUser?pageNumber=" + c_value, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function deleteUser(userID)
            {
                new setXMLHttpRe();
                var getText = userID;  //Used to prevent caching during ajax call
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showUser?userID=" + getText, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function Search()
            {
                var v_user = "";
                var v_fullname = "";
                var v_status = "";
                var v_department = "";
                var v_HOD = "";
                v_user = document.test.txtSearchName.value;
                v_fullname = document.test.txtFullName.value;
                v_status = document.test.status.value;
                v_department = document.test.txtDepartment.value;
                v_HOD = document.test.HOD.value;
                new setXMLHttpRe();
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showUser?user=" + v_user + "&fullname=" + v_fullname + "&status=" + v_status + "&department=" + v_department + "&hod=" + v_HOD, true);// chú ý
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
            List list = (List) session.getAttribute("studentDetails");
        %>  

        <%
            List pageNumbers = (List) session.getAttribute("pages");
        %>  

        <form action="../updateStatusAccount" name="test" id="test" method="post">
            <table cellpadding="1px" cellspacing="1px" id="fcuk" width="950px" align="center">  


                <tr>  
                    <td colspan="2" align="center"><a class="button_example" href="?options=CreateUser">Create User</a>  </td>
                    <td colspan="5" align="right">  
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
                                            <li class="active" onclick="javascript:show(1);">
                                                First
                                            </li>
                                            <%                                    } else {
                                            %>
                                            <li class="active-max" onclick="javascript:show(1);">
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
                                            <li class="active-max" onclick="javascript:show(<%=pageNumbers.size()%>);">
                                                Last
                                            </li>
                                            <%
                                            } else {
                                            %>
                                            <li class="active" onclick="javascript:show(<%=pageNumbers.size()%>);">
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
                                            <li class="actived" onclick="javascript:show(<%=pageNumbers.get(i)%>);">
                                                <%=pageNumbers.get(i)%>
                                            </li>
                                            <%
                                            } else {
                                            %>
                                            <li class="active" onclick="javascript:show(<%=pageNumbers.get(i)%>);">
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
                                            <li class="active-max" onclick="javascript:show(<%=nextpage%>);">
                                                Next
                                            </li>

                                            <%
                                            } else {

                                            %>
                                            <li class="active" onclick="javascript:show(<%=(nextpage + 1)%>);">
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
                                            <li class="active-max" onclick="javascript:show(<%=previous%>);">
                                                Previous
                                            </li>

                                            <%
                                            } else {

                                            %>
                                            <li class="active" onclick="javascript:show(<%=(previous - 1)%>);">
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
                                    <input type="text" class="" name="go" id="go" size="3" value="" /><input type="button" value="Go" onclick= "goPage();" />
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
                    <td style="height: 30px" >
                        <select name="status">
                            <option value="ALL">Status ALL</option>
                            <option value="0">Lock</option>
                            <option value="1">UnLock</option>
                        </select>
                    </td>
                    <td style="height: 30px" >
                        <select name="txtDepartment">

                            <option value="ALL">ALL Department</option>
                            <option value="2">Instructors</option>
                            <option value="3">Technical   Staff</option>
                            <option value="4">Students</option>
                        </select>
                    </td>
                    <td style="height: 30px" >
                        <select name="HOD">
                            <option value="ALL">Status HOD</option>
                            <option value="1">HOD</option>
                            <option value="0">Not HOD</option>
                        </select>
                    </td>
                    <td style="height: 30px" >
                        <input type="button" onclick="Search();" value="Search"/>
                    </td>
                    <td style="height: 30px;" colspan="3"></td>
                </tr>  
                <tr bgcolor="#78bbe3" >
                    <td class="td-show" width="50px" align="center">ID</td>
                    <td class="td-show" width="200px" align="center">User name</td>
                    <td class="td-show" width="180px" align="center">Full name</td>
                    <td class="td-show" width="70px" align="center">Status</td>
                    <td class="td-show" width="70px" align="center">Department</td>
                    <td class="td-show" width="100px" align="center">HOD</td>
                    <td class="td-show" width="120px" align="center" colspan="3" >Action</td>
                </tr>  
                <%
                    String color = "style='background: #e7f5fe;height:30px'";
                    for (int i = 0; i < list.size(); i++) {
                %>  
                <tr>  
                    <%
                        classUser studentDetailsDTO = (classUser) list
                                .get(i);
                        if (i % 2 == 0) {
                            out.println("<td style='height:30px' align=\"center\">" + studentDetailsDTO.getId()
                                    + "</td>");
                            out.println("<td style='height:30px' > " + studentDetailsDTO.getUsername()
                                    + "</td>");
                            out.println("<td style='height:30px' >" + studentDetailsDTO.getFullname()
                                    + "</td>");
                    %>
                    <td style='height:30px' align="center">
                        <select name="statusUser<%=studentDetailsDTO.getId()%>" >
                            <%
                                if (studentDetailsDTO.getStatus().trim().equalsIgnoreCase("Lock")) {
                            %>
                            <option value="0" >Lock</option>
                            <option value="1" >Unlock</option>
                            <%
                            } else {
                            %>
                            <option value="0" >Lock</option>
                            <option selected="selected" value="1" >Unlock</option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td style="height:30px;" align="center">
                        <select name="department<%=studentDetailsDTO.getId()%>" >
                            <%
                                if (studentDetailsDTO.getDepartmentID().trim().equalsIgnoreCase("Instructors")) {
                            %>
                            <option value="2" >Instructors</option>
                            <option value="3" >Technical Staff</option>
                            <option value="4" >Students</option>
                            <%
                            } else if (studentDetailsDTO.getDepartmentID().trim().equalsIgnoreCase("Students")) {
                            %>
                            <option value="2" >Instructors</option>
                            <option  value="3" >Technical Staff</option>
                            <option selected="selected" value="4" >Students</option>
                            <%
                            } else {
                            %>
                            <option value="2" >Instructors</option>
                            <option  selected="selected" value="3" >Technical Staff</option>
                            <option value="4" >Students</option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td style="height:30px;" align="center">
                        <select name="HOD<%=studentDetailsDTO.getId()%>" >
                            <%
                                if (studentDetailsDTO.getHOD().trim().equalsIgnoreCase("HOD")) {
                            %>
                            <option value="1" >HOD</option>
                            <option value="0" >Not HOD</option>                          
                            <%
                            } else {
                            %>
                            <option value="1" >HOD</option>
                            <option selected="selected"  value="0" >Not HOD</option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td align='center' ><a href="?options=manageruser&uID=<%=studentDetailsDTO.getId() %>"><img title="View" src="../img/preview.png" width="23px" height="23px" /></a></td>  
                    <td align='center'><input title="Update" type="submit" style="background: url('../img/edit.png');width: 23px;height: 23px;" name="update" onclick="BASIC_SelectItem(<%=studentDetailsDTO.getId()%>)" class="button_img" height="20px" value="" /></td>
                    <td align='center'><input type="button" title="Delete"  name="delete" style="background: url('../img/delete.png');width: 23px;height: 23px;" onclick="deleteUser(<%=studentDetailsDTO.getId()%>)" class="button_img" height="20px" value="" /></td>
                        <%
                            //out.println("<td style='height:30px' align=\"center\"><a href=\"?options=manageruser&id=" + studentDetailsDTO.getId() + "\" title=\"Delete User\"><img src=\"../img/delete.png\" width=\"20px\" height=\"20px\"></a></td>");
                        } else {
                            out.println("<td " + color + " align=\"center\">" + studentDetailsDTO.getId()
                                    + "</td>");
                            out.println("<td " + color + "> " + studentDetailsDTO.getUsername()
                                    + "</td>");
                            out.println("<td " + color + " >" + studentDetailsDTO.getFullname()
                                    + "</td>");
                        %>
                    <td style="height:30px;background: #e7f5fe;" align="center">
                        <select name="statusUser<%=studentDetailsDTO.getId()%>" >
                            <%
                                if (studentDetailsDTO.getStatus().trim().equalsIgnoreCase("Lock")) {
                            %>
                            <option value="0" >Lock</option>
                            <option value="1" >Unlock</option>
                            <%
                            } else {
                            %>
                            <option value="0" >Lock</option>
                            <option selected="selected" value="1" >Unlock</option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td style="height:30px;background: #e7f5fe;" align="center">
                        <select name="department<%=studentDetailsDTO.getId()%>" >
                            <%
                                if (studentDetailsDTO.getDepartmentID().trim().equalsIgnoreCase("Instructors")) {
                            %>
                            <option value="2" >Instructors</option>
                            <option value="3" >Technical Staff</option>
                            <option value="4" >Students</option>
                            <%
                            } else if (studentDetailsDTO.getDepartmentID().trim().equalsIgnoreCase("Students")) {
                            %>
                            <option value="2" >Instructors</option>
                            <option  value="3" >Technical Staff</option>
                            <option selected="selected" value="4" >Students</option>
                            <%
                            } else {
                            %>
                            <option value="2" >Instructors</option>
                            <option  selected="selected" value="3" >Technical Staff</option>
                            <option value="4" >Students</option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td style="height:30px;background: #e7f5fe;" align="center">
                        <select name="HOD<%=studentDetailsDTO.getId()%>" >
                            <%
                                if (studentDetailsDTO.getHOD().trim().equalsIgnoreCase("HOD")) {
                            %>
                            <option value="1" >HOD</option>
                            <option value="0" >Not HOD</option>                          
                            <%
                            } else {
                            %>
                            <option value="1" >HOD</option>
                            <option selected="selected"  value="0" >Not HOD</option>
                            <%
                                }
                            %>
                        </select>
                    </td>

                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;"><a href="?options=manageruser&uID=<%=studentDetailsDTO.getId() %>"><img title="View" src="../img/preview.png" width="23px" height="23px" /></a></td>                   
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;"><input title="Update" type="submit" style="background: url('../img/edit.png');width: 23px;height: 23px;" name="update" id="update" onclick="BASIC_SelectItem(<%=studentDetailsDTO.getId()%>)" class="button_img" height="20px" value="" /></td>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;"><input title="Delete" type="button"  name="delete" style="background: url('../img/delete.png');width: 23px;height: 23px;" onclick="deleteUser(<%=studentDetailsDTO.getId()%>)" class="button_img" height="20px" value="" /></td>
                        <%
                                //out.println("<td " + color + " align=\"center\"><a href=\"?options=manageruser&id=" + studentDetailsDTO.getId() + "\" title=\"Delete User\"><img src=\"../img/delete.png\" width=\"20px\" height=\"20px\"></a></td>");
                            }

                        %>  
                </tr>  
                <%                }
                %>  

                <tr>
                    <td colspan="7" align="center"><input type="text" name="ID" id="ID" style="visibility: hidden"  /></td>
                </tr>
                <tr>
                    <td colspan="7" align="center">
                            <div id='content' >
                            <%=request.getAttribute("suc") == null ? "" : request.getAttribute("suc")%>
                            <%=request.getAttribute("lock") == null ? "" : request.getAttribute("lock")%>
                            <%=request.getAttribute("fail") == null ? "" : request.getAttribute("fail")%></div>
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
                 $('#content').show().html(result).delay(4000).fadeOut();

            }
        });
         
        return false;
    }); </script>
<div style="font-size: 10px; color: rgb(204, 204, 204);"></div>
<%
    if(request.getParameter("uID")!=null){
%>
<div id="boxes">
<div style="top: 199.5px; left: 551.5px; display: none;" id="dialog" class="window">
    <%
        int userID=Integer.parseInt(request.getParameter("uID").toString().trim());
        Connection cnn=null;
        Statement st=null;
        ResultSet rs=null;
        String sql="select * from tbl_user where userID="+userID;
        SimpleDateFormat forma=new SimpleDateFormat("EE, MMM d,yyyy");
        cnn=dbconnect.Connect();
        try{
        st=cnn.createStatement();
        rs=st.executeQuery(sql);
        if(rs.next()){
            String username=rs.getString("username");
            String fullname=rs.getString("fullname");
            String address=rs.getString("address");
            int  gender=rs.getInt("gender");
            String birthday= forma.format(rs.getDate("birthday"));
            int status=rs.getInt("status");
            int departmentID=rs.getInt("departmentID");
            int HOD=rs.getInt("HOD");
            String Email=rs.getString("Email");
            String strGender="";
            if(gender==1){
                strGender="Female";
            }else{
                strGender="Male";
            }
            String strStatus="";
            if(status==1){
                strStatus="Unlock";
            }else{
                strStatus="Lock";
            }
            String strDepart="";
            if(departmentID==2){
                strDepart="Instructors";
            }else if(departmentID==3){
                strDepart="Technical Staff";
            }else if(departmentID==4){
                strDepart="Students";
            }
             String strHOD="";
            if(HOD==1){
                strHOD="Head of department";
            }else{
                strHOD="Not Head of department";
            }
    %>
    <table style="width: 500px;" cellpadding="5px" cellspacing="0px">
        <tr>
            <td align="left" colspan="2">
                <div style="background: url('../img/bg-title2.png');width: 430px;height: 30px;-moz-border-radius: 10px;
-webkit-border-radius: 10px;color: white;text-align: center;padding:5px 0px 0px 0px">User Infomation</div>
            </td>
        </tr>
        <tr>
            <td align="left" class="td-popup">
                <div class="td-left-pop">&nbsp;&nbsp;&nbsp;User name:</div></td>
            <td > <div class="td-rigth-pop"><%=username %></div></td>
        </tr>
        <tr>
            <td class="td-popup"><div class="td-left-pop">&nbsp;&nbsp;&nbsp;Full name:</div></td>
            <td><div class="td-rigth-pop"><%=fullname %></div></td>
        </tr>
         <tr>
             <td class="td-popup"><div class="td-left-pop">&nbsp;&nbsp;&nbsp;Address:</div></td>
             <td><div class="td-rigth-pop"><%=address %></div></td>
        </tr>
         <tr>
             <td class="td-popup"><div class="td-left-pop">&nbsp;&nbsp;&nbsp;Email:</div></td>
             <td><div class="td-rigth-pop"><%=Email %></div></td>
        </tr>
         <tr>
             <td class="td-popup"><div class="td-left-pop">&nbsp;&nbsp;&nbsp;Birth day:</div></td>
             <td><div class="td-rigth-pop"><%=birthday %></div></td>
        </tr>
         <tr>
             <td class="td-popup"><div class="td-left-pop">&nbsp;&nbsp;&nbsp;Gender:</div></td>
             <td><div class="td-rigth-pop"><%=strGender %></div></td>
        </tr>
         <tr>
             <td class="td-popup"><div class="td-left-pop">&nbsp;&nbsp;&nbsp;Department:</div></td>
             <td><div class="td-rigth-pop"><%=strDepart %></div></td>
        </tr>
         <tr>
             <td class="td-popup"><div class="td-left-pop">&nbsp;&nbsp;&nbsp;HOD:</div></td>
             <td><div class="td-rigth-pop"><%=strHOD %></div></td>
        </tr>
        <tr>
            <td class="td-popup"><div class="td-left-pop">&nbsp;&nbsp;&nbsp;Status:</div></td>
            <td><div class="td-rigth-pop"><%=strStatus %></div></td>
        </tr>
        <tr><td align="center" ><a href="#"  class="close"><img src="../img/modal_close.png" /></a></td></tr>
    </table>
    <%
        }
        }catch(Exception ex){
            
        }finally{
            try{
            rs.close();
            st.close();
            cnn.close();
            }catch(Exception ex){
                
            }
        }
    %>

</div>
<!-- Mask to cover the whole screen -->
<div style="width: 1478px; height: 602px; display: none; opacity: 0.8;" id="mask"></div>
</div>
<%
    }
%>