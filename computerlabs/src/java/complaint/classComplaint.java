/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package complaint;

/**
 *
 * @author User
 */
public class classComplaint {
    private int complaintID;
    private String title;
    private String status;
    private String dateSend;
    private String userSend;
    private String userProcess;

    public String getUserSend() {
        return userSend;
    }

    public void setUserSend(String userSend) {
        this.userSend = userSend;
    }

    public String getUserProcess() {
        return userProcess;
    }

    public void setUserProcess(String userProcess) {
        this.userProcess = userProcess;
    }

   

    public int getComplaintID() {
        return complaintID;
    }

    public void setComplaintID(int complaintID) {
        this.complaintID = complaintID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDateSend() {
        return dateSend;
    }

    public void setDateSend(String dateSend) {
        this.dateSend = dateSend;
    }
    public classComplaint(int complaintID,String title,int status,String dateSend,String userSend,String userProcess){
        this.complaintID=complaintID;
        this.title=title;
        if(status==0){
            this.status="Process";
        }else if(status==1){
            this.status="Processing";
        }else{
            this.status="Processed";
        }
        this.dateSend=dateSend;
        this.userSend=userSend;
        this.userProcess=userProcess;
    }
}
