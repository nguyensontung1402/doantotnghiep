/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package computerlabs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class CheckUsername extends HttpServlet {

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
            String str = request.getParameter("user");
            int result=checkUsername(str,"tbl_user","username","");
            if (result == 1) {
                out.println("<img src=\"../img/not-available.png\" />");
            } else if(result==0){
                out.println("<img src=\"../img/available.png\" />");
            }else if(result==2){
                out.println("Loi: " + str);
            }
            else{
                out.println("EX: " + str);
            }
        }
    }
public int checkUsername(String user,String tablename,String fieldname,String where) {
        try {

           // String connectionURL = "jdbc:odbc:sem4";
            Connection con;
            //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
// Get a Connection to the database
           // con = DriverManager.getConnection(connectionURL, "lab", "");
            con=dbconnect.Connect();
//Add the data into the database
            String sql = "SELECT * FROM "+tablename+" WHERE "+fieldname+"='" + user + "' "+where;
            Statement stm = con.createStatement();
            stm.executeQuery(sql);
            ResultSet rs = stm.getResultSet();
            int count = 0;
            while (rs.next()) {
                count++;
            }
            if (count == 0) {
                    return 0;
            } else {
                    return 1;
            }
        } catch (Exception e) {
                    return 2;
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
