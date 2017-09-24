/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package processSchedule;

import computerlabs.CheckUsername;
import computerlabs.createuser;
import computerlabs.dbconnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class createSchedule extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        String txtNumber = request.getParameter("txtNumber");
        String txtResultRoom = request.getParameter("txtResultRoom");
        String txtResultShift = request.getParameter("txtResultShift");
        boolean check = true;
        if (txtNumber.equalsIgnoreCase("") || txtResultRoom.equalsIgnoreCase("") || txtResultShift.equalsIgnoreCase("")) {
            check = false;
        } else {
            try {
                Integer.parseInt(txtNumber);
            } catch (Exception ex) {
                check = false;
            }
        }
        if (cntShift() <= 0) {
            check = false;
        }
        if (cntRoom() <= 0) {
            check = false;
        }

        if (check == true) {
            if (Integer.parseInt(txtNumber) < 6) {
                int sodu = Integer.parseInt(txtNumber);
                int datenull = 6 - sodu;
                int totalnumberdate = datenull + Integer.parseInt(txtNumber);
                String result = Create(totalnumberdate, txtResultRoom, txtResultShift, datenull, Integer.parseInt(txtNumber));
                if (result.trim().equalsIgnoreCase("successfull")) {
                    out.println("Create Successfull!");
                }
            } else if (Integer.parseInt(txtNumber) > 6) {
                int sodu = Integer.parseInt(txtNumber) % 6;
                int datenull = 6 - sodu;
                int totalnumberdate = datenull + Integer.parseInt(txtNumber);
                String result = Create(totalnumberdate, txtResultRoom, txtResultShift, datenull, Integer.parseInt(txtNumber));
                if (result.trim().equalsIgnoreCase("successfull")) {
                    out.println("Create Successfull!");
                }
            } else if (Integer.parseInt(txtNumber) == 6) {
                int datenull = 0;
                int totalnumberdate = datenull + Integer.parseInt(txtNumber);
                String result = Create(totalnumberdate, txtResultRoom, txtResultShift, datenull, Integer.parseInt(txtNumber));
                if (result.trim().equalsIgnoreCase("successfull")) {
                    out.println("Create Successfull!");
                }
            }
        } else {
            out.println("Create fail!");
        }
    }

    private int cntRoom() {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select COUNT(roomID) as cntRoom from tbl_labroom where status=1";
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("cntRoom");
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private int cntShift() {
        Connection cnn = null;
        Statement st = null;
        ResultSet rs = null;
        String sql = "select COUNT(shiftID) as cnt from tbl_shiftname where status=1";
        cnn = dbconnect.Connect();
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("cnt");
            } else {
                return 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();
            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private String Create(int numberDay, String RoomChecked, String ShiftChecked, int datenull, int numberEnter) {
        Connection cnn = null;
        PreparedStatement pst = null;
        PreparedStatement pstDate = null;
        Statement st = null;
        ResultSet rs = null;
        int cntResult = 0;
        String sqlDaysWeek = "select * from days_week ";
        String sqlShift = "select * from tbl_shiftname where status=1 ";
        String sqlDateWork = "insert into tbl_datework(dateword,status,dayID) values(?,1,?)";
        //String sqlSchedule="insert into tbl_schedule(shiftID,roomID,dateworkID,status) values(?,?,?,?) ";
        String chuoi = "";

        //Start Split Room
        String[] roomID = RoomChecked.split("/");
        String[] arrshiftIDChecked = ShiftChecked.split("/");
        //End Split Room
        SimpleDateFormat sdf = new SimpleDateFormat("EE/yyyy/MM/dd");
        for (int j = 0; j < roomID.length; j++) {
            String outPutEnddate = outPutEnddate(Integer.parseInt(roomID[j]));
            String[] str = outPutEnddate.split("/");
            int year = Integer.parseInt(str[0].toString().trim());
            int month = Integer.parseInt(str[1].toString().trim());
            int day = Integer.parseInt(str[2].toString().trim());
            //
            int scheMax = ScheduleNULLMax(Integer.parseInt(roomID[j]));
            int scheMin = ScheduleNULLMin(Integer.parseInt(roomID[j]));

            int numberUpdate = ((scheMax - scheMin) + 1) / 6;
            if (numberEnter <= numberUpdate) {
                numberUpdate = numberEnter;
            }
            //bat dau tao tung ngay 1
            int runUpdate = 0;

            //Update schedule
            if (numberUpdate > 0) {
                if (runUpdate < numberUpdate) {
                    for (int i = 1; i <= numberUpdate; i++) {
                        Statement stShiftUp = null;
                        ResultSet rsShiftUp = null;
                        cnn = dbconnect.Connect();
                        runUpdate = runUpdate + 1;

                        try {
                            stShiftUp = cnn.createStatement();
                            rsShiftUp = stShiftUp.executeQuery(sqlShift);
                            while (rsShiftUp.next()) {
                                int shiftUpID = rsShiftUp.getInt("shiftID");
                                boolean check = true;
                                for (int k = 0; k < arrshiftIDChecked.length; k++) {
                                    if (shiftUpID == Integer.parseInt(arrshiftIDChecked[k].toString())) {
                                        check = false;
                                        UpdateSchedule(shiftUpID, 1, Integer.parseInt(roomID[j]), scheMin);
                                        cntResult = cntResult + 1;
                                        scheMin = scheMin + 1;
                                    }

                                }
                                if (check == true) {
                                    System.out.println("ShiftNoCheck: " + shiftUpID + " - " + roomID[j]);
                                    //String datework = EE[1] + "-" + EE[2] + "-" + EE[3];
                                    UpdateSchedule(shiftUpID, 0, Integer.parseInt(roomID[j]), scheMin);
                                    cntResult = cntResult + 1;
                                    scheMin = scheMin + 1;
                                }
                            }

                        } catch (Exception ex) {

                        } finally {
                            try {
                                rsShiftUp.close();
                                stShiftUp.close();
                                cnn.close();
                            } catch (SQLException ex) {
                                Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                    }
                } //create schedule phan update
                if (numberEnter > numberUpdate) { // neu numberenter=7 va numberUpdate=4
                    int numberInsert = numberEnter - numberUpdate; //>numberinsert =3
                    if (numberInsert > 0) {
                        //TH 1
                        if (numberInsert < 6) {
                            int chiadu = numberInsert; // phai tao 3 ban ghi co du lieu
                            int datenullUP = 6 - chiadu; // 3 ban ghi trong'
                            int totalnumberdateUP = datenullUP + chiadu; // tong so ban ghi
                            int tongsovonglap = NumberDay(totalnumberdateUP, year, month, day); // trong truong hop dinh' ngay chu nhat thi total++
                            for (int i = 1; i <= tongsovonglap; i++) {
                                Calendar c1 = Calendar.getInstance();
                                c1.set(year, month - 1, day); //(year,month,date) lưu ý
                                c1.add(Calendar.DATE, i);
                                String[] EE = sdf.format(c1.getTime()).toUpperCase().split("/");

                                if (!EE[0].equalsIgnoreCase("SUN")) {
                                    //chuoi+=sdf.format(c1.getTime()).toUpperCase()+"<br/>";
                                    cnn = dbconnect.Connect();
                                    try {
                                        st = cnn.createStatement();
                                        rs = st.executeQuery(sqlDaysWeek);// tao ngay
                                        while (rs.next()) {
                                            int dayID = rs.getInt("dayID");
                                            if (checkExitsDate(EE[1] + "-" + EE[2] + "-" + EE[3]) <= 0) {// kiem tra xem ngay da duoc tao chua, neu chua thi insert ngay
                                                if (EE[0].equalsIgnoreCase(rs.getString("keyword").toUpperCase())) {
                                                    try {
                                                        cnn = dbconnect.Connect();
                                                        pstDate = cnn.prepareStatement(sqlDateWork);
                                                        pstDate.setString(1, EE[1] + "-" + EE[2] + "-" + EE[3]);
                                                        pstDate.setInt(2, dayID);
                                                        int rowDate = pstDate.executeUpdate(); // insert datework
                                                        if (rowDate > 0) { // neu insert date work thanh cong thi insert schedule

                                                        }
                                                    } catch (Exception ex) {

                                                    } finally {
                                                        pstDate.close();
                                                        cnn.close();
                                                    }
                                                }
                                            }
                                        }
                                        Statement stShift = null;
                                        ResultSet rsShift = null;
                                        try {
                                            cnn = dbconnect.Connect();
                                            stShift = cnn.createStatement();
                                            rsShift = stShift.executeQuery(sqlShift);
                                            while (rsShift.next()) {
                                                int shiftID = rsShift.getInt("shiftID");
                                                String datework = EE[1] + "-" + EE[2] + "-" + EE[3];//l
                                                if (i <= NumberDay(totalnumberdateUP, year, month, day) - datenullUP) { // van de o? day
                                                    boolean check = true;
                                                    for (int k = 0; k < arrshiftIDChecked.length; k++) {
                                                        if (shiftID == Integer.parseInt(arrshiftIDChecked[k].toString())) {
                                                            check = false;
                                                            System.out.println("ShiftChecked: " + shiftID + " - " + roomID[j]);
                                                            //String datework = EE[1] + "-" + EE[2] + "-" + EE[3];
                                                            createSchedule(shiftID, Integer.parseInt(roomID[j]), datework, 1);
                                                            cntResult = cntResult + 1;
                                                        }

                                                    }
                                                    if (check == true) {
                                                        System.out.println("ShiftNoCheck: " + shiftID + " - " + roomID[j]);
                                                        //String datework = EE[1] + "-" + EE[2] + "-" + EE[3];
                                                        createSchedule(shiftID, Integer.parseInt(roomID[j]), datework, 0);
                                                        cntResult = cntResult + 1;
                                                    }
                                                } else {
                                                    createSchedule(7, Integer.parseInt(roomID[j]), datework, 2);
                                                }

                                            }
                                        } catch (Exception ex) {

                                        } finally {
                                            try {
                                                rsShift.close();
                                                stShift.close();
                                                cnn.close();
                                            } catch (SQLException ex) {
                                                Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
                                            }
                                        }
                                    } catch (Exception ex1) {

                                    } finally {
                                        try {
                                            rs.close();
                                            st.close();
                                            cnn.close();
                                        } catch (SQLException ex) {
                                            Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
                                        }
                                    }

                                }//lap

                            }
                        } else {//TH 2
                            int chiadu = numberInsert % 6;
                            int datenullUP = 6 - chiadu;
                            if(chiadu==0){
                                datenullUP=0;
                            }
                            int totalnumberdateUP = datenullUP + numberInsert;
                            for (int i = 1; i <= NumberDay(totalnumberdateUP, year, month, day); i++) {
                                Calendar c1 = Calendar.getInstance();
                                c1.set(year, month - 1, day); //(year,month,date) lưu ý
                                c1.add(Calendar.DATE, i);
                                String[] EE = sdf.format(c1.getTime()).toUpperCase().split("/");

                                if (!EE[0].equalsIgnoreCase("SUN")) {
                                    //chuoi+=sdf.format(c1.getTime()).toUpperCase()+"<br/>";
                                    cnn = dbconnect.Connect();
                                    try {
                                        st = cnn.createStatement();
                                        rs = st.executeQuery(sqlDaysWeek);// tao ngay
                                        while (rs.next()) {
                                            int dayID = rs.getInt("dayID");
                                            if (checkExitsDate(EE[1] + "-" + EE[2] + "-" + EE[3]) <= 0) {// kiem tra xem ngay da duoc tao chua, neu chua thi insert ngay
                                                if (EE[0].equalsIgnoreCase(rs.getString("keyword").toUpperCase())) {
                                                    try {
                                                        pstDate = cnn.prepareStatement(sqlDateWork);
                                                        pstDate.setString(1, EE[1] + "-" + EE[2] + "-" + EE[3]);
                                                        pstDate.setInt(2, dayID);
                                                        int rowDate = pstDate.executeUpdate(); // insert datework
                                                        if (rowDate > 0) { // neu insert date work thanh cong thi insert schedule

                                                        }
                                                    } catch (Exception ex) {

                                                    } finally {
                                                        pstDate.close();
                                                    }
                                                }
                                            }
                                        }
                                        Statement stShift = null;
                                        ResultSet rsShift = null;
                                        try {
                                            cnn = dbconnect.Connect();
                                            stShift = cnn.createStatement();
                                            rsShift = stShift.executeQuery(sqlShift);
                                            while (rsShift.next()) {
                                                int shiftID = rsShift.getInt("shiftID");
                                                String datework = EE[1] + "-" + EE[2] + "-" + EE[3];//l
                                                if (i <= NumberDay(totalnumberdateUP, year, month, day) - datenullUP) {
                                                    boolean check = true;
                                                    for (int k = 0; k < arrshiftIDChecked.length; k++) {
                                                        if (shiftID == Integer.parseInt(arrshiftIDChecked[k].toString())) {
                                                            check = false;
                                                            System.out.println("ShiftChecked: " + shiftID + " - " + roomID[j]);
                                                            //String datework = EE[1] + "-" + EE[2] + "-" + EE[3];
                                                            createSchedule(shiftID, Integer.parseInt(roomID[j]), datework, 1);
                                                            cntResult = cntResult + 1;
                                                        }

                                                    }
                                                    if (check == true) {
                                                        System.out.println("ShiftNoCheck: " + shiftID + " - " + roomID[j]);
                                                        //String datework = EE[1] + "-" + EE[2] + "-" + EE[3];
                                                        createSchedule(shiftID, Integer.parseInt(roomID[j]), datework, 0);
                                                        cntResult = cntResult + 1;
                                                    }
                                                } else {
                                                    createSchedule(7, Integer.parseInt(roomID[j]), datework, 2);
                                                }

                                            }
                                        } catch (Exception ex) {

                                        } finally {
                                            try {
                                                rsShift.close();
                                                stShift.close();
                                                cnn.close();
                                            } catch (SQLException ex) {
                                                Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
                                            }
                                        }
                                    } catch (Exception ex1) {

                                    } finally {
                                        try {
                                            rs.close();
                                            st.close();
                                            cnn.close();
                                        } catch (SQLException ex) {
                                            Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
                                        }
                                    }

                                }//lap

                            }
                        }
                    }
                }
            
            } else { // truong hop nguoc lai khong can sua
                int number = NumberDay(numberDay, year, month, day);
                int chiadu=numberEnter%6;         
               
                     
                for (int i = 1; i <= number; i++) {
                    Calendar c1 = Calendar.getInstance();
                    c1.set(year, month - 1, day); //(year,month,date) lưu ý
                    c1.add(Calendar.DATE, i);
                    String[] EE = sdf.format(c1.getTime()).toUpperCase().split("/");

                    if (!EE[0].equalsIgnoreCase("SUN")) {
                        //chuoi+=sdf.format(c1.getTime()).toUpperCase()+"<br/>";
                        cnn = dbconnect.Connect();
                        try {
                            st = cnn.createStatement();
                            rs = st.executeQuery(sqlDaysWeek);// tao ngay
                            while (rs.next()) {
                                int dayID = rs.getInt("dayID");
                                if (checkExitsDate(EE[1] + "-" + EE[2] + "-" + EE[3]) <= 0) {// kiem tra xem ngay da duoc tao chua, neu chua thi insert ngay
                                    if (EE[0].equalsIgnoreCase(rs.getString("keyword").toUpperCase())) {
                                        try {
                                            pstDate = cnn.prepareStatement(sqlDateWork);
                                            pstDate.setString(1, EE[1] + "-" + EE[2] + "-" + EE[3]);
                                            pstDate.setInt(2, dayID);
                                            int rowDate = pstDate.executeUpdate(); // insert datework
                                            if (rowDate > 0) { // neu insert date work thanh cong thi insert schedule

                                            }
                                        } catch (Exception ex) {

                                        } finally {
                                            pstDate.close();
                                        }
                                    }
                                }
                            }
                            //insert
                            Statement stShift = null;
                            ResultSet rsShift = null;
                            try {
                                stShift = cnn.createStatement();
                                rsShift = stShift.executeQuery(sqlShift);
                                while (rsShift.next()) {
                                    int shiftID = rsShift.getInt("shiftID");
                                    String datework = EE[1] + "-" + EE[2] + "-" + EE[3];//l
                                    if (i <= (number - datenull)) {
                                        boolean check = true;
                                        for (int k = 0; k < arrshiftIDChecked.length; k++) {
                                            if (shiftID == Integer.parseInt(arrshiftIDChecked[k].toString())) {
                                                check = false;
                                                System.out.println("ShiftChecked: " + shiftID + " - " + roomID[j]);
                                                //String datework = EE[1] + "-" + EE[2] + "-" + EE[3];
                                                createSchedule(shiftID, Integer.parseInt(roomID[j]), datework, 1);
                                                cntResult = cntResult + 1;
                                            }

                                        }
                                        if (check == true) {
                                            System.out.println("ShiftNoCheck: " + shiftID + " - " + roomID[j]);
                                            //String datework = EE[1] + "-" + EE[2] + "-" + EE[3];
                                            createSchedule(shiftID, Integer.parseInt(roomID[j]), datework, 0);
                                            cntResult = cntResult + 1;
                                        }
                                    } else {
                                        if(chiadu!=0){
                                            createSchedule(7, Integer.parseInt(roomID[j]), datework, 2);
                                        }
                                    }

                                }
                            } catch (Exception ex) {

                            } finally {
                                rsShift.close();
                                stShift.close();
                            }

                        } catch (Exception ex1) {

                        } finally {
                            try {
                                rs.close();
                                st.close();
                                cnn.close();
                            } catch (SQLException ex) {
                                Logger.getLogger(createSchedule.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }

                    }
                }
                //return "c1.set("+year+","+month+" ,"+day+") : " + sdf.format(c1.getTime())+"<br/>";
                //return chuoi;

            }
        }
            if (cntResult
                    > 0) {
                return "successfull";
            } else {
                return "fail";
            }
        }
    
    

    private void UpdateSchedule(int shiftID, int status, int roomid, int scheID) {
        Connection cnn = null;
        PreparedStatement pst = null;

//            String connectionURL = "jdbc:odbc:sem4";
//            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//            cnn = DriverManager.getConnection(connectionURL, "lab", "");
        cnn = dbconnect.Connect();
        String sqlUpdate = "update tbl_schedule set status=?,shiftID=? where roomID=? and scheduleID=? ";
        try {
            pst = cnn.prepareStatement(sqlUpdate);
            pst.setInt(1, status);
            pst.setInt(2, shiftID);
            pst.setInt(3, roomid);
            pst.setInt(4, scheID);
            pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                pst.close();
                cnn.close();

            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class
                        .getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    private int NumberDay(int numberday, int year, int month, int day) {
        int number = numberday;
        SimpleDateFormat sdf = new SimpleDateFormat("EE/yyyy/MM/dd");
        for (int i = 1; i <= numberday; i++) {
            Calendar c1 = Calendar.getInstance();
            c1.set(year, month - 1, day); //(year,month,date) lưu ý
            c1.add(Calendar.DATE, i);
            String[] EE = sdf.format(c1.getTime()).toUpperCase().split("/");
            if (EE[0].equalsIgnoreCase("SUN")) {
                number = number + 1;
            }
        }
        return number;
    }

    private void createSchedule(int shiftID, int roomID, String datework, int status) {
        Connection cnn = null;
        PreparedStatement pst = null;

//            String connectionURL = "jdbc:odbc:sem4";
//            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
//            cnn = DriverManager.getConnection(connectionURL, "lab", "");
        cnn = dbconnect.Connect();
        String sqlSchedule = "insert into tbl_schedule(shiftID,roomID,dateworkID,status) values(?,?,?,?) ";
        try {
            pst = cnn.prepareStatement(sqlSchedule);
            //pst = cnn.prepareStatement(sqlSchedule);
            pst.setInt(1, shiftID);
            pst.setInt(2, roomID);
            pst.setInt(3, dateWorkID(datework.trim()));
            pst.setInt(4, status);
            pst.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class
                    .getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                pst.close();
                cnn.close();

            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class
                        .getName()).log(Level.SEVERE, null, ex);
            }

        }

    }

    private int checkExitsDate(String date) {
        Connection cnn = dbconnect.Connect();
        Statement st = null;
        ResultSet rs = null;
        String sql = "select dateword from tbl_datework where dateword >='" + date + "'";
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            int cnt = 0;
            while (rs.next()) {
                cnt = cnt + 1;
            }
            return cnt;

        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class
                    .getName()).log(Level.SEVERE, null, ex);

            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();

            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int ScheduleNULLMax(int roomid) {
        Connection cnn = dbconnect.Connect();
        Statement st = null;
        ResultSet rs = null;
        String sql = "select TOP 1 s.scheduleID from tbl_schedule as "
                + "s  where roomID=" + roomid + " and s.status=2 order by s.scheduleID desc";
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("scheduleID");
            } else {
                return 0;

            }
        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class
                    .getName()).log(Level.SEVERE, null, ex);

            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();

            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int ScheduleNULLMin(int roomid) {
        Connection cnn = dbconnect.Connect();
        Statement st = null;
        ResultSet rs = null;
        String sql = "select TOP 1 s.scheduleID from tbl_schedule as s"
                + "  where roomID=" + roomid + " and s.status=2 order by s.scheduleID asc";
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("scheduleID");
            } else {
                return 0;

            }
        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class
                    .getName()).log(Level.SEVERE, null, ex);

            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();

            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private int dateWorkID(String date) {
        Connection cnn = dbconnect.Connect();
        Statement st = null;
        ResultSet rs = null;
        String sql = "select * from tbl_datework where dateword='" + date + "'";
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt("datewordID");
            } else {
                return 0;

            }
        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class
                    .getName()).log(Level.SEVERE, null, ex);

            return 0;
        } finally {
            try {
                rs.close();
                st.close();
                cnn.close();

            } catch (SQLException ex) {
                Logger.getLogger(createSchedule.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private String outPutEnddate(int roomID) {
        Connection cnn = dbconnect.Connect();
        Statement st = null;
        ResultSet rs = null;
        String sql = "select TOP 1 d.dateword  from tbl_schedule as s inner join "
                + "tbl_datework as d on s.dateworkID=d.datewordID  where roomID=" + roomID + " order by dateworkID desc";
        Date date = new Date();
        SimpleDateFormat fomarter = new SimpleDateFormat("yyyy/MM/dd");
        try {
            st = cnn.createStatement();
            rs = st.executeQuery(sql);
            if (rs.next()) {
                String outDate = fomarter.format(rs.getDate("dateword"));
                if (compareOutDate(outDate) == true) {
                    return outDate;
                } else {
                    return fomarter.format(date);
                }

            } else {
                return fomarter.format(date);

            }
        } catch (SQLException ex) {
            Logger.getLogger(createSchedule.class
                    .getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        }
    }

    private boolean compareOutDate(String date) {
        String[] outDate = date.split("/");
        int yearOutDate = Integer.parseInt(outDate[0].trim());
        int monthOut = Integer.parseInt(outDate[1].trim());
        int dayOut = Integer.parseInt(outDate[2].trim());
        SimpleDateFormat fomarter = new SimpleDateFormat("yyyy/MM/dd");
        String[] dateNow = fomarter.format(new Date()).split("/");
        int yearNow = Integer.parseInt(dateNow[0].trim());
        int monthNow = Integer.parseInt(dateNow[1].trim());
        int dayNow = Integer.parseInt(dateNow[2].trim());
        if (yearOutDate > yearNow) {
            return true;
        } else if (yearOutDate == yearNow) {
            if (monthOut > monthNow) {
                return true;
            } else if (monthOut == monthNow) {
                if (dayOut > dayNow) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
