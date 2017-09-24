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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "checklogin", urlPatterns = {"/checklogin"})
public class checklogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String user = request.getParameter("username");
            String pwd = request.getParameter("pwd");
            if (CheckContent(user, pwd, request, response) == true) {
                request.getRequestDispatcher("index.jsp?option=login").forward(request, response);
            } else {
                int id;
                String login_name;
                Connection cnn;
                PreparedStatement pst = null;
                ResultSet rs = null;
                cnn = dbconnect.Connect();
                String sql = "select * from tbl_user where username=? and password=? and status=1";
                try {
                    pst = cnn.prepareStatement(sql);
                    pst.setString(1, user);
                    pst.setString(2, pwd);
                    rs = pst.executeQuery();
                    if (rs.next()) {
                        int userID = rs.getInt("userID");
                        int department = rs.getInt("departmentID");
                        HttpSession session = request.getSession();
                        if (department == 1) {
                          
                            session.setAttribute("useradmin", user);
                            response.sendRedirect("/computerlabs/administration/");
                        } else if (department == 2) {
                            session.setAttribute("Instructors", user);
                            response.sendRedirect("/computerlabs/?option=timetable");
                        } else if (department == 3) {
                            session.setAttribute("TechnicalStaff", user);
                            response.sendRedirect("/computerlabs/?option=listComplaint");
                        } else if (department == 4) {
                            session.setAttribute("Students", user);
                            response.sendRedirect("/computerlabs/?option=timetable");
                        }
                        session.setAttribute("userID", userID);
                    } else {
                       // out.println("Username or password is not valid.");
                        request.setAttribute("loginfail", "Username or password is not valid.");
                        request.getRequestDispatcher("index.jsp?option=login").forward(request, response);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(checklogin.class.getName()).log(Level.SEVERE, null, ex);
                } finally {
                    try {
                        rs.close();
                        pst.close();
                        cnn.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(checklogin.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

            }
        }
    }

    private boolean CheckContent(String user, String pwd, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int check = 1;
        if (user.equalsIgnoreCase("")) {
            request.setAttribute("usernull", "Username is not blank.");
            return true;
        }
        if (pwd.equalsIgnoreCase("")) {
            request.setAttribute("pwdnull", "Password is not blank.");
            return true;
        }
        if (pwd.length() < 6) {
            request.setAttribute("pwdlength", "Password must be greater than 6 characters.");
            return true;
        }
        if (user.length() < 6) {
            request.setAttribute("userlength", "Username must be greater than 6 characters.");
            return true;
        }
        return false;
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
        processRequest(request, response);
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
