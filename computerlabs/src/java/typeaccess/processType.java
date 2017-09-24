/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package typeaccess;

import computerlabs.CheckUsername;
import computerlabs.dbconnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
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
public class processType extends HttpServlet {

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
            if (checkExits(id) == 1) {
                out.println("<div class=\"style-result\">Can not delete category device. Update status hide!</div>");
            } else {
                if (deleteType(id) == 1) {
                    out.println("<div class=\"style-result\">Delete successfull!</div>");
                } else {
                    out.println("<div class=\"style-result\">Delete fail!</div>");
                }
            }
        } else if (act.equalsIgnoreCase("update")) {
            String typeNameUp = "";
            int status = 0;
            if (request.getParameter("typeNameUp") != null) {
                typeNameUp = request.getParameter("typeNameUp").toString().trim();
            }
            if (request.getParameter("statusUp") != null) {
                status = Integer.parseInt(request.getParameter("statusUp").toString().trim());
            }
            CheckUsername check = new CheckUsername();
            int result = check.checkUsername(typeNameUp, "tbl_type_accessory", "type_accessory", " and typeID!=" + id);
            if (result == 0) {
                if (updateInfo(id, typeNameUp, status) == 1) {
                    out.println("<div class=\"style-result\">Update successfull!</div>");
                } else {
                    out.println("<div class=\"style-result\">Update fail!</div>");
                }
            } else if (result == 1) {
                out.println("<div class=\"style-result\">Category Name is not valid!</div>");
            }

        } else if (act.equalsIgnoreCase("create")) {
            String typeName = "";
            int status = 0;
            if (request.getParameter("namecreate") != null) {
                typeName = request.getParameter("namecreate").toString().trim();
            }
            if (request.getParameter("statusCreate") != null) {
                status = Integer.parseInt(request.getParameter("statusCreate").toString().trim());
            }
            CheckUsername check = new CheckUsername();
            int result = check.checkUsername(typeName, "tbl_type_accessory", "type_accessory", "");
            if (result == 0) {
                if (createType(typeName, status) == 1) {
                    out.println("<div class=\"style-result\">Create successfull!</div>");
                } else {
                    out.println("<div class=\"style-result\">Create fail!</div>");
                }
            } else if (result == 1) {
                out.println("<div class=\"style-result\">Category Name is not valid!</div>");
            }

        }
    }

    private int deleteType(int typeID) {
        Connection cnn = null;
        Statement st = null;
        String sql = "delete from tbl_type_accessory where typeID=" + typeID;
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
            Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int updateInfo(int typeID, String typeName, int status) {
        Connection cnn = null;
        Statement st = null;
        String sql = "update tbl_type_accessory set type_accessory='" + typeName + "',status=" + status + " where typeID=" + typeID;
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
            Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int updateStatusHide(int typeID) {
        Connection cnn = null;
        Statement st = null;
        String sql = "update tbl_type_accessory set status=0 where typeID=" + typeID;
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
            Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int createType(String typeName, int status) {
        Connection cnn = null;
        Statement st = null;
        String sql = "insert into tbl_type_accessory values('" + typeName + "'," + status + ")";
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
            Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int checkExits(int typeID) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        int cnt = 0;
        String sql = "select * from tbl_accessory where typeID=" + typeID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                cnt = cnt + 1;
            }
            if (cnt > 0) {
                if (updateStatusHide(typeID) == 1) {
                    return 1;
                } else {
                    return 0;
                }
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(processType.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
