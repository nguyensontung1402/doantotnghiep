/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package processSchedule;

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
public class totalRequestByScheID {
    public int total(int scheID){
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select COUNT(requestID) as totalRequest from tbl_request where scheduleID="+scheID;
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if(rs.next()){
                return rs.getInt("totalRequest");
            }
            else{
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(totalRequestByScheID.class.getName()).log(Level.SEVERE, null, ex);
             return 0;
        }finally{
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(totalRequestByScheID.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
