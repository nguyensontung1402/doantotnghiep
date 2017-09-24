/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package typeaccess;

/**
 *
 * @author User
 */
public class classTypeAccess {
    int typeID;
    String typeName;
    int status;

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
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
     public classTypeAccess(int typeID,String typeName,int status) {  
         this.typeID=typeID;
         this.typeName=typeName;
         this.status=status;
    } 
}
