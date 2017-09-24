<%@page import="computerlabs.dbconnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<table cellpadding="1px" cellspacing="1px" border="0" id="fcuk" width="950px" align="center">  
    <tr bgcolor="#78bbe3">
        <td style="color: white;width: 150px;">Device Name</td>
        <td style="color: white;">Complaint content</td>
    </tr>
    <%
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        int cID = 0;
        int i = 0;
        if (request.getParameter("cID") != null) {
            try {
                cID = Integer.parseInt(request.getParameter("cID").toString().trim());
            } catch (Exception ex) {
                cID = 0;
            }
            if (cID > 0) {
                
                String sql = "select d.dName as dName,cd.complaint_details as contents from tbl_complaint_device as cd inner join tbl_device as d on cd.dID=d.dID where complaintID=" + cID;
                cnn = dbconnect.Connect();
                st = cnn.createStatement();
                rs = st.executeQuery(sql);
                while (rs.next()) {

                    String dName = rs.getString("dName");
                    String contents = rs.getString("contents");
                    if (i % 2 == 0) {
                    %>
                    <tr>
                        <td style="height:30px;"><%=dName%></td>
                        <td style="height:30px;"><%=contents%></td>
                    </tr>
                    <%
                    } else {
                    %>
                    <tr>
                        <td style="background: #e7f5fe;height:30px;"><%=dName%></td>
                        <td style="background: #e7f5fe;height:30px;"><%=contents%></td>
                    </tr>
                    <%
                    }
                    i=i+1;
                }
            }
        }
    %>
    <tr>
        <td colspan="2" class="button_example"><a href="?option=listComplaint">Back</a></td>
    </tr>
</table>