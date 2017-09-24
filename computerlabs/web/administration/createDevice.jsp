<%-- 
    Document   : createuser.jsp
    Created on : Apr 17, 2014, 9:50:50 PM
    Author     : User
--%>

<%@page import="device.checkExits"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="computerlabs.dbconnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script src = "../js/jquery-1.8.3.js" ></script>
        <script src="../js/jquery-ui.js"></script>



        <SCRIPT type='text/javascript' >//mai sua
            //this function determines how changing the value of the dropdown will affect the content of the textboxes
            function DeviceInfo() {
                var sel = document.ajaxform.typeaccess.value; //gets the index of the select
                var listcheck = document.ajaxform.txtResultAccess.value;
                var listPro = "";
                if (listcheck != "") {
                    if (document.ajaxform.txtList.value != "") {
                        listPro = listcheck + "/" + document.ajaxform.txtList.value;
                    } else {
                        listPro = listcheck;
                    }
                } else {
                    listPro = document.ajaxform.txtList.value;
                }
                var txtName = "&txtName=" + document.ajaxform.txtName.value;
                var monthTo = "&monthTo=" + document.ajaxform.monthTo.value;
                var dayTo = "&dayTo=" + document.ajaxform.dayTo.value;
                var yearTo = "&yearTo=" + document.ajaxform.yearTo.value;
                var monthFrom = "&monthFrom=" + document.ajaxform.monthFrom.value;
                var dayFrom = "&dayFrom=" + document.ajaxform.dayFrom.value;
                var yearFrom = "&yearFrom=" + document.ajaxform.yearFrom.value;
                var cateID = "&cateID=" + document.ajaxform.cateID.value;
                var roomID = "&roomID=" + document.ajaxform.roomID.value;
                var typeaccess = "&typeaccess=" + document.ajaxform.typeaccess.value;
                var status = "&status=" + document.ajaxform.status.value;
                var txtDes = "&txtDes=" + document.ajaxform.txtDes.value;
                var strLink = txtName + monthTo + dayTo + yearTo + monthFrom + dayFrom + yearFrom + cateID + roomID + typeaccess + status + txtDes;
                if (document.ajaxform.txtResultAccess.value != "") {
                    var url = window.location.search.substring(22).split('&');
                    window.location.href = "?options=CreateDevice&typeid=" + sel + strLink + "&listcheck=" + listPro;

                } else {
                    window.location.href = "?options=CreateDevice&typeid=" + sel + strLink + "&listcheck=" + listPro;
                }


            }
        </script>

        <script>
            function BASIC_SelectItem()
            {
                var c_value = "";
                for (var i = 0; i < document.ajaxform.chk.length; i++)

                {
                    if (document.ajaxform.chk[i].checked)
                    {
                        c_value += (c_value ? '/' : '') + document.ajaxform.chk[i].value;
                    }
                }
                document.ajaxform.txtResultAccess.value = c_value;
            }



        </script>


        <script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                //called when key is pressed in textbox
                $("#txtuser").keypress(function(e)
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
            function lookup(txtName) {
                if (txtName.length < 3) {
                    $('#autoSuggestionsList').hide();
                } else {
                    $.post("../checkNameCreate", {txtName: "" + txtName + ""}, function(data) {
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
                jQuery("#ajaxform").validationEngine();
            });</script>
            <%--check username--%>

    </head>
    <body>
        <form id='ajaxform' name='ajaxform' action='../createdevice' method='post'>
            <table width="500px" border="0" align="center" cellpadding="7px" cellspacing="0">

                <tr>
                    <td colspan="2">
                        <table>
                            <tr>
                                <td>
                                    <div class="site-input-div">
                                        <div class="site-input-left"><img src="../img/category.png"/></div>
                                        <div class="site-input-rigth">
                                            <input placeholder="Please enter device name..." id="txtName" onkeyup="lookup(this.value);" style="  width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                                   -webkit-border-radius: 5px;" value="<%=request.getParameter("txtName") == null ? "" : request.getParameter("txtName")%>" name="txtName" type="text" class="validate[required,minSize[3]] text-input"  />
                                        </div>   
                                    </div>
                                </td>
                                <td><div style="width: 20px;">
                                        <div style="display: none;" id="autoSuggestionsList"></div>
                                        <div style="display: none;" id="error"></div>

                                    </div></td>
                            </tr>
                        </table>


                    </td>
                </tr>




                <tr>
                    <td>Warranty To:</td>
                    <td>
                        <select name="monthTo" style="width: 70px;height: 30px">
                            <%
                                Calendar calen = Calendar.getInstance();
                                for (int i = 1; i <= 12; i++) {
                                    if (request.getParameter("monthTo") != null) {
                                        int monTo = Integer.parseInt(request.getParameter("monthTo").toString().trim());
                                        if (i == monTo) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            } else {
                                if (i == calen.get(Calendar.MONTH) + 1) {

                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                        <select name="dayTo" style="width: 70px;height: 30px">
                            <%
                                for (int i = 1; i <= 31; i++) {
                                    if (request.getParameter("dayTo") != null) {
                                        int dTo = Integer.parseInt(request.getParameter("dayTo").toString().trim());
                                        if (i == dTo) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            } else {
                                if (i == calen.get(Calendar.DATE)) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                        <select name="yearTo" style="width: 100px;height: 30px">
                            <%
                                int year = calen.get(Calendar.YEAR) + 100;
                                for (int i = year; i >= calen.get(Calendar.YEAR); i--) {
                                    if (request.getParameter("yearTo") != null) {
                                        int yTo = Integer.parseInt(request.getParameter("yearTo").toString().trim());
                                        if (i == yTo) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            } else {
                                if (i == calen.get(Calendar.YEAR)) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td>Warranty From:</td>
                    <td>
                        <select name="monthFrom" style="width: 70px;height: 30px">
                            <%
                                for (int i = 1; i <= 12; i++) {
                                    if (request.getParameter("monthFrom") != null) {
                                        int mFrom = Integer.parseInt(request.getParameter("monthFrom").toString().trim());
                                        if (i == mFrom) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            } else {
                                if (i == calen.get(Calendar.MONTH) + 1) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                        <select name="dayFrom" style="width: 70px;height: 30px">
                            <%
                                for (int i = 1; i <= 31; i++) {
                                    if (request.getParameter("dayFrom") != null) {
                                        int dFrom = Integer.parseInt(request.getParameter("dayFrom").toString().trim());
                                        if (i == dFrom) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            } else {
                                if (i == calen.get(Calendar.DATE)) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                        <select name="yearFrom" style="width: 100px;height: 30px">
                            <%
                                for (int i = year; i >= calen.get(Calendar.YEAR); i--) {
                                    if (request.getParameter("yearFrom") != null) {
                                        int yFrom = Integer.parseInt(request.getParameter("yearFrom").toString().trim());
                                        if (i == yFrom) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            } else {
                                if (i == calen.get(Calendar.YEAR) + 3) {
                            %>
                            <option selected="selected" value="<%=i%>"><%=i%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td>Category:</td>
                    <td >
                        <select name="cateID" style="width: 150px;height: 30px">
                            <%
                                Connection cnn = null;
                                Statement st = null;
                                ResultSet rs = null;
                                String sql = "select * from tbl_category where status=1";
                                cnn = dbconnect.Connect();
                                try {
                                    st = cnn.createStatement();
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {
                                        int cate = rs.getInt("cateID");
                                        String cateN = rs.getString("cateName");
                                        if (request.getParameter("cateID") != null) {
                                            int cateSel = Integer.parseInt(request.getParameter("cateID").toString().trim());
                                            if (cate == cateSel) {
                            %>

                            <option selected="selected" value="<%=cate%>"><%=cateN%></option>

                            <%
                            } else {

                            %>

                            <option value="<%=cate%>"><%=cateN%></option>

                            <%
                                }
                            } else {
                            %>

                            <option value="<%=cate%>"><%=cateN%></option>

                            <%
                                        }
                                    }
                                } catch (Exception ex) {
                                    out.print(ex.getMessage());
                                } finally {
                                    try {
                                        rs.close();
                                        st.close();
                                        cnn.close();
                                    } catch (Exception ex) {
                                        out.print(ex.getMessage());
                                    }
                                }
                            %>
                        </select>
                <tr>
                <tr>
                    <td>Room:</td>
                    <td>
                        <select name="roomID" style="width: 150px;height: 30px">
                            <%
                                Connection cnn1 = null;
                                Statement st1 = null;
                                ResultSet rs1 = null;
                                String sql1 = "select * from tbl_labroom where status=1";
                                cnn1 = dbconnect.Connect();
                                try {
                                    st1 = cnn1.createStatement();
                                    rs1 = st1.executeQuery(sql1);
                                    while (rs1.next()) {
                                        int rID = rs1.getInt("roomID");
                                        String rName = rs1.getString("roomName");
                                         if (request.getParameter("roomID") != null) {
                                        int roomSel = Integer.parseInt(request.getParameter("roomID").toString().trim());
                                        if (roomSel == rID) {
                            %>

                            <option selected="selected" value="<%=rID%>"><%=rName%></option>

                            <%
                            } else {
                            %>

                            <option value="<%=rID%>"><%=rName%></option>

                            <%
                                        }
                                    }else{
                                             %>

                            <option value="<%=rID%>"><%=rName%></option>

                            <%
                                         }
                                    }
                                } catch (Exception ex) {
                                    out.print(ex.getMessage());
                                } finally {
                                    try {
                                        rs1.close();
                                        st1.close();
                                        cnn1.close();
                                    } catch (Exception ex) {
                                        out.print(ex.getMessage());
                                    }
                                }
                            %>
                        </select>
                    </td>
                </tr>  
                <tr>
                    <td>Type Accessory:</td>
                    <td>
                        <select name="typeaccess" id="typeaccess" onchange="DeviceInfo()" style="width: 150px;height: 30px">
                            <option value="0">Select Type Accessory</option>
                            <%
                                Connection cnn2 = null;
                                Statement st2 = null;
                                ResultSet rs2 = null;
                                String sql2 = "select * from tbl_type_accessory where status=1";
                                cnn2 = dbconnect.Connect();
                                try {
                                    st2 = cnn2.createStatement();
                                    rs2 = st2.executeQuery(sql2);
                                    while (rs2.next()) {

                                        int type = rs2.getInt("typeID");
                                        String typeName = rs2.getString("type_accessory");
                                        checkExits check = new checkExits();
                                        if (check.checkExit("tbl_accessory", "typeID", type) > 0) {
                                            if (request.getParameter("typeid") != null) {
                                                if (type == Integer.parseInt(request.getParameter("typeid").toString().trim())) {
                            %>

                            <option selected="selected" value="<%=type%>"><%=typeName%></option>

                            <%
                            } else {


                            %>

                            <option value="<%=type%>"><%=typeName%></option>

                            <%
                                }
                            } else {
                            %>

                            <option value="<%=type%>"><%=typeName%></option>

                            <%
                                            }
                                        }
                                    }
                                } catch (Exception ex) {
                                    out.print(ex.getMessage());
                                } finally {
                                    try {
                                        rs1.close();
                                        st1.close();
                                        cnn1.close();
                                    } catch (Exception ex) {
                                        out.print(ex.getMessage());
                                    }
                                }
                            %>
                        </select>
                    </td>
                </tr>  
                <tr>
                    <td colspan="2">
                        <%
                            Connection cnn3 = null;
                            Statement st3 = null;
                            ResultSet rs3 = null;
                            String sql3 = "select * from tbl_accessory where status=1";
                            int typeID = 0;
                            if (request.getParameter("typeid") != null) {
                                try {
                                    typeID = Integer.parseInt(request.getParameter("typeid").toString().trim());
                                } catch (Exception ex) {
                                    typeID = 0;
                                }
                                if (typeID > 0) {
                                    sql3 += " and typeID=" + typeID;

                                    cnn3 = dbconnect.Connect();
                                    try {
                                        st3 = cnn3.createStatement();
                                        rs3 = st3.executeQuery(sql3);
                                        while (rs3.next()) {
                        %>
                        <input name="chk" onclick="BASIC_SelectItem();" type="checkbox" value="<%=rs3.getInt("accessID")%>"/> &nbsp;<%=rs3.getString("accessName")%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%
                                        }
                                    } catch (Exception ex) {

                                    } finally {
                                        try {
                                            rs3.close();
                                            st3.close();
                                            cnn3.close();
                                        } catch (Exception ex) {

                                        }
                                    }
                                }

                            }
                        %>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <select name="status">
                            <option value="1">Show</option>
                            <option value="0">Hide</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea rows="5" placeholder="Please enter description..." style="width: 500px; border:1px solid #d1d1d1;-moz-border-radius: 5px;
                                  -webkit-border-radius: 5px;" name="txtDes"></textarea>

                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="     Create       " onclick="BASIC_SelectItem();" class="button_example"  />&nbsp;&nbsp;&nbsp;&nbsp;<input class="button_example" value="     Reset       "   type="reset"/></td>
                </tr>
                <tr>
                    <td align="center" colspan="2"><div id='content' class="style-result"></div></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="text" placeholder="gan" style="visibility: hidden;" value="" id="txtResultAccess" name="txtResultAccess" />
                        <input type="text"  placeholder="tam" style="visibility: hidden;" value="<%=request.getParameter("listcheck") == null ? "" : request.getParameter("listcheck")%>" id="txtList" name="txtList" />
                    </td>
                </tr>

            </table>
        </form>



        <script type="text/javascript">

            var form = $('#ajaxform');
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
    </body>
</html>