<%-- 
    Document   : createuser.jsp
    Created on : Apr 17, 2014, 9:50:50 PM
    Author     : User
--%>

<%@page import="computerlabs.checkAdminHOD"%>
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
                var isOK = false;
                if (document.ajaxform.chk.checked)
                {
                    isOK = true;
                }
                if (isOK == true) {
                    document.ajaxform.rsCheckbox.value = 'checked';
                }
                else {
                    document.ajaxform.rsCheckbox.value = 'nochecked';
                }
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
            function lookup(txtuser) {
                if (txtuser.length < 6) {
                    $('#autoSuggestionsList').hide();
                } else {
                    $.post("../CheckUsername", {user: "" + txtuser + ""}, function(data) {
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
        <form id='ajaxform' name='ajaxform' action='../createuser' method='post'>
            <table width="500px" border="0" align="center" cellpadding="7px" cellspacing="0">
                <tr>
                    <td align="center"><div id='content' class="style-result"></div></td>
                </tr>
                <tr>
                    <td>
                        <div class="site-input-div">
                            <div class="site-input-left"><img src="../img/user.png"/></div>
                            <div class="site-input-rigth">
                                <input placeholder="Please enter user name..." id="txtuser" onkeyup="lookup(this.value);" style="  width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" name="txtuser" type="text" class="validate[required,minSize[6]] text-input"  />
                            </div>   
                        </div>
                    </td>
                    <td align="left">
                        <div style="width: 50px;">
                            <div style="display: none;" id="autoSuggestionsList"></div>
                            <div style="display: none;" id="error"></div>

                        </div></td>
                </tr>
                <tr>

                    <td colspan="2">
                        <div class="site-input-div">
                            <div class="site-input-left"><img src="../img/key.png"/></div>
                            <div class="site-input-rigth">
                                <input placeholder="Please enter password..." id="txtpwd" name="txtpwd"  style="  width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" type="password" class="validate[required,minSize[6]] text-input"  />
                            </div>
                        </div>
                    </td>

                </tr>
                <tr>

                    <td colspan="2">
                        <div class="site-input-div">
                            <div class="site-input-left"><img src="../img/key.png"/></div>
                            <div class="site-input-rigth">
                                <input placeholder="Please enter confirm password..." id="txtpwd" name="comfirmpwd" style="  width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" type="password" class="validate[required,equals[txtpwd]]"  />
                            </div>
                        </div>
                    </td>

                </tr>
                <tr>

                    <td colspan="2">
                        <div class="site-input-div">
                            <div class="site-input-left"><img src="../img/user.png"/></div>
                            <div class="site-input-rigth">
                                <input placeholder="Please enter full name..." id="txtfullname" style="  width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" name="txtfullname" type="text" class="validate[required] text-input" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>

                    <td colspan="2">
                        <div class="site-input-div">
                            <div class="site-input-left"><img src="../img/mail.png"/></div>
                            <div class="site-input-rigth">
                                <input placeholder="Please enter email..." id="txtEmail" style="width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" name="txtEmail"  type="text" class="validate[required,custom[email] text-input" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="site-input-div">
                            <div class="site-input-left"><img src="../img/google_maps.png"/></div>
                            <div class="site-input-rigth">
                                <input placeholder="Please enter address..." type="text" id="txtAddress" name="txtAddress" style="width:395px; height:26px; border:0px solid #d1d1d1;-moz-border-radius: 5px;
                                       -webkit-border-radius: 5px;" class="validate[required] text-input"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input id="rdoMale" name="rdoGender" type="radio"  checked="true" value="0" /> &nbsp;Male &nbsp;&nbsp;&nbsp;
                        <input id="rdoFEMale" name="rdoGender" type="radio" value="1" />&nbsp; Female
                    </td>
                </tr>
                <tr>

                    <td colspan="2">
                        <select name="month" style="width: 70px;height: 30px">
                            <%
                                for (int i = 1; i <= 12; i++) {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            %>
                        </select>
                        <select name="day" style="width: 70px;height: 30px">
                            <%
                                for (int i = 1; i <= 31; i++) {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            %>
                        </select>
                        <select name="year" style="width: 100px;height: 30px">
                            <%
                                Calendar calen = Calendar.getInstance();
                                int year = calen.get(Calendar.YEAR) - 7;
                                for (int i = year; i >= 1900; i--) {
                            %>
                            <option value="<%=i%>"><%=i%></option>
                            <%
                                }
                            %>
                        </select>

                    </td>
                </tr>
                <tr>

                    <td colspan="2">
                        <select name="department" style="width: 150px;height: 30px">
                            <%
                                Connection cnn = null;
                                Statement st = null;
                                ResultSet rs = null;
                                String sql = "select * from tbl_department where departmentID!=1";
                                checkAdminHOD checkHOD = new checkAdminHOD();
                                if (session.getAttribute("useradmin") != null) {
                                    if (checkHOD.checkHOD(session.getAttribute("useradmin").toString().trim()) == 1) {
                                        sql = "select * from tbl_department ";
                                    }
                                }
                                cnn = dbconnect.Connect();
                                try {
                                    st = cnn.createStatement();
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {

                            %>

                            <option value="<%=rs.getInt("departmentID")%>"><%=rs.getString("departmentName")%></option>

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
                        &nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="chk" onclick="BASIC_SelectItem();" value="5" />&nbsp;Head of Department 
                        <input type="text" name="rsCheckbox" id="rsCheckbox" style="visibility: hidden" value=""/>
                    </td>
                </tr>
                <tr>

                    <td colspan="2"><input type="submit" value="     Create       " class="button_example"  />&nbsp;&nbsp;&nbsp;&nbsp;<input class="button_example" value="     Reset       "   type="reset"/></td>
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