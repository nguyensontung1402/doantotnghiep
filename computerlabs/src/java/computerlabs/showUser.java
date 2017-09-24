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
import java.sql.PreparedStatement;
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
public class showUser extends HttpServlet {

    static final long serialVersionUID = 1L;
    int offset;
    int length;
    List list;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        int maxEntriesPerPage = 10;
        int page = 1;

        String pageNumberValue = request.getParameter("pageNumber");
        String txtSearchName = "";
        String txtFullName = "";
        String status = "ALL";
        String txtDepartment = "ALL";
        String HOD = "ALL";
        if (request.getParameter("user") != null) {
            if (!request.getParameter("user").trim().equalsIgnoreCase("")) {
                txtSearchName = request.getParameter("user");
            }
        }
        if (request.getParameter("fullname") != null) {
            if (!request.getParameter("fullname").trim().equalsIgnoreCase("")) {
                txtFullName = request.getParameter("fullname");
            }
        }
        if (request.getParameter("status") != null) {
            if (!request.getParameter("status").trim().equalsIgnoreCase("")) {
                status = request.getParameter("status");
            }
        }
        if (request.getParameter("department") != null) {
            if (!request.getParameter("department").trim().equalsIgnoreCase("")) {
                txtDepartment = request.getParameter("department");
            }
        }
        if (request.getParameter("hod") != null) {
            if (!request.getParameter("hod").trim().equalsIgnoreCase("")) {
                HOD = request.getParameter("hod");
            }
        }
        if (request.getParameter("userID") != null) {
            try {
                int userID = Integer.parseInt(request.getParameter("userID").toString().trim());
                deleteUser delete = new deleteUser();
                int rs = delete.deleteUser(userID);
                if (rs == 1) {
                    //out.println("Delete successfull!");
                    request.setAttribute("suc", "<div class=\"style-result\">Delete successfull!</div>");

                } else if (rs == 2) {
                    //out.println("Can not delete, Status account lock!");
                    request.setAttribute("lock", "<div class=\"style-result\">Can not delete, Status account lock!</div>");
                } else {
                    //out.println("Delete fail!");
                    request.setAttribute("fail", "<div class=\"style-result\">Delete fail!</div>");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
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
        TestList(offset, maxEntriesPerPage, txtSearchName, txtFullName, status, txtDepartment, HOD);

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
    public void fillList(String user, String fullname, String status, String department, String HOD) {
        list = new ArrayList();
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;

        String sql = "select * from tbl_user where departmentID!=1 ";
        if (!user.trim().equalsIgnoreCase("")) {
            sql += " and username like '%" + user + "%'";
        }
        if (!fullname.trim().equalsIgnoreCase("")) {
            sql += " and fullname like '%" + fullname + "%'";
        }
        if (!status.trim().equalsIgnoreCase("ALL")) {
            sql += " and status=" + status;
        }
        if (!department.trim().equalsIgnoreCase("ALL")) {
            sql += " and departmentID=" + department;
        }
        if (!HOD.trim().equalsIgnoreCase("ALL")) {
            sql += " and HOD=" + HOD;
        }
        sql += " order by userID,departmentID desc";
        String connectionURL = "jdbc:odbc:sem4";

        try {
            //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            //cnn = DriverManager.getConnection(connectionURL, "lab", "");
            cnn = dbconnect.Connect();
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                list.add(new classUser(rs.getInt("userID"), rs.getString("username"), rs.getString("fullname"),
                        rs.getInt("gender"), rs.getDate("birthday").toString(), rs.getInt("status"), rs.getInt("departmentID"), rs.getInt("HOD")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(NewServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     * @param offset
     * @param length
     */
    public void TestList(int offset, int length, String user, String fullname, String status, String department, String HOD) {
        this.offset = offset;
        this.length = length;
        fillList(user, fullname, status, department, HOD);
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
