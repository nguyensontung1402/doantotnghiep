<%-- 
    Document   : sendRequest
    Created on : May 13, 2014, 4:10:04 PM
    Author     : User
--%>

<%@page import="java.text.SimpleDateFormat"%>
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
        <script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
        <link rel="stylesheet" href="css/cssvalidate/validationEngine.jquery.css" type="text/css"/> 
        <link rel="stylesheet" href="css/cssvalidate/template.css" type="text/css"/> 
        <script src="js/jsvalidate/jquery-1.8.2.min.js" type="text/javascript"></script> 
        <script src="js/jsvalidate/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script> 
        <script src="js/jsvalidate/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script> 
        <script>jQuery(document).ready(function() {
                // binds form submission and fields to the validation engine 
                jQuery("#ajaxform").validationEngine();
            });</script>
    </head>
    <body>

        <%
            int userID = 0;
            int scheID = 0;
            if (session.getAttribute("userID") != null) {
                userID = Integer.parseInt(session.getAttribute("userID").toString().trim());
            }
            if (request.getParameter("sid") != null) {
                scheID = Integer.parseInt(request.getParameter("sid").toString().trim());
                session.setAttribute("scheID", scheID);
            }
        %>
        <form id='ajaxform' name='ajaxform' action='sendRequest' method='post'>
            <table width="600px" border="0" align="center" cellpadding="7px" cellspacing="15px">
                <tr>
                    <td align="center" colspan="2"><div id='content' class="style-result"></div></td>
                </tr>
                <%
                    Connection cnn1 = null;
                    Statement st1 = null;
                    ResultSet rs1 = null;
                    SimpleDateFormat formarter = new SimpleDateFormat("MM/dd/yyyy");
                    String sql1 = "select shift.shiftname as sName,shift.starttime "
                            + " as sTime,shift.endtime as eTime,lab.roomName as rName, "
                            + " d.dateword as dWork from tbl_schedule as sche inner join "
                            + " tbl_labroom as lab on sche.roomID=lab.roomID inner join tbl_datework "
                            + " as d on sche.dateworkID=d.datewordID inner join tbl_shiftname as shift "
                            + " on sche.shiftID=shift.shiftID where sche.scheduleID=" + scheID;
                    cnn1 = dbconnect.Connect();
                    try {
                        st1 = cnn1.createStatement();
                        rs1 = st1.executeQuery(sql1);
                        if (rs1.next()) {

                            String sName = rs1.getString("sName");
                            String starttime = rs1.getTime("sTime").toString();
                            String endtime = rs1.getTime("eTime").toString();
                            String roomName = rs1.getString("rName");
                            String dateword = formarter.format(rs1.getDate("dWork"));
                %>
                <tr>
                    <td align="left" colspan="6" ><span style="font-size: 13px;color: #AAA;font-style: italic;">Shift Name: <%=sName%> &nbsp; (<%=starttime.substring(0, 5) + "-" + endtime.substring(0, 5)%>)&nbsp;&nbsp; Room Name: <%=roomName%> &nbsp;&nbsp;&nbsp;Date Work: <%=dateword%></span></td>
                </tr>
                <%
                        }
                    } catch (Exception ex) {

                    } finally {
                        try {
                            rs1.close();
                            st1.close();
                            cnn1.close();
                        } catch (Exception ex) {

                        }
                    }
                %>
                <tr>
                    <td colspan="2">
                        <div class="site-input-div">
                            <div class="site-input-left"><img src="img/category.png"/></div>
                            <div class="site-input-rigth">
                                <input placeholder="Please enter Course Name ..." id="courseName"  style="  width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" name="courseName" type="text" class="validate[required,minSize[3]] text-input"  />
                            </div>   
                        </div>
                    </td>
                </tr>







                <tr>

                    <td colspan="2">
                        <select name="classes" style="width: 150px;height: 30px">
                            <%
                                Connection cnn = null;
                                Statement st = null;
                                ResultSet rs = null;
                                String sql = "select * from tbl_class where status=1";
                                cnn = dbconnect.Connect();
                                try {
                                    st = cnn.createStatement();
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {

                            %>

                            <option value="<%=rs.getInt("classID")%>"><%=rs.getString("className")%></option>

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
                                        out.print(ex.getMessage());
                                    }
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>

                    <td colspan="2"><input type="submit" value="     Send       " class="button_example"  />&nbsp;&nbsp;&nbsp;&nbsp;<input class="button_example" value="     Reset       "   type="reset"/></td>
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
                        $('#content').show().html(result).fadeOut(3000, function() {
                            window.location.href = "?option=viewRequest";
                        });
                    }
                });

                return false;
            }); </script>
    </body>
</html>
