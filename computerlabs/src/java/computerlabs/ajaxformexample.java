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
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name = "ajaxformexample", urlPatterns = {"/ajaxformexample"})
public class ajaxformexample extends HttpServlet {

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
            out.println("<title>Servlet ajaxformexample</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ajaxformexample at " + request.getContextPath() + "</h1>");
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
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
   throws IOException {
  resp.setContentType("text/html");
  
  PrintWriter out=resp.getWriter();
  
  String classname= req.getParameter("classname");
        Connection cnn=dbconnect.Connect();
        PreparedStatement pst=null;
        String sql="insert into tbl_class(className,status) values(?,?) ";
        try {
            pst=cnn.prepareStatement(sql);
            pst.setString(1, classname);
            pst.setInt(2, 1);
            int row=pst.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(ajaxformexample.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally{
      try {
          pst.close();
          cnn.close();
      } catch (SQLException ex) {
          Logger.getLogger(ajaxformexample.class.getName()).log(Level.SEVERE, null, ex);
      }
        }
         out.println("<br/>Password = "+classname);
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
