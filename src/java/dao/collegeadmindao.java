
package dao;
import com.mysql.cj.xdevapi.Result;
import java.sql.*;
import entity.*;
public class collegeadmindao {
    
    private Connection con=null;

    public collegeadmindao(Connection con) {
        this.con= con;
    }

    public collegeadmin login(String email,String password)
    {
        collegeadmin cd = new collegeadmin();
        try {
                   String qtr = "select * from college_admin where email=? and password=? ";
                   PreparedStatement ps= con.prepareStatement(qtr);
                   ps.setString(1,email);
                   ps.setString(2,password);
                   ResultSet rs = ps.executeQuery();
                   if(rs.next())
                   {
                       cd.setCa_id(rs.getInt("ca_id"));
                       cd.setUsername(rs.getString("username"));
                       cd.setPassword(rs.getString("password"));
                       cd.setCid(rs.getInt("cid"));
                       cd.setEmail(rs.getString("email"));
                       cd.setImage(rs.getString("image"));
                       return cd;
                   }
                   cd=null;
                   return cd;
         
        } catch (Exception e) {
            e.printStackTrace();
        }
       return cd;
    }
    

    
    
    
}
