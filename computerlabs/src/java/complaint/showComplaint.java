/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package complaint;

import computerlabs.dbconnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
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
public class showComplaint extends HttpServlet {

    static final long serialVersionUID = 1L;
    int offset;
    int length;
    List list;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        int maxEntriesPerPage = 2;
        int page = 1;

        String pageNumberValue = request.getParameter("pageNumber");
        int status = 3;
        if (request.getParameter("status") != null) {
            status=Integer.parseInt(request.getParameter("status").toString().trim());
            request.setAttribute("statusSelected", status);
        }
        String inputdateTo = "";
        if (request.getParameter("inputdateTo") != null) {
            if (!request.getParameter("inputdateTo").trim().equalsIgnoreCase("")) {
                if (request.getParameter("inputdateTo").matches("(\\d{4})[\\/\\-\\.](0?[1-9]|1[012])[\\/\\-\\.](0?[1-9]|[12][0-9]|3[01])")) {
                    inputdateTo = request.getParameter("inputdateTo");
                    request.setAttribute("inputdateTo", inputdateTo);
                }
            }
        }
        String inputdateFrom = "";
        if (request.getParameter("inputdateFrom") != null) {
            if (!request.getParameter("inputdateFrom").trim().equalsIgnoreCase("")) {
                if (request.getParameter("inputdateFrom").matches("(\\d{4})[\\/\\-\\.](0?[1-9]|1[012])[\\/\\-\\.](0?[1-9]|[12][0-9]|3[01])")) {
                    inputdateFrom = request.getParameter("inputdateFrom");
                    request.setAttribute("inputdateFrom", inputdateFrom);
                }
            }
        }
        if (pageNumberValue != null) {
            try {
                page = Integer.parseInt(pageNumberValue);
                System.out.println("Page Number:" + page);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        int offset = maxEntriesPerPage * (page - 1);
        TestList(offset, maxEntriesPerPage, status,inputdateTo, inputdateFrom);

        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("pages", getPages());
        httpSession.setAttribute("complaintDetails", getListByOffsetAndLength());

        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/administration/managerComplaint.jsp");  //link
        dispatcher.forward(request, response);
    }

    /* 
     * Hard-coded sample data. Normally this would come from a real data source 
     * such as a database 
     */
    public void fillList(int status,String inputdateTo,String inputdateFrom) {
        list = new ArrayList();
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;

        
        String sql = "select c.complaintID as complaintID,c.title as title,u.fullname as userSend,c.datesend as dateSend,c.status as cstatus from tbl_complaint as c inner join tbl_user as u on c.userSend=u.userID  where 1=1 ";
       if (inputdateTo.trim().length() > 3) {
            sql += " and c.datesend >='" + inputdateTo + "'";
        }
        if (inputdateFrom.trim().length() > 3) {
            sql += " and c.datesend <='" + inputdateFrom + "'";
        }
          if (status!=3) {
            sql += " and c.status=" + status;
        }
        sql += " order by complaintID desc";
        SimpleDateFormat fomater=new SimpleDateFormat("MM/dd/yyyy");
        try {
            cnn = dbconnect.Connect();
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                int complaintID=rs.getInt("complaintID");
                String title=rs.getString("title");
                String userSend=rs.getString("userSend");
                String datesend=fomater.format(rs.getDate("dateSend"));
                String userProcess=userProcess(complaintID);
                int cStatus=rs.getInt("cstatus");
                list.add(new classComplaint(complaintID, title, cStatus, datesend, userSend, userProcess));
            }
        } catch (SQLException ex) {
            Logger.getLogger(showComplaint.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(showComplaint.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }
    private String userProcess(int complaintID){
        Connection cnn=null;
        Statement st=null;
        ResultSet rs=null;
        String sql="select u.fullname as userProcess from tbl_complaint as c inner join tbl_user as u on c.userProcess=u.userID where c.complaintID="+complaintID;
        cnn=dbconnect.Connect();
        try {
            st=cnn.createStatement();
            rs=st.executeQuery(sql);
            if(rs.next()){
                return rs.getString("userProcess");
            }else{
                return "";
            }
        } catch (SQLException ex) {
            Logger.getLogger(showComplaint.class.getName()).log(Level.SEVERE, null, ex);
            return "";
        }finally{
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(showComplaint.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
            
    }
    /**
     * @param offset
     * @param length
     */
    public void TestList(int offset, int length, int status,String inputdateTo, String inputdateFrom) {
        this.offset = offset;
        this.length = length;
        fillList(status, inputdateTo, inputdateFrom);
    }

    /**
     * @return List
     */
    public ArrayList getListByOffsetAndLength() {

        ArrayList arrayList = new ArrayList();
        int to = this.offset + this.length;
        if (this.offset > list.size()) {
            this.offset = list.size();
        }
        if (to > list.size()) {
            to = list.size();
        }
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
