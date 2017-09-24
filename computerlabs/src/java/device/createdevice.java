/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package device;

import computerlabs.CheckUsername;
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

/**
 *
 * @author User
 */
public class createdevice extends HttpServlet {

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
            out.println("<title>Servlet createdevice</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet createdevice at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String access="";
        
        if(!request.getParameter("txtResultAccess").equalsIgnoreCase("") && request.getParameter("txtList").equalsIgnoreCase("")){
            access=request.getParameter("txtResultAccess").toString().trim();
        }
        if(request.getParameter("txtResultAccess").equalsIgnoreCase("") && !request.getParameter("txtList").equalsIgnoreCase("")){
            access=request.getParameter("txtList").toString().trim();
        }
        if(!request.getParameter("txtResultAccess").equalsIgnoreCase("") && !request.getParameter("txtList").equalsIgnoreCase("")){
            access=request.getParameter("txtList").toString().trim()+"/"+request.getParameter("txtResultAccess").toString().trim();
        }
        
        String txtName = "";
        String dateTo = "";
        String dateFrom = "";
        int cateID = 0;
        int roomID = 0;
        String des = "";
        int status = 0;

        if(request.getParameter("txtResultAccess").equalsIgnoreCase("") && request.getParameter("txtList").equalsIgnoreCase("") || request.getParameter("txtName").equalsIgnoreCase("")){
             out.println("Create fail. Please enter data!");
        } else {
            txtName = request.getParameter("txtName");
            CheckUsername checkName = new CheckUsername();
            int resultCheck = checkName.checkUsername(txtName, "tbl_device", "dName", "");
            if (resultCheck == 0) {
                dateTo = request.getParameter("yearTo") + "/" + request.getParameter("monthTo") + "/" + request.getParameter("dayTo");
                dateFrom = request.getParameter("yearFrom") + "/" + request.getParameter("monthFrom") + "/" + request.getParameter("dayFrom");
                cateID = Integer.parseInt(request.getParameter("cateID").toString().trim());
                roomID = Integer.parseInt(request.getParameter("roomID").toString().trim());
                status = Integer.parseInt(request.getParameter("status").toString().trim());
                des = request.getParameter("txtDes").toString().trim();
                if (CreateDevice(txtName, dateTo, dateFrom, des, status, cateID, roomID, access) == 1) {
                    out.println("Create Successfull!");
                } else {
                    out.println("Create Fail!");
                }
            }else{
                 out.println("Device Name is not valid!");
            }
        }
    }

    private int CreateDevice(String dName, String dateTo, String dateFrom, String des, int status, int cateID, int roomID, String access) {
        Connection cnn = null;
        PreparedStatement pst = null;
        SimpleDateFormat fomater = new SimpleDateFormat("yyyy/MM/dd");
        String dateNow = fomater.format(new Date());
        String sql = "insert into tbl_device values(?,'" + dateTo.toString().trim() + "','" + dateFrom.toString().trim() + "',?,?,?,?,'" + dateNow.toString().trim() + "')";
        cnn = dbconnect.Connect();
        try {
            pst = cnn.prepareStatement(sql);
            pst.setString(1, dName);
            pst.setString(2, des);
            pst.setInt(3, status);
            pst.setInt(4, cateID);
            pst.setInt(5, roomID);
            int row = pst.executeUpdate();
            if (row > 0) {
                int dID = showIDNew();
                String[] ListAccess = access.split("/");
                int result = 0;
                for (int i = 0; i < ListAccess.length; i++) {
                    int accessID = Integer.parseInt(ListAccess[i].toString().trim());
                    if (CreateDeviceDetails(dID, accessID, dateTo, dateFrom) == 1) {
                        result = result + 1;
                    }
                }
                if (result >0) {
                    return 1;
                } else {
                    return 0;
                }
            } else {
                return 0;
            }

        } catch (SQLException ex) {
            Logger.getLogger(createdevice.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                pst.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(createdevice.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int showIDNew() {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select TOP 1 dID from tbl_device order by dID desc";
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("dID");
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(createdevice.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(createdevice.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int CreateDeviceDetails(int dID, int accessID, String dateTo, String dateFrom) {
        Connection cnn = null;
        PreparedStatement pst = null;
        SimpleDateFormat fomater = new SimpleDateFormat("yyyy/MM/dd");
        String dateNow = fomater.format(new Date());
        String sql = "insert into tbl_device_accessory values(?,?,'" + dateTo.toString().trim() + "','" + dateFrom.toString().trim() + "',1)";
        cnn = dbconnect.Connect();
        try {
            pst = cnn.prepareStatement(sql);
            pst.setInt(1, dID);
            pst.setInt(2, accessID);
            int row = pst.executeUpdate();
            if (row > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(createdevice.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                pst.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(createdevice.class.getName()).log(Level.SEVERE, null, ex);
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
