/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ScheduleClient;

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
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
public class sendRequest extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int userID = 0;
            int classID = 0;
            int scheID = 0;
            String courseName = "";
            HttpSession session = request.getSession();
            if (session.getAttribute("userID") != null) {
                userID = Integer.parseInt(session.getAttribute("userID").toString().trim());
            }
            classID = Integer.parseInt(request.getParameter("classes").toString().trim());
            if (session.getAttribute("scheID") != null) {
                scheID = Integer.parseInt(session.getAttribute("scheID").toString().trim());
                session.removeAttribute("scheID");
            }
            courseName = request.getParameter("courseName");
            SimpleDateFormat formater = new SimpleDateFormat("yyyy/MM/dd");
            Date date = new Date();
            if (checkNumberRequestSendOfUser(userID, scheID) == 1) {
                out.println("Can not sent request. Because you have sent a request earlier.!");
            } else {
                if(userID>0 && classID >0 && scheID >0){
                Connection cnn = null;
                PreparedStatement pst = null;
                String sql = "insert into tbl_request(userID,classID,scheduleID,courseName,sendDate,[status]) values(?,?,?,?,'" + formater.format(date) + "',0)";
                cnn = dbconnect.Connect();
                try {
                    pst = cnn.prepareStatement(sql);
                    pst.setInt(1, userID);
                    pst.setInt(2, classID);
                    pst.setInt(3, scheID);
                    pst.setString(4, courseName);
                    int row = pst.executeUpdate();
                    if (row > 0) {
                        out.println("Send Request Successfull. Please waiting reply to the administrator!");
                    } else {
                        out.println("Send Request Fail!");
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(sendRequest.class.getName()).log(Level.SEVERE, null, ex);
                } finally {
                    try {
                        pst.close();
                        cnn.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(sendRequest.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }else{
                     out.println("Send Request Fail!");
                }
            }
        }
    }

    private int checkNumberRequestSendOfUser(int userID, int scheID) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select * from tbl_request where userID=" + userID + " and scheduleID=" + scheID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(sendRequest.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(sendRequest.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
