package dao;

import entity.com_reply;
import entity.comment;
import helper.ConnectionProvider;
import java.sql.*;

import java.util.Vector;

public class commentdao {

    private Connection con = null;

    public commentdao(Connection con) {
        this.con = con;
    }

    public void addcomment(int cid, int id, String com_val, String category) {
        if (category.equals("student")) {
            try {
                String qtr = "insert into comments(comment,sid,cid,vid) values(?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(qtr);
                ps.setString(1, com_val);
                ps.setInt(2, id);
                ps.setInt(3, cid);
                ps.setInt(4, 0);
                ps.execute();
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else {
      try {
                String qtr = "insert into comments(comment,sid,cid,vid) values(?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(qtr);
                ps.setString(1, com_val);
                ps.setInt(2, 0);
                ps.setInt(3, cid);
                ps.setInt(4, id);
                ps.execute();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public Vector<comment> getcomment(int cid) {
        Vector<comment> vc = new Vector();
        try {
            Connection con = ConnectionProvider.getConnection();

            String qtr = "select * from comments where cid=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                comment com = new comment();
                com.setCom_id(rs.getInt("com_id"));
                com.setComment(rs.getString("comment"));
                com.setCid(rs.getInt("cid"));
                com.setSid(rs.getInt("sid"));
                com.setVid(rs.getInt("vid"));
                vc.add(com);
            }
            return vc;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vc;

    }
    
       public Vector<comment> getstudentcomment(int sid) {
        Vector<comment> vc = new Vector();
        try {
            Connection con = ConnectionProvider.getConnection();

            String qtr = "select * from comments where sid=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, sid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                comment com = new comment();
                com.setCom_id(rs.getInt("com_id"));
                com.setComment(rs.getString("comment"));
                com.setCid(rs.getInt("cid"));
                com.setSid(rs.getInt("sid"));
                com.setVid(rs.getInt("vid"));
                vc.add(com);
            }
            return vc;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vc;

    }
    
   public Vector<comment> getvisitorcomment(int vid) {
        Vector<comment> vc = new Vector();
        try {
            Connection con = ConnectionProvider.getConnection();

            String qtr = "select * from comments where vid=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, vid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                comment com = new comment();
                com.setCom_id(rs.getInt("com_id"));
                com.setComment(rs.getString("comment"));
                com.setCid(rs.getInt("cid"));
                com.setSid(rs.getInt("sid"));
                com.setVid(rs.getInt("vid"));
                vc.add(com);
            }
            return vc;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vc;

    }
    public void com_reply(int com_id, int id, String category, int like, int dislike) {
        try {
            if (category.equals("student")) {

                String qtr = "select * from com_reply where com_id=? and sid=?";
                PreparedStatement ps = con.prepareStatement(qtr);
                ps.setInt(1, com_id);
                ps.setInt(2, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    System.out.println("update com_reply is call");
                    update_com_reply(com_id, id, "sid", like, dislike);
                } else {
                    System.out.println("isnert com reply is call");
                    insert_com_reply(com_id, id, "sid", like, dislike);
                }
            }
            if (category.equals("visitor")) {

                String qtr = "select * from com_reply where com_id=? and vid=?";
                PreparedStatement ps = con.prepareStatement(qtr);
                ps.setInt(1, com_id);
                ps.setInt(2, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    System.out.println("update com_reply is call");
                    update_com_reply(com_id, id, "vid", like, dislike);
                } else {
                    System.out.println("isnert com reply is call");
                    insert_com_reply(com_id, id, "vid", like, dislike);
                }
            }
            if (category.equals("collegeadmin")) {

                String qtr = "select * from com_reply where com_id=? and cid=?";
                PreparedStatement ps = con.prepareStatement(qtr);
                ps.setInt(1, com_id);
                ps.setInt(2, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    System.out.println("update com_reply is call");
                    update_com_reply(com_id, id, "cid", like, dislike);
                } else {
                    System.out.println("isnert com reply is call");
                    insert_com_reply(com_id, id, "cid", like, dislike);
                }
            }
            if (category.equals("admin")) {

                String qtr = "select * from com_reply where com_id=? and aid=?";
                PreparedStatement ps = con.prepareStatement(qtr);
                ps.setInt(1, com_id);
                ps.setInt(2, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    System.out.println("update com_reply is call");
                    update_com_reply(com_id, id, "aid", like, dislike);
                } else {
                    System.out.println("isnert com reply is call");
                    insert_com_reply(com_id, id, "aid", like, dislike);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void insert_com_reply(int com_id, int id, String category, int like, int dilike) {
        try {
            System.out.println("id in insert_com_repy : "+id);
            String qtr = "insert into com_reply(com_like,com_dlike,com_id," + category + ") values(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(qtr);

            ps.setInt(1, like);
            ps.setInt(2, dilike);
            ps.setInt(3, com_id);
            ps.setInt(4, id);
            ps.execute();
        } catch (Exception e) {

            e.printStackTrace();

        }
    }

    public void update_com_reply(int com_id, int id, String category, int like, int dislike) {
        try {
            String qtr = "update com_reply set com_like=?,com_dlike=? where com_id=? and " + category + " = ?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, like);
            ps.setInt(2, dislike);
            ps.setInt(3, com_id);

            ps.setInt(4, id);
            ps.execute();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Vector<com_reply> getcom_reply(int com_id) {
        Vector<com_reply> cr1 = new Vector();
        try {
            String qtr = "select * from com_reply where com_id=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, com_id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                com_reply cr = new com_reply();
                cr.setCr_id(rs.getInt("cr_id"));
                cr.setCom_like(rs.getInt("com_like"));
                cr.setCom_dlike(rs.getInt("com_dlike"));
                cr.setCom_id(rs.getInt("com_id"));
                cr.setSid(rs.getInt("sid"));
                cr.setVid(rs.getInt("vid"));
                cr.setCid(rs.getInt("cid"));
                cr.setAid(rs.getInt("aid"));
                cr1.add(cr);
            }
            return cr1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cr1;
    }

    public int countdislike(int com_id) {
        try {
            String qtr = "select sum(com_dlike) from com_reply where com_id=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, com_id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countlike(int com_id) {
        try {
            String qtr = "select sum(com_like) from com_reply where com_id=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, com_id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    public void del_comment(int com_id)
    {
        try {
            String qtr= "delete from comments where com_id=?";
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, com_id);
            ps.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
