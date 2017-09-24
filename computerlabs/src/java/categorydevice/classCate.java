/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package categorydevice;

/**
 *
 * @author User
 */
public class classCate {
    private int cateID;
    private String cateName;
    private int status;

    public int getCateID() {
        return cateID;
    }

    public void setCateID(int cateID) {
        this.cateID = cateID;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
     public classCate(int cateID,String cateName,int status) {  
         this.cateID=cateID;
         this.cateName=cateName;
         this.status=status;
    }  

}
