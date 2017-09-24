/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package computerlabs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class dbconnect {
    static Connection cnn;
    public static Connection Connect(){
        try {
            //String connectionURL = "jdbc:odbc:sem4";
            //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            //cnn = DriverManager.getConnection(connectionURL, "lab", "");
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            cnn = DriverManager.getConnection("jdbc:sqlserver://localhost:1435;databaseName=sem4labs","lab","");
        } catch (SQLException ex) {
            Logger.getLogger(dbconnect.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(dbconnect.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnn;
    }
    public static void Disconnect(Connection cnn){
        try {
            cnn.close();
        } catch (SQLException ex) {
            Logger.getLogger(dbconnect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
