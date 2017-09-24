/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package processSchedule;

import computerlabs.NewServlet;
import computerlabs.classUser;
import computerlabs.dbconnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
public class scheduleDetails extends HttpServlet {

    static final long serialVersionUID = 1L;
    int offset;
    int length;
    List list;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        int maxEntriesPerPage = 10;
        int page = 1;
        int sID = 0;
         HttpSession httpSession = request.getSession();
        String pageNumberValue = request.getParameter("pageNumber");
        String txtSearchName = "";
         String txtFullName="";
         int status = 3;
         String txtClassName="";
         if(request.getParameter("user")!=null){
             if(!request.getParameter("user").trim().equalsIgnoreCase("")){
                txtSearchName=request.getParameter("user");  
             }
         }
         if(request.getParameter("fullname")!=null){
             if(!request.getParameter("fullname").trim().equalsIgnoreCase("")){
                txtFullName=request.getParameter("fullname");  
             }
         }
         if(request.getParameter("searchstatus")!=null){
             status=Integer.parseInt(request.getParameter("searchstatus").toString().trim());
             request.setAttribute("statusSelected", status);
         }
         if(request.getParameter("classname")!=null){
             if(!request.getParameter("classname").trim().equalsIgnoreCase("")){
                txtClassName=request.getParameter("classname");  
             }
         }
        if(httpSession.getAttribute("scheID")!=null){
            try{  
            sID= Integer.parseInt(httpSession.getAttribute("scheID").toString());
            }catch(Exception ex){
                sID=0;
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
        TestList(offset, maxEntriesPerPage, sID,txtSearchName,txtFullName,txtClassName,status);

       
        httpSession.setAttribute("pages", getPages());
        httpSession.setAttribute("scheRequest", getListByOffsetAndLength());

        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/administration/scheduleDetails.jsp");  //link
        dispatcher.forward(request, response);
    }

    /* 
     * Hard-coded sample data. Normally this would come from a real data source 
     * such as a database 
     */
    public void fillList(int sID,String searchUser,String searchFullname,String searchClassName,int searchStatus) {
        list = new ArrayList();
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        SimpleDateFormat formarter = new SimpleDateFormat("EE, MMM d,yyyy");
        String sql = "select u.username as username,c.className as className,r.courseName courseName,"
                + "r.sendDate as sendDate,l.roomName roomName,s.shiftname as sName,s.starttime,s.endtime,d.dateword,u.fullname as fullname, r.status as restatus,r.requestID as requestID  "
                + "from tbl_request as r inner join tbl_user as u on r.userID=u.userID "
                + "inner join tbl_class as c on r.classID=c.classID inner join tbl_schedule "
                + "as sche on r.scheduleID=sche.scheduleID inner join tbl_shiftname as s on "
                + " sche.shiftID=s.shiftID inner join tbl_labroom as l on sche.roomID=l.roomID "
                + " inner join tbl_datework as d on sche.dateworkID=d.datewordID where r.scheduleID="+sID;
        if(!searchUser.trim().equalsIgnoreCase("")){
              sql+=" and username like '%"+searchUser+"%'";
          }
         if(!searchFullname.trim().equalsIgnoreCase("")){
              sql+=" and fullname like '%"+searchFullname+"%'";
          }
         if(searchStatus!=3){
              sql+=" and r.status="+searchStatus;
          }
          if(!searchClassName.trim().equalsIgnoreCase("")){
              sql+=" and className like '%"+searchClassName+"%'";
          }
        cnn = dbconnect.Connect();
        int cnt = 0;
       if (sID > 0) {
            try {
                st = cnn.createStatement();
                rs = st.executeQuery(sql);
                while (rs.next()) {
                    String user = rs.getString("username");
                    String className = rs.getString("className");
                    String courseName = rs.getString("courseName");
                    String sendDate = formarter.format(rs.getDate("sendDate"));
                    String roomName = rs.getString("roomName");
                    String sName = rs.getString("sName");
                    String starttime = rs.getTime("starttime").toString();
                    String endtime = rs.getTime("endtime").toString();
                    String dateword = formarter.format(rs.getDate("dateword"));
                    String fullname = rs.getString("fullname");
                    int status = rs.getInt("restatus");
                    int requestID = rs.getInt("requestID");
                    cnt = cnt + 1;
                    list.add(new classRequest(user,className,courseName,sendDate,roomName,sName,starttime.substring(0, 5)+"-"+endtime.substring(0, 5),dateword,fullname,status+"",cnt,requestID));
                }
            } catch (SQLException ex) {
                Logger.getLogger(scheduleDetails.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    /**
     * @param offset
     * @param length
     */
    public void TestList(int offset, int length, int sID,String userN,String fullN,String ClassN,int RStatus) {
        this.offset = offset;
        this.length = length;
        fillList(sID,userN,fullN,ClassN,RStatus);
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
