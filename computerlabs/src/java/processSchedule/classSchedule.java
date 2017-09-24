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
public class classSchedule {
    private String id;  
    private String shiftname;  
    private String roomName;  
    private String dateword;
    private String keyword;
    private int dateworkID;

    public int getDateworkID() {
        return dateworkID;
    }

    public void setDateworkID(int dateworkID) {
        this.dateworkID = dateworkID;
    }
    private String status;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getShiftname() {
        return shiftname;
    }

    public void setShiftname(String shiftname) {
        this.shiftname = shiftname;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getDateword() {
        return dateword;
    }

    public void setDateword(String dateword) {
        this.dateword = dateword;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   
     public classSchedule(String id,String shiftname, String roomName, String dateword,  
            String keyword,String status,int dateworkID) {  
         this.id=id;
         this.shiftname=shiftname;
         this.roomName=roomName;
         this.dateword=dateword;
         this.keyword=keyword;
         this.status=status;
         this.dateworkID=dateworkID;
    }  
}
