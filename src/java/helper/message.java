
package helper;

public class message {
   private String msg;
   private String status;

    public message() {
    }

    public message(String msg, String status) {
        this.msg = msg;
        this.status = status;
    }
    
    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
