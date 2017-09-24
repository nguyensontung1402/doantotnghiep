/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package processSchedule;

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
public class updateSchedule extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        if (request.getParameter("txtResultShift") != null) {
            String[] scheID = request.getParameter("txtResultShift").trim().split("/");
            Connection cnn = null;
            Statement st = null;
            ResultSet rs = null;
            int cnt = 0;
            String date = outputDate(Integer.parseInt(scheID[0].trim()));
            int roomID = outputRoom(Integer.parseInt(scheID[0].trim()));
            if (checkDate(date) == 1) {
                String sql = "select s.scheduleID,d.dateword from tbl_schedule as s inner join tbl_datework as d on s.dateworkID=d.datewordID where d.dateword='" + date + "' and roomID=" + roomID;
                cnn = dbconnect.Connect();
                try {
                    st = cnn.createStatement();
                    rs = st.executeQuery(sql);
                    while (rs.next()) {
                        int sID = rs.getInt("scheduleID");
                        boolean check = true;
                        for (int k = 0; k < scheID.length; k++) {
                            if (sID == Integer.parseInt(scheID[k].toString())) {
                                check = false;
                                UpdateSchedule(1, sID);
                                cnt = cnt + 1;
                            }

                        }
                        if (check == true) {
                            UpdateSchedule(0, sID);
                            cnt = cnt + 1;
                        }
                    }
                    if (cnt > 0) {
                        out.println("Update successfull!");
                    } else {
                        out.println("Update fail!");
                    }
                } catch (Exception ex) {

                } finally {
                    try {
                        rs.close();
                        st.close();
                        cnn.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            } else {
                out.println("Can not update, because date is not valid!");
            }
        }
    }

    private void UpdateSchedule(int status, int scheID) {
        Connection cnn = null;
        PreparedStatement pst = null;

//            String connectionURL = "jdbc:odbc:sem4";
//            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//            cnn = DriverManager.getConnection(connectionURL, "lab", "");
        cnn = dbconnect.Connect();
        String sqlUpdate = "update tbl_schedule set status=? where scheduleID=? ";
        try {
            pst = cnn.prepareStatement(sqlUpdate);
            pst.setInt(1, status);
            pst.setInt(2, scheID);
            pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                pst.close();
                cnn.close();

            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class
                        .getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    private String outputDate(int scheID) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        SimpleDateFormat fomart = new SimpleDateFormat("yyyy/MM/dd");
        String sql = "select d.dateword as date from tbl_schedule as s inner join tbl_datework as d on s.dateworkID=d.datewordID where scheduleID=" + scheID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return fomart.format(rs.getDate("date"));
            } else {
                return "";
            }
        } catch (SQLException ex) {
            Logger.getLogger(updateSchedule.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(updateSchedule.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int checkDate(String outdate) {

        SimpleDateFormat formart = new SimpleDateFormat("yyyy/MM/dd");

        String[] date = outdate.split("/");
        int daySQL = Integer.parseInt(date[2]);
        int monthSQL = Integer.parseInt(date[1]);
        int yearSQL = Integer.parseInt(date[0]);
        String[] datenow = formart.format(new Date()).split("/");
        int dayNow = Integer.parseInt(datenow[2]);
        int monthNow = Integer.parseInt(datenow[1]);
        int yearNow = Integer.parseInt(datenow[0]);
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
    }

    private int outputRoom(int scheID) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select roomID from tbl_schedule where scheduleID=" + scheID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("roomID");
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(updateSchedule.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(updateSchedule.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
