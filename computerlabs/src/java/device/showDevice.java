/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package device;

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
public class showDevice extends HttpServlet {

    static final long serialVersionUID = 1L;
    int offset;
    int length;
    List list;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        int maxEntriesPerPage = 7;
        int page = 1;

        String pageNumberValue = request.getParameter("pageNumber");
        String dName = "";
        int status = 2;
        int cateID = 0;
        if (request.getParameter("name") != null) {
            if (!request.getParameter("name").trim().equalsIgnoreCase("")) {
                dName = request.getParameter("name");
            }
        }
        if (request.getParameter("status") != null) {
            status = Integer.parseInt(request.getParameter("status").toString().trim());
            request.setAttribute("statusSelected", status);
        }
        if (request.getParameter("cateID") != null) {
            cateID = Integer.parseInt(request.getParameter("cateID").toString().trim());
            request.setAttribute("CateSelected", cateID);
        }
        int roomid = showIDNew();
        if (request.getParameter("roomID") != null) {
            if (request.getParameter("roomID").equalsIgnoreCase("")) {
                roomid = showIDNew();
            } else {
                roomid = Integer.parseInt(request.getParameter("roomID"));
                request.setAttribute("RoomSelected", roomid);
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
        TestList(offset, maxEntriesPerPage, dName, status, roomid, cateID);

        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("pages", getPages());
        httpSession.setAttribute("deviceInfo", getListByOffsetAndLength());

        RequestDispatcher dispatcher = request
                .getRequestDispatcher("/administration/managerDevice.jsp");  //link
        dispatcher.forward(request, response);
    }

    private int showIDNew() {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select TOP 1 roomID from tbl_labroom";
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("roomID");
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(showDevice.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(showDevice.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }
    /* 
     * Hard-coded sample data. Normally this would come from a real data source 
     * such as a database 
     */

    public void fillList(String name, int status, int roomID, int cateID) {
        list = new ArrayList();
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;

        String sql = "select d.dID as dID,d.dName as dName,c.cateName as cateName "
                + " ,d.warranty_to as wTo,d.warranty_from as wFrom,d.[dateAdd] "
                + "  as dateAdded, d.[status] as dstatus from tbl_device as d inner join tbl_category "
                + " as c on d.cateID=c.cateID inner join "
                + " tbl_labroom as l on d.roomID=l.roomID where d.roomID=" + roomID;
        if (!name.trim().equalsIgnoreCase("")) {
            sql += " and dName like '%" + name + "%'";
        }
        if (cateID != 0) {
            sql += " and d.cateID=" + cateID;
        }
        if (status != 2) {
            sql += " and d.status=" + status;
        }
        sql += " order by d.dID desc";

        try {
            cnn = dbconnect.Connect();
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            SimpleDateFormat fomarter = new SimpleDateFormat("MM/dd/yyyy");
            while (rs.next()) {
                int dID = rs.getInt("dID");
                String dName = rs.getString("dName");
                String cateName = rs.getString("cateName");
                String wTo = fomarter.format(rs.getDate("wTo"));
                String wFrom = fomarter.format(rs.getDate("wFrom"));
                String dateAdded = fomarter.format(rs.getDate("dateAdded"));
                int dstatus = rs.getInt("dstatus");
                list.add(new classDevice(dID, dName, cateName, wTo, wFrom, dateAdded, dstatus));
            }
        } catch (SQLException ex) {
            Logger.getLogger(showDevice.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(showDevice.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    /**
     * @param offset
     * @param length
     */
    public void TestList(int offset, int length, String typeName, int status, int roomID, int cateID) {
        this.offset = offset;
        this.length = length;
        fillList(typeName, status, roomID, cateID);
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
