/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package computerlabs;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
public class NewServlet extends HttpServlet {

    static final long serialVersionUID = 1L;  
    int offset;  
    int length;  
    List list;  
  
    protected void doGet(HttpServletRequest request,  
            HttpServletResponse response) throws ServletException, IOException {  
  
        int maxEntriesPerPage = 8;  
        int page = 1;  
  
        String pageNumberValue = request.getParameter("pageNumber");  
  
        if (pageNumberValue != null) {  
            try {  
                page = Integer.parseInt(pageNumberValue);  
                System.out.println("Page Number:" + page);  
            } catch (NumberFormatException e) {  
                e.printStackTrace();  
            }  
        }  
        int offset = maxEntriesPerPage * (page - 1);  
        TestList(offset, maxEntriesPerPage);  
  
        HttpSession httpSession = request.getSession();  
        httpSession.setAttribute("pages", getPages());  
        httpSession.setAttribute("studentDetails", getListByOffsetAndLength());  
  
        RequestDispatcher dispatcher = request  
                .getRequestDispatcher("/administration/manageruser.jsp");  //link
        dispatcher.forward(request, response);  
    }  
  
    /* 
     * Hard-coded sample data. Normally this would come from a real data source 
     * such as a database 
     */  
    public void fillList() {  
        list = new ArrayList();
        Connection cnn=null;
        Statement st=null;
        ResultSet rs=null;
         String sql="select * from tbl_user where departmentID!=1 order by userID desc";
        String connectionURL = "jdbc:odbc:sem4";
            
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            cnn = DriverManager.getConnection(connectionURL, "lab", "");
            st=cnn.createStatement();
            rs=st.executeQuery(sql);
            while(rs.next()){
                 list.add(new classUser(rs.getInt("userID"),rs.getString("username"),rs.getString("fullname"),
                         rs.getInt("gender"),rs.getDate("birthday").toString()
                         ,rs.getInt("status"),rs.getInt("departmentID"),rs.getInt("HOD")));  
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NewServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
       
    }  
  
    /** 
     * @param offset 
     * @param length 
     */  
    public void TestList(int offset, int length) {  
        this.offset = offset;  
        this.length = length;  
        fillList();  
    }  
  
    /** 
     * @return List 
     */  
    public ArrayList getListByOffsetAndLength() {  
  
        ArrayList arrayList = new ArrayList();  
        int to = this.offset + this.length;  
        if (this.offset > list.size())  
            this.offset = list.size();  
        if (to > list.size())  
            to = list.size();  
        for (int i = this.offset; i < to; i++) {  
            arrayList.add(list.get(i));  
        }  
        return arrayList;  
    }  
  
    /** 
     * @return List with page numbers 
     */  
    public List getPages() {  
        List pageNumbers = new ArrayList();  
        int pages = list.size() / this.length;  
        if (list.size() % this.length != 0) {  
            pages = pages + 1;  
        }  
  
        for (int i = 1; i <= pages; i++) {  
            pageNumbers.add(new Integer(i));  
        }  
        return pageNumbers;  
    }  
}
