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
import processSchedule.checkRequest;

/**
 *
 * @author User
 */
public class checkAdminHOD {
    public int checkHOD(String username){
         Connection cnn=null;
        Statement st=null;
        ResultSet rs=null;
        int cntSuc=0;
        int cntLoad=0;
        String sql="select * from tbl_user where username='"+username+"' and departmentID=1 and HOD=1";
        cnn=dbconnect.Connect();
        try {
            st=cnn.createStatement();
            rs=st.executeQuery(sql);
            if(rs.next()){
                return 1;
            }else{
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(checkRequest.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }finally{
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(checkRequest.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
