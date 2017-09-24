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
public class deleteRequest extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet deleteRequest</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet deleteRequest at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        PrintWriter out = response.getWriter();
        int reqID=0;
        if(request.getParameter("ID")!=null){
            reqID=Integer.parseInt(request.getParameter("ID").toString().trim());
        }
        if(reqID>0){
            Connection cnn=null;
            Statement st=null;
            String sql="delete from tbl_request where requestID="+reqID;
            cnn=dbconnect.Connect();
            try {
                st=cnn.createStatement();
                int row=st.executeUpdate(sql);
                if(row>0){
                     out.println("<div class=\"style-result\">Delete successfull!</div>");
                }else{
                     out.println("<div class=\"style-result\">Delete fail!</div>");
                }
            } catch (SQLException ex) {
                Logger.getLogger(deleteRequest.class.getName()).log(Level.SEVERE, null, ex);
                out.println("<div class=\"style-result\">Delete fail!</div>");
            }finally{
                try {
                    st.close();
                    cnn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(deleteRequest.class.getName()).log(Level.SEVERE, null, ex);
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
