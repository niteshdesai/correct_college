package dao;

import com.mysql.cj.xdevapi.PreparableStatement;
import java.sql.*;
import entity.*;
import java.util.Vector;

public class collegedao {

    private Connection con;

    public collegedao(Connection con) {
        this.con = con;
    }

    public int addcollege(String cname, String cdesc, String cactivity, String cimg, String email,String caddress, String timg,String username, String password,String cd_email) {
        try {
                    String q="insert into colleges(cname,cdesc,cactivity,cimg,email,address)values(?,?,?,?,?,?)";
                     PreparedStatement ps=con.prepareStatement(q);

                      ps.setString(1,cname);
                      ps.setString(2,cdesc);
                      ps.setString(3,cactivity);
                  
                      ps.setString(4,timg);
                      ps.setString(5,email);
                      ps.setString(6, caddress);
                      ps.executeUpdate();

                      q="select cid from colleges where cname='"+cname+"'";
                     Statement st=con.createStatement();
                     ResultSet rs=st.executeQuery(q);

                      rs.next();

                      q="insert into college_admin(username,password,email,image,cid)values(?,?,?,?,?)";
                      ps=con.prepareStatement(q);

                      ps.setString(1,username);
                      ps.setString(2,password);
                      ps.setString(3, cd_email);
                      ps.setString(4, "person.png");
                      ps.setInt(5,rs.getInt("cid"));
                      ps.execute();
              
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;

    }

    public boolean updatecollege(String cname, String cdesc, String cactivity, String course,String caddress,int cid) {
        try {
           
            String qtr = "update colleges set cname=?,cdesc=?,cactivity=?,address=? where cid=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setString(1, cname);
            ps.setString(2, cdesc);
            ps.setString(3, cactivity);
    

            ps.setString(4, caddress);
            ps.setInt(5, cid);
            ps.execute();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Vector<college> getColleges() {
        Vector<college> vc = new Vector();
        try {
            String qtr = "select * from colleges";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qtr);
            while (rs.next()) {
                college col = new college();
                col.setCid(rs.getInt("cid"));
                col.setCname(rs.getString("cname"));
                col.setCdesc(rs.getString("cdesc"));
                col.setCactivity(rs.getString("cactivity"));
            
                col.setCimg(rs.getString("cimg"));
                col.setEmail(rs.getString("email"));
                col.setAddress(rs.getString("address"));
                vc.add(col);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vc;
    }

    public college findcollege(int cid)
    {
        college col = new college();
        try
        {
        String qtr ="select * from colleges where cid = ?";
        PreparedStatement ps  = con.prepareStatement(qtr);
        ps.setInt(1, cid);
        ResultSet rs = ps.executeQuery();
        if(rs.next())
        {
        col.setCid(rs.getInt("cid"));
        col.setCname(rs.getString("cname"));
        col.setCdesc(rs.getString("cdesc"));
        col.setCactivity(rs.getString("cactivity"));
        col.setAddress(rs.getString("address"));
        col.setCimg(rs.getString("cimg"));
        col.setEmail(rs.getString("email"));
        return col;
        }
        
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return col;
    }
    public Vector<course> getcourse(int cid)
    {
        Vector<course> vc = new Vector();
        try {
              String qtr = "select *  from course where cid=?";
              PreparedStatement ps = con.prepareStatement(qtr);
              ps.setInt(1, cid);
              ResultSet rs = ps.executeQuery();
              while(rs.next())
              {
                course cr = new course();
                cr.setC_id(rs.getInt("c_id"));
                cr.setC_name(rs.getString("c_name"));
                cr.setC_duration(rs.getInt("c_duration"));
                cr.setC_since(rs.getInt("c_since"));
                vc.add(cr);
              }
              return vc;
        } catch (Exception e) {
            e.printStackTrace();
        }
      return vc;
        
    }
    public boolean addcourse(String c_name,int c_duration,int c_since,int cid)
    {
        try {
            String qtr1 = "select * from course where c_name='"+c_name+"' and cid="+cid+" ";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(qtr1);
            if(rs.next())
            {
                return false;
            }
                    
            String qtr = "insert into course(c_name,c_duration,c_since,cid) values(?,?,?,?)";
            PreparedStatement ps =con.prepareStatement(qtr);
            ps.setString(1,c_name);
            ps.setInt(2,c_duration);
             ps.setInt(3,c_since);
              ps.setInt(4,cid);
              ps.execute();
              return true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
  return  true;
        
    }
}
