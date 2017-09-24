/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package processSchedule;

import computerlabs.CheckUsername;
import computerlabs.createuser;
import computerlabs.dbconnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class updateRequest extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

//        String id = request.getParameter("ID");
//         String statusRequest = request.getParameter(nameStatus);
//        out.println("Update"+id+" and status="+statusRequest);
        int reqID = 0;
        int statusRequest = 0;
        try {
            reqID = Integer.parseInt(request.getParameter("ID").toString().trim());
            String nameStatus = "status" + reqID;
            statusRequest = Integer.parseInt(request.getParameter(nameStatus));
        } catch (Exception ex1) {

        }

        if (checkDate(reqID) == 1) {

            Connection cnn = dbconnect.Connect();
            PreparedStatement pst = null;
            String sql = "update tbl_request set [status]=? where requestID=?";
            try {
                pst = cnn.prepareStatement(sql);
                pst.setInt(1, statusRequest);
                pst.setInt(2, reqID);
                int row = pst.executeUpdate();
                if (row > 0) {
                    if (statusRequest == 2) {
                        if (destroyRequest(reqID, statusRequest) > 0) {
                            out.println("<div class=\"style-result\">Update successfull!</div>");
                        } else {
                            out.println("<div class=\"style-result\">Update fail!</div>");
                        }
                    } else {
                        out.println("<div class=\"style-result\">Update successfull!</div>");
                    }
                } else {
                    out.println("<div class=\"style-result\">Update fail!</div>");
                }
            } catch (SQLException ex) {
                Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    pst.close();
                    cnn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } else {
            out.println("<div class=\"style-result\">Can not update because date work < date now!</div>");
        }
    }

    private int destroyRequest(int reqid, int statusUpdate) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        int cnt = 0;
        int scheID = selectIDSchedule(reqid);
        String sql = "select requestID from tbl_request where scheduleID=" + scheID + " and requestID!=" + reqid;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                int reqdes = rs.getInt("requestID");
                if (updateDes(reqdes) == 1) {
                    cnt = cnt + 1;
                }
            }
            if(!rs.next()){
                return 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return cnt;

    }

    private int checkDate(int reqid) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        SimpleDateFormat formart = new SimpleDateFormat("dd/MM/yyyy");
        int scheID = selectIDSchedule(reqid);
        String sql = "select d.dateword as dateword,s.scheduleID from tbl_schedule as s "
                + " inner join tbl_datework d on s.dateworkID=d.datewordID where s.scheduleID=" + scheID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                String[] date = formart.format(rs.getDate("dateword")).split("/");
                int daySQL = Integer.parseInt(date[0]);
                int monthSQL = Integer.parseInt(date[1]);
                int yearSQL = Integer.parseInt(date[2]);
                String[] datenow = formart.format(new Date()).split("/");
                int dayNow = Integer.parseInt(datenow[0]);
                int monthNow = Integer.parseInt(datenow[1]);
                int yearNow = Integer.parseInt(datenow[2]);
                if (yearSQL > yearNow) {
                    return 1;
                } else if (yearSQL == yearNow) {
                    if (monthSQL > monthNow) {
                        return 1;
                    } else if (monthSQL == monthNow) {
                        if (daySQL >= dayNow) {
                            return 1;
                        } else {
                            return 0;
                        }
                    } else {
                        return 0;
                    }
                } else {
                    return 0;
                }
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);

            }
        }

    }

    private int updateDes(int reqID) {
        Connection cnn = dbconnect.Connect();
        PreparedStatement pst = null;
        String sql = "update tbl_request set [status]=? where requestID=?";
        try {
            pst = cnn.prepareStatement(sql);
            pst.setInt(1, 1);
            pst.setInt(2, reqID);
            int row = pst.executeUpdate();
            if (row > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                pst.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private int selectIDSchedule(int reqid) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select TOP 1 scheduleID from tbl_request where requestID=" + reqid;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("scheduleID");
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(updateRequest.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
