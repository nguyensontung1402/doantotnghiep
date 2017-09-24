/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package complaint;

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
public class updateUserProcess extends HttpServlet {

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
            out.println("<title>Servlet updateUserProcess</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateUserProcess at " + request.getContextPath() + "</h1>");
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
         int userID=0;
         int complaintID=0;
         if(request.getParameter("userProcessUp")!=null){
             try{
             userID=Integer.parseInt(request.getParameter("userProcessUp").toString().trim());
             }catch(Exception ex){
                 userID=0;
             }
         }
         if(request.getParameter("ID")!=null){
             try{
             complaintID=Integer.parseInt(request.getParameter("ID").toString().trim());
             }catch(Exception ex){
                 complaintID=0;
             }
         }
         if(userID>0 && complaintID>0){
             Connection cnn=null;
             Statement st=null;
             String sql="update tbl_complaint set userProcess="+userID+" where complaintID="+complaintID;
             cnn=dbconnect.Connect();
             try {
                 st=cnn.createStatement();
                 int row=st.executeUpdate(sql);
                 if(row>0){
                                         out.println("<div class=\"style-result\">Update successfull!</div>");
                 }else{
                                         out.println("<div class=\"style-result\">Update fail!</div>");
                 }
             } catch (SQLException ex) {
                 Logger.getLogger(updateUserProcess.class.getName()).log(Level.SEVERE, null, ex);
                  out.println("<div class=\"style-result\">Update fail!</div>");
             }finally{
                 try {
                     st.close();
                     cnn.close();
                 } catch (SQLException ex) {
                     Logger.getLogger(updateUserProcess.class.getName()).log(Level.SEVERE, null, ex);
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
