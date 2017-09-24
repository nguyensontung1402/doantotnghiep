/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package device;

import computerlabs.dbconnect;
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
public class deleteDevice {

    public int delete(int dID) {
            deleteTableDetails(dID);
             deleteTableComplaint(dID);
            Connection cnn = null;
            Statement st = null;
            String sql = "delete from tbl_device where dID=" + dID;
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
                Logger.getLogger(deleteDevice.class.getName()).log(Level.SEVERE, null, ex);
                return 0;
            } finally {
                try {
                    st.close();
                    cnn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(deleteDevice.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
    }

    public int deleteTableDetails(int dID) {
        Connection cnn = null;
        Statement st = null;
        String sql = "delete from tbl_device_accessory where dID=" + dID;
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
            Logger.getLogger(deleteDevice.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(deleteDevice.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }
    public int deleteTableComplaint(int dID) {
        Connection cnn = null;
        Statement st = null;
        String sql = "delete from tbl_complaint_device where dID=" + dID;
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
            Logger.getLogger(deleteDevice.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(deleteDevice.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }
}
