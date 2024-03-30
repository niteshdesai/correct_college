
package entity;


public class college {
    private int cid;
    private String cname;
    private String cdesc;
    private String cactivity;
    private String email;
    private String address;

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    private course cou = new course();
    private String cimg;

    public college() {
    }

    public int getCid() {
        return cid;
    }
    
    public course getCoure()
    {
        return cou;
    }
    
    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getCdesc() {
        return cdesc;
    }

    public void setCdesc(String cdesc) {
        this.cdesc = cdesc;
    }

    public String getCactivity() {
        return cactivity;
    }

    public void setCactivity(String cactivity) {
        this.cactivity = cactivity;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

//    public String getCourse() {
//        return course;
//    }
//
//    public void setCourse(String course) {
//        this.course = course;
//    }

    public String getCimg() {
        return cimg;
    }

    public void setCimg(String cimg) {
        this.cimg = cimg;
    }
    
    
}
