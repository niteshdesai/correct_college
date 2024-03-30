
package entity;

public class teacher {
    private int tid;
    private String  tname;
    private int  tsem;
    private String tsection;
    private String tsubject;
    private String timg;
    private int cid;
    private int c_id;

    public int getC_id() {
        return c_id;
    }

    public void setC_id(int c_id) {
        this.c_id = c_id;
    }
    

    public teacher() {
    }

    public int getTid() {
        return tid;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public int getTsem() {
        return tsem;
    }

    public void setTsem(int tsem) {
        this.tsem = tsem;
    }

    public String getTsection() {
        return tsection;
    }

    public void setTsection(String tsection) {
        this.tsection = tsection;
    }

    public String getTsubject() {
        return tsubject;
    }

    public void setTsubject(String tsubject) {
        this.tsubject = tsubject;
    }

    public String getTimg() {
        return timg;
    }

    public void setTimg(String timg) {
        this.timg = timg;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }
    
    
}
