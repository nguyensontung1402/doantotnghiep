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
public class checkExits {
    public int checkExit(String table,String property,int value){
        Connection cnn=null;
        Statement st=null;
        ResultSet rs=null;
        String sql="select * from "+table+" where "+property+"="+value;
        cnn=dbconnect.Connect();
        int cnt=0;
        try {
            st=cnn.createStatement();
            rs=st.executeQuery(sql);
            while(rs.next()){
                cnt=cnt+1;
            }
        } catch (SQLException ex) {
            Logger.getLogger(checkExits.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                rs.close();
                st.close();
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(checkExits.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return cnt;
    }
}
