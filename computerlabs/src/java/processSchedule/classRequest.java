/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package processSchedule;

/**
 *
 * @author User
 */
public class classRequest {
    private String username;  
    private String className;  
    private String courseName;  
    private String sendDate;
    private String roomName;
    private String sName;
    private String startendtime;
    private String dateword;
    private String fullname;
    private String status;
    private int cnt;
     private int reqID;

    public int getReqID() {
        return reqID;
    }

    public void setReqID(int reqID) {
        this.reqID = reqID;
    }

    public int getCnt() {
        return cnt;
    }

    public void setCnt(int cnt) {
        this.cnt = cnt;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getSendDate() {
        return sendDate;
    }

    public void setSendDate(String sendDate) {
        this.sendDate = sendDate;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }

    public String getStartendtime() {
        return startendtime;
    }

    public void setStartendtime(String startendtime) {
        this.startendtime = startendtime;
    }

    public String getDateword() {
        return dateword;
    }

    public void setDateword(String dateword) {
        this.dateword = dateword;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
     public classRequest(String username,String className, String courseName, String sendDate,  
          String roomName,String sName,String startendtime,String datework,String fullname,String restatus,int cnt,int reqID ) {  
         this.username=username;
         this.className=className;
         this.courseName=courseName;
         this.sendDate=sendDate;
         this.roomName=roomName;
         this.startendtime=startendtime;
         this.dateword=datework;
         this.fullname=fullname;
         this.status=restatus;
         this.cnt=cnt;
         this.sName=sName;
         this.reqID=reqID;
    }  
}
