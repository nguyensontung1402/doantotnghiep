<%-- 
    Document   : sendComplaint
    Created on : May 12, 2014, 3:32:07 PM
    Author     : User
--%>

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
        <link rel="stylesheet" href="css/cssvalidate/validationEngine.jquery.css" type="text/css"/> 
        <link rel="stylesheet" href="css/cssvalidate/template.css" type="text/css"/> 
        <script src="js/jsvalidate/jquery-1.8.2.min.js" type="text/javascript"></script> 
        <script src="js/jsvalidate/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8"></script> 
        <script src="js/jsvalidate/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script> 
        <script>jQuery(document).ready(function() {
                // binds form submission and fields to the validation engine 
                jQuery("#test").validationEngine();
            });</script>
    </head>
    <body>
        <form action="sendComplaint" name="test" id="test" method="post">
            <table cellpadding="10px" border="0" cellspacing="10px" id="fcuk" width="600px" align="center">  
                <tr>
                    <td style="width: 150px">Title:</td>
                    <td><input type="text" placeholder="Please enter title complaint..." class="validate[required] text-input" name="title" id="title" style="  width:395px; height:26px; border:1px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" /></td>
                </tr>
                <%
                    if (request.getParameter("listDevice") != null) {
                        String[] listDevice = request.getParameter("listDevice").split("/");
                        for (int i = 0; i < listDevice.length; i++) {
                            int dIDselect = Integer.parseInt(listDevice[i].toString().trim());
                            Connection cnn = null;
                            Statement st = null;
                            ResultSet rs = null;
                            String sql = "select dID,dName from tbl_device where  dID=" + dIDselect;
                            cnn = dbconnect.Connect();
                            try {
                                st = cnn.createStatement();
                                rs = st.executeQuery(sql);
                                if (rs.next()) {
                                    int dID = rs.getInt("dID");
                                    String dName = rs.getString("dName");
                %>

                <tr>
                    <td ><%=dName%>:</td>
                    <td><textarea placeholder="Please enter complaint of <%=dName %>" rows="2" class="validate[required] text-input" name="row<%=dID%>" style="  width:395px; border:1px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" ></textarea></td>
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
                        }
                    }
                %>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" class="button_example" value="Send Complaint" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <div id='content' ></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="text" id="listDe" name="listDe" style="visibility: hidden;" value="<%=request.getParameter("listDevice") == null ? "" : request.getParameter("listDevice")%>" />
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
