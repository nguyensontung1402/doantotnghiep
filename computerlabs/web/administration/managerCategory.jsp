


<%@page import="categorydevice.classCate"%>
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
        <script type="text/javascript">
            $(document).ready(function() {
                //called when key is pressed in textbox
                $("#cateNameUp").keypress(function(e)
                {
                    $("#error").hide();
                    $("#autoSuggestionsList").hide();
                    //if the letter is not digit then display error and don't type anything
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57) && (e.which < 65 || e.which > 90) && (e.which < 97 || e.which > 122))
                    {
                        //display error message
                        $("#error").html("No Special Characters.Only number & alphabets").show();
                        return false;
                    }
                });
            });
            function lookup(txtName, ID) {
                if (txtName.length < 1) {
                    $('#autoSuggestionsList').hide();
                } else {
                    $.post("../checkCateName", {name: "" + txtName + "", cID: "" + ID + ""}, function(data) {
                        $('#autoSuggestionsList').html(data).show();
                    });
                }
            }

        </script>

        <%----%>
        <script type="text/javascript">
            $(document).ready(function() {
                //called when key is pressed in textbox
                $("#namecreate").keypress(function(e)
                {
                    $("#error").hide();
                    $("#autoSuggestionsList").hide();
                    //if the letter is not digit then display error and don't type anything
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57) && (e.which < 65 || e.which > 90) && (e.which < 97 || e.which > 122))
                    {
                        //display error message
                        $("#error").html("No Special Characters.Only number & alphabets").show();
                        return false;
                    }
                });
            });
            function lookupCreate(txtuser) {
                if (txtuser.length < 1) {
                    $('#autoSuggestionsList').hide();
                } else {
                    $.post("../checkCateNameCreate", {namecreate: "" + txtuser + ""}, function(data) {
                        $('#autoSuggestionsList').html(data).show();
                    });
                }
            }

        </script>
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
                        //window.location.href = "?options=ManagerTypeAccessory";
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
            function show(pagenumber,status) {
                new setXMLHttpRe();
                var getText = pagenumber;  //Used to prevent caching during ajax call
                var strStatus = "&status=" + status;
                var cateName = "";
                cateName = document.test.cateName.value;
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showCate?pageNumber=" + getText+strStatus+"&cateName"+cateName, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function goPage(status)
            {
                var c_value = "";
                c_value = document.test.go.value;
                new setXMLHttpRe();
                var getText = c_value;  //Used to prevent caching during ajax call
                 var strStatus = "&status=" + status;
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showCate?pageNumber=" + c_value+strStatus, true);// chú ý
                    xmlHttpRe.onreadystatechange = handleResponse;
                    xmlHttpRe.send(null);
                }
            }
            function Search()
            {
                var v_cateName = "";
                var v_status = "";
                v_cateName = document.test.cateName.value;
                v_status = document.test.status.value;
                new setXMLHttpRe();
                if (xmlHttpRe) {

                    xmlHttpRe.open("GET", "../showCate?cateName=" + v_cateName + "&status=" + v_status, true);// chú ý
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

        <form action="../processCate" name="test" id="test" method="post">
            <table cellpadding="1px" cellspacing="1px" border="0" id="fcuk" width="850px" align="center">  


                <tr>  

                    <td colspan="4" align="right">  
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
                                            <li class="active" onclick="javascript:show(1,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                First
                                            </li>
                                            <%                                    } else {
                                            %>
                                            <li class="active-max" onclick="javascript:show(1,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                            <li class="active-max" onclick="javascript:show(<%=pageNumbers.size()%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                Last
                                            </li>
                                            <%
                                            } else {
                                            %>
                                            <li class="active" onclick="javascript:show(<%=pageNumbers.size()%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                            <li class="actived" onclick="javascript:show(<%=pageNumbers.get(i)%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                <%=pageNumbers.get(i)%>
                                            </li>
                                            <%
                                            } else {
                                            %>
                                            <li class="active" onclick="javascript:show(<%=pageNumbers.get(i)%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                            <li class="active-max" onclick="javascript:show(<%=nextpage%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                Next
                                            </li>

                                            <%
                                            } else {

                                            %>
                                            <li class="active" onclick="javascript:show(<%=(nextpage + 1)%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                            <li class="active-max" onclick="javascript:show(<%=previous%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
                                                Previous
                                            </li>

                                            <%
                                            } else {

                                            %>
                                            <li class="active" onclick="javascript:show(<%=(previous - 1)%>,<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);">
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
                                    <input type="text" class="" name="go" id="go" size="3" value="" /><input type="button" value="Go" onclick= "goPage(<%=request.getAttribute("statusSelected") == null ? 2 : request.getAttribute("statusSelected")%>);" />
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

                    <td colspan="4" style="height: 30px" >
                        <input id="cateName" value="<%=request.getParameter("cateName")==null?"":request.getParameter("cateName") %>" name="cateName" type="text" placeholder="Search by Category"  />
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
                        <input type="button" class="button_example" onclick="Search();" value="Search"/>
                        <a href="?options=ManagerCategoryDevice&actCreate=Create" class="button_example">Create Category</a>
                    </td>
                </tr>  
                <tr bgcolor="#78bbe3" >
                    <td class="td-show" width="80px" align="center">ID</td>
                    <td class="td-show" width="450px" align="center">Cate name</td>
                    <td class="td-show" width="100px" align="center">Status</td>
                    <td class="td-show" width="220px" align="center" colspan="2" >Action</td>
                </tr>  
                <%
                    String color = "style='background: #e7f5fe;height:30px'";
                    String cateN="";
                    String statusN = "";
                    if (request.getAttribute("statusSelected") != null) {
                        statusN = "&status=" + request.getAttribute("statusSelected");
                    }
                    if(request.getParameter("cateName")!=null){
                        cateN="&cateName="+request.getParameter("cateName");
                    }
                    for (int i = 0; i < list.size(); i++) {
                %>  
                <tr>  
                    <%
                        classCate studentDetailsDTO = (classCate) list
                                .get(i);
                        if (i % 2 == 0) {
                            out.println("<td style='height:30px' align=\"center\">" + studentDetailsDTO.getCateID()
                                    + "</td>");
                            if (request.getParameter("cID") != null) {
                                if (Integer.parseInt(request.getParameter("cID").toString().trim()) == studentDetailsDTO.getCateID()) {
                    %>
                    <td class="row-td-backgroud-select" align="center">

                        <input name="cateNameUp" id="cateName" onkeyup="lookup(this.value,<%=studentDetailsDTO.getCateID()%>);" class="validate[required,minSize[1]] text-input" value="<%=studentDetailsDTO.getCateName()%>" type="text"/>
                        <div style="width: 50px;">
                            <div style="display: none;" id="autoSuggestionsList"></div>
                            <div style="display: none;" id="error"></div>

                        </div>
                    </td>
                    <td  class="row-td-backgroud-select" align="center">
                        <select name="statusUp">
                            <%
                                if (studentDetailsDTO.getStatus() == 1) {
                            %>
                            <option value="1">Show</option>
                            <option value="0">Hide</option>
                            <%
                            } else {
                            %>
                            <option value="1">Show</option>
                            <option value="0" selected="selected">Hide</option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <%
                    } else {
                    %>
                    <td style="height:30px" align="center"><%=studentDetailsDTO.getCateName()%></td>
                    <td style="height:30px" align="center">
                        <%
                            if (studentDetailsDTO.getStatus() == 1) {
                                out.println("Show");
                            } else {
                                out.println("Hide");

                            }
                        %>
                    </td>
                    <%
                        }
                    } else {
                    %>

                    <td style="height:30px" align="center"><%=studentDetailsDTO.getCateName()%></td>
                    <td style="height:30px" align="center">
                        <%
                            if (studentDetailsDTO.getStatus() == 1) {
                                out.println("Show");
                            } else {
                                out.println("Hide");

                            }
                        %>
                    </td>
                    <%
                        }
                    %>

                    <%
                        if (request.getParameter("cID") != null) {
                            if (Integer.parseInt(request.getParameter("cID").toString().trim()) == studentDetailsDTO.getCateID()) {
                    %>
                    <td align='center' style="height:30px;width: 40px;">
                        <input title="Update" type="submit" style="background: url('../img/edit2.png');width: 23px;height: 23px;" name="update" onclick="BASIC_SelectItem('update',<%=studentDetailsDTO.getCateID()%>)" class="button_img" height="20px" value="" />
                    </td>
                    <td align='center' style="height:30px;width: 40px;"><a href="?options=ManagerCategoryDevice"><img src="../img/back.png" width="23px" height="20px" /></a></td>
                            <%
                            } else {
                            %>
                    <td align='center' style="height:30px;width: 40px;">
                        <a href="?options=ManagerCategoryDevice<%=cateN %><%=statusN%>&pageNumber=<%=pageSelected%>&cID=<%=studentDetailsDTO.getCateID()%>"><img src="../img/edit.png" width="23px" height="23px" /></a>
                    </td>
                    <td align='center' style="height:30px;width: 40px;"><input title="Delete" type="submit"  name="delete" style="background: url('../img/delete.png');width: 23px;height: 23px;" onclick="BASIC_SelectItem('delete',<%=studentDetailsDTO.getCateID()%>)" class="button_img" height="20px" value="" /></td>
                        <%
                            }
                        } else {
                        %>
                    <td align='center' style="height:30px;width: 40px;">
                        <a href="?options=ManagerCategoryDevice<%=cateN %><%=statusN%>&pageNumber=<%=pageSelected%>&cID=<%=studentDetailsDTO.getCateID()%>"><img src="../img/edit.png" width="23px" height="23px" /></a>
                    </td>
                    <td align='center' style="height:30px;width: 40px;"><input title="Delete" type="submit"  name="delete" style="background: url('../img/delete.png');width: 23px;height: 23px;" onclick="BASIC_SelectItem('delete',<%=studentDetailsDTO.getCateID()%>)" class="button_img" height="20px" value="" /></td>
                        <%
                            }
                        %>
                        <%
                            //out.println("<td style='height:30px' align=\"center\"><a href=\"?options=manageruser&id=" + studentDetailsDTO.getId() + "\" title=\"Delete User\"><img src=\"../img/delete.png\" width=\"20px\" height=\"20px\"></a></td>");
                        } else {
                            out.println("<td " + color + " align=\"center\">" + studentDetailsDTO.getCateID()
                                    + "</td>");
                            if (request.getParameter("cID") != null) {
                                if (Integer.parseInt(request.getParameter("cID").toString().trim()) == studentDetailsDTO.getCateID()) {
                        %>
                    <td style="height:30px" align="center"  class="row-td-backgroud-select">

                        <input name="cateNameUp" id="cateName" onkeyup="lookup(this.value,<%=studentDetailsDTO.getCateID()%>);" class="validate[required,minSize[1]] text-input" value="<%=studentDetailsDTO.getCateName()%>" type="text"/>
                        <div style="width: 50px;">
                            <div style="display: none;" id="autoSuggestionsList"></div>
                            <div style="display: none;" id="error"></div>

                        </div>
                    </td>
                    <td  class="row-td-backgroud-select" align="center">
                        <select name="statusUp">
                            <%
                                if (studentDetailsDTO.getStatus() == 1) {
                            %>
                            <option value="1">Show</option>
                            <option value="0">Hide</option>
                            <%
                            } else {
                            %>
                            <option value="1">Show</option>
                            <option value="0" selected="selected">Hide</option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <%
                    } else {
                    %>
                    <td style="height:30px" class="row-td-backgroud" align="center"><%=studentDetailsDTO.getCateName()%></td>
                    <td style="height:30px"  class="row-td-backgroud" align="center">
                        <%
                            if (studentDetailsDTO.getStatus() == 1) {
                                out.println("Show");
                            } else {
                                out.println("Hide");

                            }
                        %>
                    </td>
                    <%
                        }
                    } else {
                    %>

                    <td style="height:30px" class="row-td-backgroud" align="center"><%=studentDetailsDTO.getCateName()%></td>
                    <td style="height:30px" class="row-td-backgroud" align="center">
                        <%
                            if (studentDetailsDTO.getStatus() == 1) {
                                out.println("Show");
                            } else {
                                out.println("Hide");

                            }
                        %>
                    </td>
                    <%
                        }
                    %>


                    <%
                        if (request.getParameter("cID") != null) {
                            if (Integer.parseInt(request.getParameter("cID").toString().trim()) == studentDetailsDTO.getCateID()) {
                    %>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;">
                        <input title="Update" type="submit" style="background: url('../img/edit2.png');width: 23px;height: 23px;" name="update" onclick="BASIC_SelectItem('update',<%=studentDetailsDTO.getCateID()%>)" class="button_img" height="20px" value="" />
                    </td>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;"><a href="?options=ManagerCategoryDevice"><img src="../img/back.png" width="23px" height="20px" /></a></td>
                            <%
                            } else {
                            %>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;">
                        <a href="?options=ManagerCategoryDevice<%=cateN %><%=statusN%>&pageNumber=<%=pageSelected%>&cID=<%=studentDetailsDTO.getCateID()%>"><img src="../img/edit.png" width="23px" height="23px" /></a>
                    </td>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;"><input title="Delete" type="submit"  name="delete" style="background: url('../img/delete.png');width: 23px;height: 23px;" onclick="BASIC_SelectItem('delete',<%=studentDetailsDTO.getCateID()%>)" class="button_img" height="20px" value="" /></td>
                        <%
                            }
                        } else {
                        %>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;">
                        <a href="?options=ManagerCategoryDevice<%=cateN %><%=statusN%>&pageNumber=<%=pageSelected%>&cID=<%=studentDetailsDTO.getCateID()%>"><img src="../img/edit.png" width="23px" height="23px" /></a>
                    </td>
                    <td align='center' style="height:30px;background: #e7f5fe;width: 40px;"><input title="Delete" type="submit"  name="delete" style="background: url('../img/delete.png');width: 23px;height: 23px;" onclick="BASIC_SelectItem('delete',<%=studentDetailsDTO.getCateID()%>)" class="button_img" height="20px" value="" /></td>
                        <%
                            }
                        %>         
                        <%
                                //out.println("<td " + color + " align=\"center\"><a href=\"?options=manageruser&id=" + studentDetailsDTO.getId() + "\" title=\"Delete User\"><img src=\"../img/delete.png\" width=\"20px\" height=\"20px\"></a></td>");
                            }

                        %>  
                </tr>  
                <%                }
                %>  

                <tr>
                    <td colspan="4" align="center">
                        <input type="text" name="ID" id="ID" style="visibility: hidden"  />
                        <input type="text" name="act" id="act" style="visibility: hidden"  />
                    </td>

                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <table>
                            <tr>
                                <td>
                                    <%
                                        String visibly="";
                                        if (request.getParameter("actCreate") == null) {
                                             visibly = "visibility: hidden;";
                                         }
                                    %>
                                    <div class="site-input-div" style="<%=visibly %>">
                                        <div class="site-input-left"><img src="../img/category.png"/></div>
                                        <div class="site-input-rigth">
                                            <input placeholder="Please enter name..." id="namecreate" onkeyup="lookupCreate(this.value);" style="  width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                                   -webkit-border-radius: 5px;" name="namecreate" type="text" class="validate[required,minSize[3]] text-input"  />
                                        </div>   
                                    </div>
                                </td>
                                <td>
                                    <div style="width: 30px;<%=visibly %>">
                                        <div style="display: none;" id="autoSuggestionsList"></div>
                                        <div style="display: none;" id="error"></div>

                                    </div>
                                </td>
                                <td>
                                    <select name="statusCreate" style="width: 120px;height: 26px;<%=visibly %>">
                                        <option value="1">Show</option>
                                        <option value="0">Hide</option>
                                    </select>
                                </td>
                                <td><input style="<%=visibly %>" title="Create" type="submit"  name="delete" onclick="BASIC_SelectItem('create', 0)" class="button_example" height="20px" value="Create" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <div id='content' >
                        </div>
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
                    window.location.href = "?options=ManagerCategoryDevice";
                });

            }
        });

        return false;
    }); </script>
