
package dao;
import entity.student;
import java.sql.*;
import java.util.Vector;
import entity.teacher;

public class teacherdao {
    private Connection con;

    public teacherdao(Connection con) {
        this.con = con;
    }
    
    public int addteacher(String tname,int tsem,String tsection,String tsubject,String timg,int cid,int c_id)
    {
        try {
          
            
            String qtr = "insert into teachers(tname,tsem,tsection,tsubject,timg,cid,c_id) values(?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setString(1, tname);
            ps.setInt(2,tsem);
            ps.setString(3, tsection);
            ps.setString(4, tsubject);
            ps.setString(5, timg);
            ps.setInt(6, cid);
            ps.setInt(7, c_id);

            ps.execute();
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
      public int updateteacher(String tname,int tsem,String tsection,String tsubject,int tid,int c_id)
    {
        try
        {
          
            
           String qtr1="update teachers set tname=?,tsem=?,tsection=?,tsubject=?,c_id=? where tid=?";
           PreparedStatement ps = con.prepareStatement(qtr1);
           ps.setString(1, tname);
           ps.setInt(2, tsem);
           ps.setString(3, tsection);
           ps.setString( 4, tsubject);
    
           ps.setInt(5, c_id);
          
           ps.setInt(6, tid);
           ps.execute();
           return 1;
           
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return 0;
    }
      
    public int deleteteacher(int tid)
    {
        try
        {
        String qtr1 ="delete from tech_rating where tid=?";
        PreparedStatement ps1= con.prepareStatement(qtr1);
        ps1.setInt(1,tid);
        ps1.execute();
        String qtr = "delete from teachers where tid=?";
        PreparedStatement ps = con.prepareStatement(qtr);
        ps.setInt(1, tid);
        ps.execute();
        return 1;
        }
        catch(Exception e)
        {
         e.printStackTrace();
        }
        return 0;
    }
   
    //findteacher is used in when click on edit button in collegeadmin page show info
    public teacher findteacher(int tid)
    {
        teacher st= new teacher();
       try {
           String qtr = "select * from teachers where tid=?";
           PreparedStatement ps = con.prepareStatement(qtr);
           ps.setInt(1, tid);
           ResultSet rs = ps.executeQuery();
           while(rs.next())
           {
             st.setTid(rs.getInt("tid"));
             st.setTname(rs.getString("tname"));
             st.setTsem(rs.getInt("tsem"));
             st.setTsubject(rs.getString("tsection"));
             st.setTsection(rs.getString("tsubject"));
             st.setTimg(rs.getString("timg"));
             st.setCid(rs.getInt("cid"));
             st.setC_id(rs.getInt("c_id"));
           }
           return st;
       } catch (Exception e) {
         e.printStackTrace();
       }
       return st;
    }
   
    public Vector<teacher> getteachers(int cid,String course_name)
    {
 
        
        Vector<teacher> vc = new Vector();
        try {
            int c_id;
                   String qtr1 = "select c_id from course where cid=? and c_name=?";
        PreparedStatement ps1 = con.prepareStatement(qtr1);
        ps1.setInt(1, cid);
        ps1.setString(2, course_name);
        ResultSet rs1 = ps1.executeQuery();
        rs1.next();
        c_id=rs1.getInt(1);
        
            
            String qtr = "select * from teachers where cid=? and c_id=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, cid);
            ps.setInt(2, c_id);
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                teacher t = new teacher();
                t.setTid(rs.getInt("tid"));
                t.setTname(rs.getString("tname"));
                t.setTsem(rs.getInt("tsem"));
                t.setTsection(rs.getString("tsection"));
                t.setTsubject(rs.getString("tsubject"));
                t.setTimg(rs.getString("timg"));
                t.setCid(rs.getInt("cid"));
                vc.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vc;
    }
    
    //getsemteacher method is called in collegeadmin to get teacher
    
    public Vector<teacher> getsemteachers(int cid,int sem)
    {
        Vector<teacher> vc = new Vector();
        try {
        
            String qtr = "select * from teachers where cid=? and tsem=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1,cid);
            ps.setInt(2, sem);
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                teacher t = new teacher();
                t.setTid(rs.getInt("tid"));
                t.setTname(rs.getString("tname"));
            
                t.setTsem(rs.getInt("tsem"));
                t.setTsection(rs.getString("tsection"));
                t.setTsubject(rs.getString("tsubject"));
                t.setTimg(rs.getString("timg"));
                t.setCid(rs.getInt("cid"));
                vc.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vc;
    }
    
    
}
