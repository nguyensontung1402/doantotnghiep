/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package computerlabs;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class deleteUser {

    public int deleteUser(int userID) {
        Connection cnn = null;
        Statement st = null;
        String sql = "delete from tbl_user where userID=" + userID;
        if (checkInComplaint(userID) == 1 || checkInRequest(userID) == 1) {
            if(updatelock(userID)==1){
                return 2;
            }else{
                return 0;
            }
        } else {
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
                Logger.getLogger(deleteUser.class.getName()).log(Level.SEVERE, null, ex);
                return 0;
            } finally {
                try {
                    st.close();
                    cnn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(deleteUser.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
    public int updatelock(int userID) {
        Connection cnn = null;
        Statement st = null;
        String sql = "update tbl_user set status=0 where userID=" + userID;
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
                Logger.getLogger(deleteUser.class.getName()).log(Level.SEVERE, null, ex);
                return 0;
            } finally {
                try {
                    st.close();
                    cnn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(deleteUser.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
    }

    private int checkInRequest(int userID) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        int cnt = 0;
        String sql = "select userID from tbl_request  where userID=" + userID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                cnt = cnt + 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(deleteUser.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(deleteUser.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (cnt > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    private int checkInComplaint(int userID) {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        int cnt = 0;
        String sql = "select userSend from tbl_complaint  where userSend=" + userID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                cnt = cnt + 1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(deleteUser.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(deleteUser.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if (cnt > 0) {
            return 1;
        } else {
            return 0;
        }
    }
}
