package dao;

import java.sql.*;
import entity.*;
import helper.ConnectionProvider;
import java.util.Vector;

public class studentdao {

    private Connection con;

    public studentdao(Connection con) {
        this.con = con;
    }

    public int addstudent(String sen_no, int sroll_no, String sname, int ssem, String ssection, String sgender, String mobile, String scity, String simg,String email, int cid,int c_id) {
        try {
            System.out.println("student add method sen_no :" + sen_no);
            String qtr = "select * from students where sen_no=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setString(1, sen_no);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return 0;
            }

            qtr = "insert into students(sen_no,sroll_no,sname,ssem,ssection,sgender,smobile,scity,simg,semail,cid,sc_id) values(?,?,?,?,?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(qtr);
            ps.setString(1, sen_no);
            ps.setInt(2, sroll_no);
            ps.setString(3, sname);
            ps.setInt(4, ssem);
            ps.setString(5, ssection);
            ps.setString(6, sgender);
            ps.setString(7, mobile);
            ps.setString(8, scity);
            ps.setString(9, simg);
             ps.setString(10, email);
            ps.setInt(11, cid);
            ps.setInt(12, c_id);
            ps.execute();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int updatestudent(int sid, String sen_no, int sroll_no, String sname, String scity, int ssem, String ssection, String sgender, String smobile) {
        try {

            String qtr = "update students set sen_no=?,sroll_no=?,sname=?,ssem=?,ssection=?,sgender=?,smobile=?,scity=? where sid=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setString(1, sen_no);
            ps.setInt(2, sroll_no);
            ps.setString(3, sname);
            ps.setInt(4, ssem);
            ps.setString(5, ssection);
            ps.setString(6, sgender);
            ps.setString(7, smobile);
            ps.setString(8, scity);

            ps.setInt(9, sid);
            ps.execute();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int deletestudent(int sid) {
        try {
            String qtr1 = "delete from coll_rating where sid=?";
            PreparedStatement ps = con.prepareStatement(qtr1);
            ps.setInt(1, sid);
            ps.execute();
            String qtr2 = "delete from tech_rating where sid=?";
            ps = con.prepareStatement(qtr2);
            ps.setInt(1, sid);
            ps.execute();
            String qtr = "delete from students where sid=?";
            ps = con.prepareStatement(qtr);
            ps.setInt(1, sid);
            ps.execute();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

   public student loginstudent(String sen_no, int ssem, int cid,String email) {
         student st = new student();
        try {
            String qtr = "select * from students where sen_no=? and ssem=? and cid=? and semail=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setString(1, sen_no);
            ps.setInt(2, ssem);
            ps.setInt(3, cid);
            ps.setString(4, email);
            ResultSet rs = ps.executeQuery();

           
            if (rs.next()) {
                st.setSid(rs.getInt("sid"));
                st.setSen_no(rs.getString("sen_no"));
                st.setSroll_no(rs.getInt("sroll_no"));
                st.setSname(rs.getString("sname"));
                st.setSsem(rs.getInt("ssem"));
                st.setSsection(rs.getString("ssection"));
                st.setSgender(rs.getString("sgender"));
                st.setSmobile(rs.getString("smobile"));
                st.setScity(rs.getString("scity"));
                st.setSimg(rs.getString("simg"));
                st.setCid(rs.getInt("cid"));
                st.setSemail(rs.getString("semail"));
                return st;

            } else {
               st=null;
               return  st;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        st=null;
        return st;
    }

    public student findstudent(int sid) {
        student st = new student();
        try {
            String qtr = "select * from students where sid=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, sid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                st.setSid(rs.getInt("sid"));
                st.setSen_no(rs.getString("sen_no"));
                st.setSroll_no(rs.getInt("sroll_no"));
                st.setSname(rs.getString("sname"));
                st.setSsem(rs.getInt("ssem"));
                st.setSsection(rs.getString("ssection"));
                st.setSgender(rs.getString("sgender"));
                st.setSmobile(rs.getString("smobile"));
                st.setScity(rs.getString("scity"));
                st.setSimg(rs.getString("simg"));
                st.setCid(rs.getInt("cid"));
                st.setSc_id(rs.getInt("sc_id"));
            }
            return st;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return st;
    }

    //getsemstudent method is called in collegeadmin to get student
    public Vector<student> getsemstudent(int cid, int sem) {
        Vector<student> vc = new Vector();
        try {

            String qtr = "select * from students where cid=? and ssem=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, cid);
            ps.setInt(2, sem);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                student st = new student();
                st.setSid(rs.getInt("sid"));
                st.setSen_no(rs.getString("sen_no"));
                st.setSroll_no(rs.getInt("sroll_no"));
                st.setSname(rs.getString("sname"));
                st.setSsem(rs.getInt("ssem"));
                st.setSsection(rs.getString("ssection"));
                st.setSgender(rs.getString("sgender"));
                st.setSmobile(rs.getString("smobile"));
                st.setScity(rs.getString("scity"));
                st.setSemail(rs.getString("semail"));
                st.setSimg(rs.getString("simg"));
                st.setCid(rs.getInt("cid"));
                vc.add(st);
            }
            return vc;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vc;
    }
    
    //get teacher where student is rated
   public Vector<teacher> getratedteacher(int sid)
   {
      Vector<teacher> vc = new Vector();
       try {
           String qtr = "select tid from tech_rating where sid=?";
           PreparedStatement ps = con.prepareStatement(qtr);
           ps.setInt(1, sid);
           ResultSet rs = ps.executeQuery();
           teacherdao td = new teacherdao(ConnectionProvider.getConnection());
           while(rs.next())
           {
              
              teacher tech = td.findteacher(rs.getInt(1));
              vc.add(tech);
           }
           return vc;
       } catch (Exception e) {
        e.printStackTrace();
       }
       return vc;
   }
   
   public int countStudent(int cid)
   {
       try {
           String qtr = "select count(*) from students where cid=?";
           PreparedStatement ps = con.prepareStatement(qtr);
           ps.setInt(1, cid);
           ResultSet rs= ps.executeQuery();
           rs.next();
           return rs.getInt(1);
       } catch (Exception e) {
           e.printStackTrace();
       }
       return 0;
   }
   public int countReview(int cid)
   {
       try {
           String qtr = "select count(*) from comments where cid=?";
               PreparedStatement ps = con.prepareStatement(qtr);
           ps.setInt(1, cid);
           ResultSet rs= ps.executeQuery();
           rs.next();
           return rs.getInt(1);
       } catch (Exception e) {
           e.printStackTrace();
       }
       return 0;
   }
   
   public int countCourse(int cid)
   {
       try {
           String qtr = "select count(*) from course where cid=?";
                   PreparedStatement ps = con.prepareStatement(qtr);
           ps.setInt(1, cid);
           ResultSet rs= ps.executeQuery();
           rs.next();
           return rs.getInt(1);
       } catch (Exception e) {
           e.printStackTrace();
       }
       return 0;
   }
   
}
