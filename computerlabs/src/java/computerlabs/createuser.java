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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
@WebServlet(name = "createuser", urlPatterns = {"/createuser"})
public class createuser extends HttpServlet {

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
//private int checkUser(String str) {
//        try {
//
//            String connectionURL = "jdbc:odbc:sem4";
//            Connection con;
//            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//// Get a Connection to the database
//            con = DriverManager.getConnection(connectionURL, "lab", "");
////Add the data into the database
//            String sql = "SELECT username FROM tbl_user WHERE username='" + str + "'";
//            Statement stm = con.createStatement();
//            stm.executeQuery(sql);
//            ResultSet rs = stm.getResultSet();
//            int count = 0;
//            while (rs.next()) {
//                count++;
//            }
//            if (count == 0) {
//                    return 0;
//            } else {
//                    return 1;
//            }
//        } catch (Exception e) {
//                    return 2;
//        }
//    }
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
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String usename = request.getParameter("txtuser");
        String txtpwd = request.getParameter("txtpwd");
        String txtfullname = request.getParameter("txtfullname");
        String txtEmail = request.getParameter("txtEmail");
        String txtAddress = request.getParameter("txtAddress");
        String rdoGender = request.getParameter("rdoGender");
        //ngay thang
        String month = request.getParameter("month");
        String day = request.getParameter("day");
        String year = request.getParameter("year");
        String birthday = year + "-" + month + "-" + day;
        //
        String department = request.getParameter("department");
        //HOD
        String hod = request.getParameter("rsCheckbox");
        int statusHOD = 0;
        if (hod.equalsIgnoreCase("checked")) {
            statusHOD = 1;
        }
        //
        boolean check = true;
        if (usename.equalsIgnoreCase("") || txtEmail.equalsIgnoreCase("") || txtpwd.equalsIgnoreCase("") || txtfullname.equalsIgnoreCase("") || txtAddress.equalsIgnoreCase("")) {
            check = false;
        }
        else if(usename.length()<6 || txtpwd.length()<6 || !txtEmail.matches("([^.@]+)(\\.[^.@]+)*@([^.@]+\\.)+([^.@]+)")){
            check=false;
        }
        CheckUsername checkuser=new CheckUsername();
        int resultCheck=checkuser.checkUsername(usename, "tbl_user", "username","");
        if (resultCheck == 1) {
                check=false;
            } else if(resultCheck==0){        
            }else if(resultCheck==2){
                 check=false;
            }
            else{
                out.println("EX: " + usename);
                 check=false;
            }
        //out.println("User: "+usename+"<br/>Password: "+txtpwd+"<br/>Full name: "+txtfullname+"<br/>Address: "+txtAddress+"<br/>Gender: "+rdoGender+"<br/>Date: "+date+"<br/>Department: "+department+"<br/>HOD: "+statusHOD);
        if (check == true) {
            Connection cnn = dbconnect.Connect();
            PreparedStatement pst = null;
            String sql = "insert into tbl_user(username,password,fullname,address,gender,"
                    + "birthday,status,departmentID,HOD,Email) values(?,?,?,?,?,?,?,?,?,?) ";
            try {
                pst = cnn.prepareStatement(sql);
                pst.setString(1, usename);
                pst.setString(2, txtpwd);
                pst.setString(3, txtfullname);
                pst.setString(4, txtAddress);
                pst.setInt(5, Integer.parseInt(rdoGender));
                pst.setString(6, birthday);
                pst.setInt(7, 1);
                pst.setInt(8, Integer.parseInt(department));
                pst.setInt(9, statusHOD);
                 pst.setString(10, txtEmail);
                int row = pst.executeUpdate();
                if (row > 0) {
                    out.println("Create successfull!");
                } else {
                    out.println("Create fail!");
                }
            } catch (SQLException ex) {
                Logger.getLogger(createuser.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    pst.close();
                    cnn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(createuser.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }else{
            out.println("Create fail!");
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
