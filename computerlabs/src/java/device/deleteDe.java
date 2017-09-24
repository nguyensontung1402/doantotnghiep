/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package device;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class deleteDe extends HttpServlet {

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
            String act = "";
            int id = 0;
            if (request.getParameter("ID") != null) {
                id = Integer.parseInt(request.getParameter("ID").toString().trim());
            }
            if (request.getParameter("act") != null) {
                act = request.getParameter("act").toString().trim();
            }
            if (act.equalsIgnoreCase("delete")) {
                try {
                    deleteDevice delete = new deleteDevice();
                    int rs = delete.delete(id);
                    if (rs == 1) {
                        //out.println("Delete successfull!");
                        request.setAttribute("suc", "<div class=\"style-result\">Delete successfull!</div>");
                    } else {
                        //out.println("Delete fail!");
                        request.setAttribute("fail", "<div class=\"style-result\">Delete fail!</div>");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
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
            String act = "";
            int id = 0;
            if (request.getParameter("ID") != null) {
                id = Integer.parseInt(request.getParameter("ID").toString().trim());
            }
            if (request.getParameter("act") != null) {
                act = request.getParameter("act").toString().trim();
            }
            if (act.equalsIgnoreCase("delete")) {
                try {
                    deleteDevice delete = new deleteDevice();
                    int rs = delete.delete(id);
                    if (rs == 1) {
                         out.println("<div class=\"style-result\">Delete successfull!</div>");
                    } else {
                         out.println("<div class=\"style-result\">Delete fail!</div>");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
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
