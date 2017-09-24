/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package accessory;

/**
 *
 * @author User
 */
public class classAccess {
    private int accessID;
    private String accessName;
    private String typeName;
    private int status;

    public int getAccessID() {
        return accessID;
    }

    public void setAccessID(int accessID) {
        this.accessID = accessID;
    }

    public String getAccessName() {
        return accessName;
    }

    public void setAccessName(String accessName) {
        this.accessName = accessName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    public classAccess(int accessID,String accessName,String typeName,int status){
        this.accessID=accessID;
        this.accessName=accessName;
        this.typeName=typeName;
        this.status=status;
    }
}
