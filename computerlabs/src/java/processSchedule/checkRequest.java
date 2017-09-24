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
public class checkRequest {
    public int checkStatusRequest(int scheID){
        Connection cnn=null;
        Statement st=null;
        ResultSet rs=null;
        int cntSuc=0;
        int cntLoad=0;
        String sql="select * from tbl_request where scheduleID="+scheID;
        cnn=dbconnect.Connect();
        try {
            st=cnn.createStatement();
            rs=st.executeQuery(sql);
            while(rs.next()){
                if(rs.getInt("status")==2){
                    cntSuc=cntSuc+1;
                }else if(rs.getInt("status")==0){
                    cntLoad=cntLoad+1;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(checkRequest.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(checkRequest.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if(cntSuc>0){
            return 2;
        }
        else if(cntLoad>0){
             return 0;
        }
        else{
            return 10;
        }
        
    }
}
