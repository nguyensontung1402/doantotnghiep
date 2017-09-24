/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package labroom;

import computerlabs.CheckUsername;
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

/**
 *
 * @author User
 */
public class processLab extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String act = "";
        int id = 0;
        if (request.getParameter("ID") != null) {
            id = Integer.parseInt(request.getParameter("ID").toString().trim());
        }
        if (request.getParameter("act") != null) {
            act = request.getParameter("act").toString().trim();
        }
        if (act.equalsIgnoreCase("delete")) {
            if (checkExits(id,"tbl_schedule") == 1 || checkExits(id,"tbl_device") == 1) {
                out.println("<div class=\"style-result\">Can not delete Lab Room. Update status hide!</div>");
            } else {
                if (deleteLab(id) == 1) {
                    out.println("<div class=\"style-result\">Delete successfull!</div>");
                } else {
                    out.println("<div class=\"style-result\">Delete fail!</div>");
                }
            }
        } else if (act.equalsIgnoreCase("update")) {
            String roomNameUp = "";
            int status = 0;
            float width=0;
            float length=0;
            if (request.getParameter("roomNameUp") != null) {
                roomNameUp = request.getParameter("roomNameUp").toString().trim();
            }
            if (request.getParameter("statusUp") != null) {
                status = Integer.parseInt(request.getParameter("statusUp").toString().trim());
            }
            if (request.getParameter("withUp") != null) {
                width = Float.parseFloat(request.getParameter("withUp").toString().trim());
            }
            if (request.getParameter("lengthUp") != null) {
                length = Float.parseFloat(request.getParameter("lengthUp").toString().trim());
            }
            CheckUsername check = new CheckUsername();
            int result = check.checkUsername(roomNameUp, "tbl_labroom", "roomName", " and roomID!=" + id);
            if (result == 0) {
                if (updateInfo(id, roomNameUp,width,length,status) == 1) {
                    out.println("<div class=\"style-result\">Update successfull!</div>");
                } else {
                    out.println("<div class=\"style-result\">Update fail!</div>");
                }
            } else if (result == 1) {
                out.println("<div class=\"style-result\">Room Name is not valid!</div>");
            }

        } else if (act.equalsIgnoreCase("create")) { // chua xu ly
            String roomNameCreate = "";
            int status = 0;
            float width=0;
            float length=0;
            if (request.getParameter("namecreate") != null) {
                roomNameCreate = request.getParameter("namecreate").toString().trim();
            }
            if (request.getParameter("statusCreate") != null) {
                status = Integer.parseInt(request.getParameter("statusCreate").toString().trim());
            }
            if (request.getParameter("withCreate") != null) {
                width = Float.parseFloat(request.getParameter("withCreate").toString().trim());
            }
            if (request.getParameter("lengthCreate") != null) {
                length = Float.parseFloat(request.getParameter("lengthCreate").toString().trim());
            }
            CheckUsername check = new CheckUsername();
            int result = check.checkUsername(roomNameCreate, "tbl_labroom", "roomName", "");
            if (result == 0) {
                if (createLab(roomNameCreate, status,width,length) == 1) {
                    out.println("<div class=\"style-result\">Create successfull!</div>");
                } else {
                    out.println("<div class=\"style-result\">Create fail!</div>");
                }
            } else if (result == 1) {
                out.println("<div class=\"style-result\">Room Name is not valid!</div>");
            }

        }
    }

    private int deleteLab(int labID) {
        Connection cnn = null;
        Statement st = null;
        String sql = "delete from tbl_labroom where roomID=" + labID;
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
            Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int updateInfo(int labID, String roomName,float width,float length, int status) {
        Connection cnn = null;
        Statement st = null;
        String sql = "update tbl_labroom set roomName='" + roomName + "',status=" + status + " ,width="+width+" , length="+length+" where roomID=" + labID;
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
            Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int updateStatusHide(int roomID) {
        Connection cnn = null;
        Statement st = null;
        String sql = "update tbl_labroom set status=0 where roomID=" + roomID;
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
            Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int createLab(String roomName, int status,float width,float length) {
        Connection cnn = null;
        Statement st = null;
        Date date=new Date();
        SimpleDateFormat formart=new SimpleDateFormat("yyyy/MM/dd");
        String sql = "insert into tbl_labroom(roomName,status,width,length,datecreate) values('" + roomName + "'," + status + ","+width+","+length+",'"+formart.format(date)+"')";
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
            Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int checkExits(int roomID,String table) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        int cnt = 0;
        String sql = "select * from "+table+" where roomID=" + roomID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                cnt = cnt + 1;
            }
            if (cnt > 0) {
                if (updateStatusHide(roomID) == 1) {
                    return 1;
                } else {
                    return 0;
                }
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processLab.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
