/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package computerlabs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class updateShift extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        /* TODO output your page here. You may use following sample code. */
        int sID = 0;
        String sName = "";
        String startTime = "";
        String endTime = "";
        if (request.getParameter("sID") != null) {
            sID = Integer.parseInt(request.getParameter("sID").toString().trim());
        }
        if (request.getParameter("shiftName") != null) {
            sName = request.getParameter("shiftName");
        }
        if (request.getParameter("starttime") != null) {
            startTime = request.getParameter("starttime");
        }
        if (request.getParameter("endtime") != null) {
            endTime = request.getParameter("endtime");
        }
        CheckUsername check = new CheckUsername();
        int result = check.checkUsername(sName, "tbl_shiftname", "shiftname", " and shiftID!=" + sID);
        if (result == 1) {
            out.println("<div class=\"style-result\">Shift name is not valid!</div>");
        } else if (result == 0) {
            Connection cnn = null;
            PreparedStatement pst = null;
            String sql = "update tbl_shiftname set shiftname=?,starttime=?,endtime=? where shiftID=?";
            cnn = dbconnect.Connect();
            try {
                pst = cnn.prepareStatement(sql);
                pst.setString(1, sName);
                pst.setString(2, startTime);
                pst.setString(3, endTime);
                pst.setInt(4, sID);
                int row = pst.executeUpdate();
                if (row > 0) {
                    out.println("<div class=\"style-result\">Update Successfull!</div>");
                } else {
                    out.println("<div class=\"style-result\">Update fail!</div>");
                }
            } catch (SQLException ex) {
                Logger.getLogger(updateShift.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                try {
                    pst.close();
                    cnn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(updateShift.class.getName()).log(Level.SEVERE, null, ex);
                }
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
