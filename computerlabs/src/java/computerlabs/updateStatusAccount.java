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
public class updateStatusAccount extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        int userID = 0;
        int statusUser = 0;
        int departID = 0;
        int HOD = 0;
        try {
            userID = Integer.parseInt(request.getParameter("ID").toString().trim());
            String nameStatus = "statusUser" + userID;
            statusUser = Integer.parseInt(request.getParameter(nameStatus));
            String nameDepart = "department" + userID;
            departID = Integer.parseInt(request.getParameter(nameDepart));
            String nameHOD = "HOD" + userID;
            HOD = Integer.parseInt(request.getParameter(nameHOD));
        } catch (Exception ex1) {

        }
        Connection cnn = dbconnect.Connect();
        PreparedStatement pst = null;
        String sql = "update tbl_user set [status]=?,departmentID=?,HOD=? where userID=?";
        try {
            pst = cnn.prepareStatement(sql);
            pst.setInt(1, statusUser);
            pst.setInt(2, departID);
            pst.setInt(3, HOD);
            pst.setInt(4, userID);
            int row = pst.executeUpdate();
            if (row > 0) {

                out.println("<div class=\"style-result\">Update Successfull!</div>");

            } else {
                out.println("<div class=\"style-result\">Update fail!</div>");
            }
        } catch (SQLException ex) {
            Logger.getLogger(updateStatusAccount.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                pst.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(updateStatusAccount.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
