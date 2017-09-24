/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package computerlabs;

import java.io.Serializable;

/**
 *
 * @author ABC
 */
public class classUser implements Serializable {  
    private int id;  
    private String username;  
    private String fullname;  
    private String gender;
    private String birthday;
    private String status;  
    private String departmentID;  
    private String HOD;  

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDepartmentID() {
        return departmentID;
    }

    public void setDepartmentID(String departmentID) {
        this.departmentID = departmentID;
    }

    public String getHOD() {
        return HOD;
    }

    public void setHOD(String HOD) {
        this.HOD = HOD;
    }

    
  
    public classUser(int id,String username, String fullname, int gender,  
            String birthday,int status,int departmentID,int HOD) {  
         this.id=id;
            this.username=username;
            this.fullname=fullname;         
            this.birthday=birthday;
            if(gender==1){
                this.gender="Female";
            }
            else{
                this.gender="Male";
            }
            if(status==1){
                this.status="UnLock";
            }
            else{
                this.status="Lock";
            }
            if(departmentID==2){
                this.departmentID="Instructors";
            }
            else if(departmentID==3){
                this.departmentID="Technical Staff";
            }else if(departmentID==4){
                this.departmentID="Students";
            }
            else if(departmentID==1){
                this.departmentID="Admin";
            }
            if(HOD==1){
                this.HOD="HOD";
            }
            else{
                this.HOD="---";
            }
    }  

}
