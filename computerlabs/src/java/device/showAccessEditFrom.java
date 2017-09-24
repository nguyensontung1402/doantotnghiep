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
public class showAccessEditFrom {
    public String showAccess(int dID){
        Connection cnn=null;
        Statement st=null;
        ResultSet rs=null;
        String result="";
        String sql="select dID,accessID,status from tbl_device_accessory where dID="+dID;
        cnn=dbconnect.Connect();
        try {
            st=cnn.createStatement();
            rs=st.executeQuery(sql);
            while(rs.next()){
                result+=rs.getInt("accessID")+"/";
            }
        } catch (SQLException ex) {
            Logger.getLogger(showAccessEditFrom.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
}
