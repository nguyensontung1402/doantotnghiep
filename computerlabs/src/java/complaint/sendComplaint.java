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
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
public class sendComplaint extends HttpServlet {

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
            out.println("<title>Servlet sendComplaint</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet sendComplaint at " + request.getContextPath() + "</h1>");
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
        int userID = 0;
        int cnt=0;
        String title="";
        HttpSession session = request.getSession();
        if (session.getAttribute("userID") != null) {
            userID = Integer.parseInt(session.getAttribute("userID").toString().trim());
        }
        title=request.getParameter("title");
        if(!title.equalsIgnoreCase("")){
        if (userID > 0) {
            if (request.getParameter("listDe") != null) {
                String[] listDevice = request.getParameter("listDe").toString().trim().split("/");
                int rsCreateComplaint=CreateComplaint(userID,title);
                if (rsCreateComplaint == 1) {
                    if (complaintNew() > 0) {
                        for (int i = 0; i < listDevice.length; i++) {
                            String param = "row" + listDevice[i].toString().trim();
                            int dID=Integer.parseInt(listDevice[i].toString().trim());
                            String content = request.getParameter(param);
                            //out.println("Element" + i + ":  " + content);
                            if(CreateComplaintDetails(complaintNew(), dID, content)==1){
                                cnt=cnt+1;
                            }

                        }
                    }
                }
                if(cnt==listDevice.length){
                     out.println("<div class=\"style-result\">Send complaint successfull!</div>");
                }else{
                     out.println("<div class=\"style-result\">Send complaint fail!</div>");
                }
            }
        }
        }
    }

    private int complaintNew() {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select TOP 1 complaintID from tbl_complaint order by complaintID desc ";
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("complaintID");
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(sendComplaint.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(sendComplaint.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private int CreateComplaint(int userID,String title) {
        Connection cnn = null;
        Statement st = null;
        SimpleDateFormat formater=new SimpleDateFormat("yyyy/MM/dd");
        String sql = "insert into tbl_complaint(userSend,status,datesend,title) values(" + userID + ",0,'"+formater.format(new Date())+"','"+title+"')";
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            int row = st.executeUpdate(sql);
            if (row > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(sendComplaint.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(sendComplaint.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }
private int CreateComplaintDetails(int complaintID,int dID,String content) {
        Connection cnn = null;
        Statement st = null;
        String sql = "insert into tbl_complaint_device values(" + complaintID + ","+dID+",'"+content+"')";
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            int row = st.executeUpdate(sql);
            if (row > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(sendComplaint.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(sendComplaint.class.getName()).log(Level.SEVERE, null, ex);
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
