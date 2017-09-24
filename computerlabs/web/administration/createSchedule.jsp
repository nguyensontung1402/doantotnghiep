<%-- 
    Document   : createuser.jsp
    Created on : Apr 17, 2014, 9:50:50 PM
    Author     : User
--%>

<%@page import="java.text.SimpleDateFormat"%>
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
        <script>
            function BASIC_SelectItem()
            {
                var c_value = "";
                var c_room = "";
                for (var i = 0; i < document.ajaxform.chkShift.length; i++)

                {
                    if (document.ajaxform.chkShift[i].checked)
                    {
                        c_value += (c_value ? '/' : '') + document.ajaxform.chkShift[i].value;
                    }
                }
                for (var j = 0; j < document.ajaxform.chkRoom.length; j++)

                {
                    if (document.ajaxform.chkRoom[j].checked)
                    {
                        c_room += (c_room ? '/' : '') + document.ajaxform.chkRoom[j].value;
                    }
                }
                document.ajaxform.txtResultShift.value = c_value;
                document.ajaxform.txtResultRoom.value = c_room;
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

        <form id='ajaxform' name='ajaxform' action='../createSchedule' method='post'>
            <table width="650px" border="0" align="center" cellpadding="0" cellspacing="0"> 
                <tr><td><br/></td></tr>
                <tr>
                    <td class="td-left">Lab Room:</td>
                    <td>

                        <%
                            Connection cnn = null;
                            Statement st = null;
                            ResultSet rs = null;
                            String sql = "select * from tbl_labroom where status=1";
                            cnn = dbconnect.Connect();
                            try {
                                st = cnn.createStatement();
                                rs = st.executeQuery(sql);
                                while (rs.next()) {
                        %>
                        <input name="chkRoom" type="checkbox" value="<%=rs.getInt("roomID")%>"/> &nbsp;<%=rs.getString("roomName")%> &nbsp;&nbsp;&nbsp;
                        <%
                                }
                            } catch (Exception ex) {
                                out.print(ex.getMessage());
                            } finally {
                                try {
                                    rs.close();
                                    st.close();
                                    cnn.close();

                                } catch (Exception ex) {

                                }
                            }
                        %>

                    </td>
                </tr>
                <tr>
                    <td class="td-left">Shift Name:</td>
                    <td>
                        <%
                            Connection cnn1 = null;
                            Statement st1 = null;
                            ResultSet rs1 = null;
                            String sql1 = "select * from tbl_shiftname where status=1";
                            cnn1 = dbconnect.Connect();
                            try {
                                st1 = cnn1.createStatement();
                                rs1 = st1.executeQuery(sql1);
                                while (rs1.next()) {
                                    int shiftID = rs1.getInt("shiftID");
                                    String starttime = rs1.getTime("starttime").toString();
                                    String endtime = rs1.getTime("endtime").toString();
                                    String shiftname = rs1.getString("shiftname");
                        %>
                        <input name="chkShift" type="checkbox" value="<%=shiftID%>" title="<%=starttime.substring(0, 5)%> - <%=endtime.substring(0, 5)%> " /> &nbsp;<%=shiftname%> &nbsp;&nbsp;&nbsp;
                        <%
                                }
                            } catch (Exception ex) {
                                out.print(ex.getMessage());
                            } finally {
                                try {
                                    rs1.close();
                                    st1.close();
                                    cnn1.close();

                                } catch (Exception ex) {

                                }
                            }
                        %>
                    </td>
                </tr>
                <tr>
                    <td class="td-left">Number Days:</td>
                    <td>
                        <input name="txtNumber" type="text" value="6" size="30" class="validate[required,custom[integerSchedule]] text-input" /> days
                    </td>
                </tr>
                <tr>
                    <td class="td-left"> </td>
                    <td><input type="submit" value="    Create    " class="button_example" onclick="BASIC_SelectItem();" />&nbsp;&nbsp;&nbsp;&nbsp;<input class="button_example" value="    Reset   " type="reset"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <div id='content' class="style-result"></div>
                    </td>
                </tr>
                <tr>
                    <td class="td-left"><input type="text" name="txtResultRoom" id="txtResultRoom" onclick="BASIC_SelectItem()" style="visibility: hidden;" size="5" /></td>
                    <td><input type="text" name="txtResultShift" size="5" id="txtResultShift" style="visibility: hidden;"  /></td>
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