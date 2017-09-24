
<%@page import="computerlabs.dbconnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<form action="../administration/?options=searchSchedule" name="test" id="test" method="get">
    <table cellpadding="1px" cellspacing="1px" id="fcuk" width="950px" align="center"> 
        <tr >
            <td></td>
        <td>
        <%
            Connection cnn = null;
            Statement st = null;
            ResultSet rs = null;
            int dateID = 0;
            int roomID = 0;
            if (request.getParameter("dateID") != null) {
                try {
                    dateID = Integer.parseInt(request.getParameter("dateID"));
                } catch (Exception ex) {

                }
            }
            if (request.getParameter("roomID") != null) {
                try {
                    roomID = Integer.parseInt(request.getParameter("roomID"));
                } catch (Exception ex) {

                }
            }
            String sql = "select s.scheduleID as scheduleID,shift.shiftname as shiftname,shift.starttime as starttime,shift.endtime as endtime ,s.status "
                    + " as scheStatus from tbl_schedule as s inner join tbl_shiftname "
                    + " as shift on s.shiftID=shift.shiftID where dateworkID=" + dateID + " and roomID=" + roomID;
            if (roomID > 0 && dateID > 0) {
                cnn = dbconnect.Connect();
                try {
                    st = cnn.createStatement();
                    rs = st.executeQuery(sql);
                    while (rs.next()) {
                        int scheduleID = rs.getInt("scheduleID");
                        String shiftname = rs.getString("shiftname");
                        String starttime = rs.getTime("starttime").toString();
                        String endtime = rs.getTime("endtime").toString();
                        int scheStatus = rs.getInt("scheStatus");
                        if(scheStatus==0){
        %>
        <input type="checkbox" name="chk" value="<%=scheduleID %>" title="<%=starttime.substring(0, 5)%> - <%=endtime.substring(0, 5)%> " /> &nbsp;<%=shiftname%> &nbsp;&nbsp;&nbsp;
        <%
                        }else{
                            %>
                            <input type="checkbox" checked="checked" name="chk" value="<%=scheduleID %>" title="<%=starttime.substring(0, 5)%> - <%=endtime.substring(0, 5)%> " /> &nbsp;<%=shiftname%> &nbsp;&nbsp;&nbsp;
        <%
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
            }
        %>
        </td>
        </tr>
    </table>
</form>