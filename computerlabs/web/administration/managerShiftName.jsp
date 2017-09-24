
<%@page import="computerlabs.dbconnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        //called when key is pressed in textbox
        $("#shiftName").keypress(function(e)
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
            $.post("../checkShiftName", {name: "" + txtName + "", sID: "" + ID + ""}, function(data) {
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
    <%--check username--%>
<form action="../updateShift" name="test" id="test" method="post">
    <table cellpadding="1px" cellspacing="1px" id="fcuk" width="800px" align="center"> 
        <tr bgcolor="#78bbe3">
            <td style="width: 70px;color: white;" align="center">ID</td>
            <td style="width: 90px;color: white;" align="center">Shift Name</td>
            <td style="width: 120px;color: white;" align="center">Start Time</td>
            <td style="width: 120px;color: white;" align="center">End Time</td>
            <td style="width: 120px;color: white;" align="center">Status</td>
            <td style="width: 120px;color: white;" align="center">Action</td>
        </tr>

        <%
            Connection cnn = null;
            Statement st = null;
            ResultSet rs = null;
            String sql = "select * from tbl_shiftname where shiftID!=7";
            cnn = dbconnect.Connect();
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            int cnt = 0;
            while (rs.next()) {
                int ID = rs.getInt("shiftID");
                String startTime = rs.getTime("starttime").toString().substring(0, 5);
                String endTime = rs.getTime("endtime").toString().substring(0, 5);
                String sName = rs.getString("shiftname");
                int status = rs.getInt("status");
                cnt = cnt + 1;
                if (cnt % 2 == 0) {
        %>
        <tr>
            <td align="center" style="background: #e7f5fe;height:30px; "><%=ID%></td>
            <%
                if (request.getParameter("shiftID") == null) {
            %>
            <td align="center" style="background: #e7f5fe;height:30px; "><%=sName%></td>
            <td align="center" style="background: #e7f5fe;height:30px; "><%=startTime%></td>
            <td align="center" style="background: #e7f5fe;height:30px; "><%=endTime%></td>
            <%
            } else if (Integer.parseInt(request.getParameter("shiftID").toString().trim()) == ID) {
            %>
            <td align="center" style="background: #e7f5fe;height:30px; ">
                <input name="shiftName" id="shiftName" style="width: 50px;" onkeyup="lookup(this.value,<%=ID%>);" class="validate[required,minSize[1]] text-input" value="<%=sName%>" type="text"/>
                <div style="width: 50px;">
                    <div style="display: none;" id="autoSuggestionsList"></div>
                    <div style="display: none;" id="error"></div>

                </div>
            </td>
            <td align="center" style="background: #e7f5fe;height:30px; ">
                <input name="starttime" style="width: 80px;"  class="validate[required,custom[time]]" value="<%=startTime%>" type="text"/>
            </td>
            <td align="center" style="background: #e7f5fe;height:30px; ">
                <input name="endtime" style="width: 80px;"  class="validate[required,custom[time]]" value="<%=endTime%>" type="text"/>
            </td>
            <%
            } else {
            %>
            <td align="center" style="background: #e7f5fe;height:30px; "><%=sName%></td>
            <td align="center" style="background: #e7f5fe;height:30px; "><%=startTime%></td>
            <td align="center" style="background: #e7f5fe;height:30px; "><%=endTime%></td>
            <%
                }
            %>
            <td align="center" style="background: #e7f5fe;height:30px; ">
                <%
                    if (status == 1) {
                        out.println("Show");
                    } else {
                        out.println("Hide");
                    }
                %>
            </td>
            <%
                if (request.getParameter("shiftID") != null) {
                    if (Integer.parseInt(request.getParameter("shiftID").toString().trim()) == ID) {
            %>
            <td align="center" style="background: #e7f5fe;height:30px; ">
                <input type="submit" class="button_img" style="background: url('../img/edit2.png');width: 23px;height: 23px;" value="" />
                            &nbsp;&nbsp;&nbsp;&nbsp;<a href="?options=ManagerShift"><img src="../img/back.png" width="23px" height="20px" /></a>
            </td>
                <%
                } else {
                %>
            <td  align="center" style="background: #e7f5fe;height:30px; "><a title="" href="?options=ManagerShift&shiftID=<%=ID%>"><img src="../img/edit.png" width="23px" height="23px" /></a></td>
                    <%
                        }
                    } else {
                    %>
            <td  align="center" style="background: #e7f5fe;height:30px; "><a title="" href="?options=ManagerShift&shiftID=<%=ID%>"><img src="../img/edit.png" width="23px" height="23px" /></a></td>
        </tr>
        <%
            }
        %>
        <%
        } else {
        %>
        <tr>
            <td align="center" ><%=ID%></td>
            <%
                if (request.getParameter("shiftID") == null) {
            %>
            <td align="center" ><%=sName%></td>
            <td align="center" ><%=startTime%></td>
            <td align="center" ><%=endTime%></td>
            <%
            } else if (Integer.parseInt(request.getParameter("shiftID").toString().trim()) == ID) {
            %>
            <td align="center">
                <input name="shiftName" id="shiftName" style="width: 50px;"  onkeyup="lookup(this.value,<%=ID%>);" class="validate[required,minSize[1]] text-input" value="<%=sName%>" type="text"/>
                <div style="width: 50px;">
                    <div style="display: none;" id="autoSuggestionsList"></div>
                    <div style="display: none;" id="error"></div>

                </div>
            </td>
            <td align="center" >
                <input name="starttime" style="width: 80px;"  class="validate[required,custom[time]]" value="<%=startTime%>" type="text"/>
            </td>
            <td align="center">
                <input name="endtime" style="width: 80px;"  class="validate[required,custom[time]]" value="<%=endTime%>" type="text"/>
            </td>
            <%
            } else {
            %>
            <td align="center" ><%=sName%></td>
            <td align="center" ><%=startTime%></td>
            <td align="center" ><%=endTime%></td>
            <%
                }
            %>
            <td align="center">
                <%
                    if (status == 1) {
                        out.println("Show");
                    } else {
                        out.println("Hide");
                    }
                %>
            </td>
            <%
                if (request.getParameter("shiftID") != null) {
                    if (Integer.parseInt(request.getParameter("shiftID").toString().trim()) == ID) {
            %>
            <td align="center">
                <input type="submit" class="button_img" style="background: url('../img/edit2.png');width: 23px;height: 23px;" value=""/>
                &nbsp;&nbsp;&nbsp;&nbsp;<a href="?options=ManagerShift"><img src="../img/back.png" width="23px" height="20px" /></a>
            </td>
                <%
                } else {
                %>
            <td align="center"><a title="" href="?options=ManagerShift&shiftID=<%=ID%>"><img src="../img/edit.png" width="23px" height="23px" /></a></td>
                    <%
                        }
                    } else {
                    %>
            <td align="center"><a title="" href="?options=ManagerShift&shiftID=<%=ID%>"><img src="../img/edit.png" width="23px" height="23px" /></a></td>
        </tr>
        <%
                    }
                }
            }
        %>
            <tr>
                <td><input type="text" name="sID" style="visibility: hidden;" value="<%=request.getParameter("shiftID")==null?"":request.getParameter("shiftID") %>"  /></td>
                <td align="center" colspan="6"><div id="content"></div></td>
        </tr>
    </table>
</form>
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
                $('#content').show().html(result).fadeOut(3000,function (){window.location.href="?options=ManagerShift";});

            }
        });

        return false;
    }); </script>