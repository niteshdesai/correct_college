
package dao;
import entity.admin;
import java.sql.*;

public class admindao {
    
   private  Connection con;

    public admindao(Connection con) {
        this.con = con;
    }
   
    public admin loginadmin(String email,String password)
    {
        admin ad = new admin();
        try {
            String qtr = "select * from admin where email=? and password=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setString(1,email);
            ps.setString(2, password);
            ResultSet rs= ps.executeQuery();
            if(rs.next())
            {
                System.out.println("usernaem in admindao class : "+rs.getString("username"));
                ad.setAid(rs.getInt("aid"));
                ad.setUsername(rs.getString("username"));
                ad.setPassword(rs.getString("password"));
                ad.setImage(rs.getString("image"));
                ad.setEmail_id(rs.getString("email"));
                    return ad;
            }
        ad=null;
        return ad;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        ad=null;
        return ad;
    }
    
    public int countColleges()
    {
        try {
               String qtr = "select count(*) from colleges";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(qtr);
        rs.next();
        return rs.getInt(1); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    
    }
       public int countcontact()
    {
        try {
               String qtr = "select count(*) from contact";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(qtr);
        rs.next();
        return rs.getInt(1); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    
    }
    
    public int countStudent()
    {
          try {
               String qtr = "select count(*) from students";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(qtr);
        rs.next();
        return rs.getInt(1); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
       public int contVistor()
    {
          try {
               String qtr = "select count(*) from visitor_reg";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(qtr);
        rs.next();
        return rs.getInt(1); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
