/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ScheduleClient;

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
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import processSchedule.classSchedule;

/**
 *
 * @author User
 */
public class showScheClient extends HttpServlet {

    static final long serialVersionUID = 1L;
    int offset;
    int length;
    List list;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        int maxEntriesPerPage = 6;
        int page = 1;

        String pageNumberValue = request.getParameter("pageNumber");
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
        int roomid = 1;
        if(request.getParameter("roomid")!=null){
            if(request.getParameter("roomid").equalsIgnoreCase("")){
                roomid=1;
            }
            else{
                 roomid=Integer.parseInt(request.getParameter("roomid"));
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
        TestList(offset, maxEntriesPerPage,roomid,inputdateTo,inputdateFrom);

        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("pages", getPages());
        httpSession.setAttribute("Schedule", getListByOffsetAndLength());

        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/timetable.jsp");  //link
        dispatcher.forward(request, response);
    }

    /* 
     * Hard-coded sample data. Normally this would come from a real data source 
     * such as a database 
     */
    public void fillList(int roomid,String inputdateTo,String inputdateFrom) {
        list = new ArrayList();
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;

        String sql = "select sche.scheduleID as ID,shift.shiftname as shiftname,lab.roomName as roomName,d.dateword as datework,"
                + " we.keyword as keywork,sche.status as status,sche.dateworkID sdateworkID from tbl_schedule as sche inner join "
                + " tbl_shiftname as shift on sche.shiftID=shift.shiftID inner "
                + " join tbl_labroom as lab on sche.roomID=lab.roomID inner join "
                + " tbl_datework as d on sche.dateworkID=d.datewordID inner join "
                + " days_week as we on d.dayID=we.dayID where lab.roomID="+roomid+" and d.dateword >='"+outPutDateSelect()+"'";
        if (inputdateTo.trim().length() > 3) {
            sql += " and d.dateword >='" + inputdateTo + "'";
        }
        if (inputdateFrom.trim().length() > 3) {
            sql += " and d.dateword <='" + inputdateFrom + "'";
        }
        sql+=" order by ID desc ";
        //String connectionURL = "jdbc:odbc:sem4";
        try {
            //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            //cnn = DriverManager.getConnection(connectionURL, "lab", "");
            cnn = dbconnect.Connect();
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            int count = 0;
            String ID = "";
            String shiftname = "";
            String status = "";
            String roomName = "";
            String datework = "";
            String daysweek = "";
            int dateworkID=0;
            SimpleDateFormat formarter=new SimpleDateFormat("EE, MMM d,yyyy");
            while (rs.next()) {
                count = count + 1;
                ID += rs.getInt("ID") + "/";
                shiftname += rs.getString("shiftname") + "/";
                roomName = rs.getString("roomName");
                
                datework = formarter.format(rs.getDate("datework"));
                daysweek = rs.getString("keywork");
                status += rs.getString("status") + "/";
                dateworkID = rs.getInt("sdateworkID");
                int totalShift=cntShiftShow();
                if (count % totalShift == 0) {
                    list.add(new classSchedule(ID, shiftname, roomName, datework, daysweek, status,dateworkID));
                    ID = "";
                    shiftname = "";
                    status = "";
                    roomName = "";
                    datework = "";
                    daysweek = "";
                }

            }
        } catch (SQLException ex) {
            Logger.getLogger(showScheClient.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     * @param offset
     * @param length
     */
    public void TestList(int offset, int length,int roomid,String inputdateTo,String inputdateFrom) {
        this.offset = offset;
        this.length = length;
        fillList(roomid,inputdateTo,inputdateFrom);
    }
    private String outPutDateSelect(){
        
            SimpleDateFormat formater=new SimpleDateFormat("EE");
            Calendar d=Calendar.getInstance();
            String EE=formater.format(d.getTime()).toUpperCase();
            if(EE.equalsIgnoreCase("MON")){
                d.add(Calendar.DATE, 0);
            }
            if(EE.equalsIgnoreCase("TUE")){
                d.add(Calendar.DATE, -1);
            }
            if(EE.equalsIgnoreCase("WED")){
                d.add(Calendar.DATE, -2);
            }
            if(EE.equalsIgnoreCase("THU")){
                d.add(Calendar.DATE, -3);
            }
            if(EE.equalsIgnoreCase("FRI")){
                d.add(Calendar.DATE, -4);
            }
            if(EE.equalsIgnoreCase("SAT")){
                d.add(Calendar.DATE, -5);
            }
            if(EE.equalsIgnoreCase("SUN")){
                d.add(Calendar.DATE, 0);
            }
            SimpleDateFormat formaterOut=new SimpleDateFormat("MM/dd/yyyy");
            return formaterOut.format(d.getTime());
        
    }

    
   private int cntShiftShow(){
       Connection cnn=null;
       Statement st=null;
       ResultSet rs=null;
       String sql="select COUNT(shiftID) as cnt from tbl_shiftname where shiftID!=7";
       cnn=dbconnect.Connect();
        try {
            st=cnn.createStatement();
            rs=st.executeQuery(sql);
            if(rs.next()){
                return rs.getInt("cnt");
            }else{
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(showScheClient.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }finally{
           try {
               rs.close();
               st.close();
               cnn.close();
           } catch (SQLException ex) {
               Logger.getLogger(showScheClient.class.getName()).log(Level.SEVERE, null, ex);
           }
        }
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
