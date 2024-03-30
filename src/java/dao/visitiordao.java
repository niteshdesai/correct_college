
package dao;
import entity.visitor;
import helper.ConnectionProvider;
import java.sql.*;

public class visitiordao {
    
        private Connection con;

    public visitiordao(Connection con) {
        this.con = con;
    }
  
   public visitor loginvisitor(String email,String password)
   {
       visitor vs =new visitor();
       try {
                 String qtr = "select * from visitor_reg where vemail=? and vpassword=?";
                 Connection con = ConnectionProvider.getConnection();
                 PreparedStatement ps = con.prepareStatement(qtr);
                 ps.setString(1, email);
                 ps.setString(2, password);
                 ResultSet rs = ps.executeQuery();
                 if(rs.next())
                 {
                  vs.setVid(rs.getInt("vid"));
                  vs.setVname(rs.getString("vname"));
                  vs.setVcity(rs.getString("vcity"));
                  vs.setVemail(rs.getString("vemail"));
                  vs.setVimg(rs.getString("vimg"));
                  vs.setMobile_no(rs.getString("vmobile"));
                        return vs;
                 }
           
                 
       } catch (Exception e) {
           e.printStackTrace();
       }
       vs=null;
       return vs;
       
   }
    
   public void insertvisitor(String name,String email,String password ,String city,String img,String vans,String mobile)
   {
       try {
                  
                  String qtr = "insert into visitor_reg(vname,vcity,vemail,vpassword,vimg,vans,vmobile) values(?,?,?,?,?,?,?)";
                  Connection con = ConnectionProvider.getConnection();
                  PreparedStatement ps = con.prepareStatement(qtr);
                  System.out.println("insertt visitor here right");
                  ps.setString(1, name);
                  ps.setString(2, city);
                  ps.setString(3,email);
                  ps.setString(4, password);
                  ps.setString(5, img);
                  ps.setString(6, vans);
                  ps.setString(7, mobile);
                  ps.execute();
       } catch (Exception e) {
           e.printStackTrace();
       }

       
   }
    
    public visitor findvisitor(int vid)
    {
        visitor vs = new visitor();
        try {
               String qtr = "select * from visitor_reg where vid = ?";
         PreparedStatement ps = con.prepareStatement(qtr);
         ps.setInt(1, vid);
         ResultSet rs = ps.executeQuery();
         while(rs.next())
         {
             vs.setVid(rs.getInt("vid"));
             vs.setVname(rs.getString("vname"));
             vs.setVemail(rs.getString("vemail"));
             vs.setVcity(rs.getString("vcity"));
             vs.setVimg(rs.getString("vimg"));
             
         } 
         return vs;
        } catch (Exception e) {
            e.printStackTrace();
        }
       
        return vs;
     
    }
   public int forgetpassword(String email,String tech_name,String new_pass)
   {
       try {
           String qtr = "select * from visitor_reg where vemail=? and vans=?";
           PreparedStatement ps = con.prepareStatement(qtr);
           ps.setString(1, email);
           ps.setString(2, tech_name);
           ResultSet rs = ps.executeQuery();
           if(rs.next())
           {
              qtr="update visitor_reg set vpassword=? where vemail=?";
              ps=con.prepareStatement(qtr);
              ps.setString(1,new_pass);
              ps.setString(2, email);
              ps.execute();
              return 1;
           }
           else
           {
               return 0;
           }
           
       } catch (Exception e) {
           e.printStackTrace();
       }
       return 0;
   }
}
