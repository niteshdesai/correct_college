
package entity;

public class visitor {
    private int vid;
    private String vname;
    private String vcity;
    private String vemail;
    private String vimg;
    private String mobile_no;

    public String getMobile_no() {
        return mobile_no;
    }

    public void setMobile_no(String mobile_no) {
        this.mobile_no = mobile_no;
    }
    public visitor() {
    }

    public int getVid() {
        return vid;
    }

    public void setVid(int vid) {
        this.vid = vid;
    }

    public String getVname() {
        return vname;
    }

    public void setVname(String vname) {
        this.vname = vname;
    }

    public String getVcity() {
        return vcity;
    }

    public void setVcity(String vcity) {
        this.vcity = vcity;
    }

    public String getVemail() {
        return vemail;
    }

    public void setVemail(String vemail) {
        this.vemail = vemail;
    }

    public String getVimg() {
        return vimg;
    }

    public void setVimg(String vimg) {
        this.vimg = vimg;
    }
  
    
}
