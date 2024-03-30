package helper;

import dao.collegedao;
import dao.studentdao;
import dao.teacherdao;
import entity.college;
import java.sql.*;
import entity.student;
import entity.teacher;
import java.io.*;
import javax.servlet.http.Part;

public class imageintration {

    public String addimage(Part part, String category) {

        try {

            if(category.equals("student")) {
                String imgname = part.getSubmittedFileName();
                if (imgname == "") {
                    imgname = "person.png";
                    return  imgname;
                } else {
                    InputStream fis = part.getInputStream();
                    byte[] b = new byte[fis.available()];
                    fis.read(b);

                    String path = "D://project-132//correct_college//web//userimg//" + imgname;

                    FileOutputStream fos = new FileOutputStream(path);
                    fos.write(b);
                    fos.close();
                    fis.close();
                    return imgname;
                }
            } else if (category.equals("teacher")) {
                String imgname = part.getSubmittedFileName();
                if (imgname =="") {
                    imgname = "person.png";
                    return imgname;
                } else {
                    InputStream fis = part.getInputStream();
                    byte[] b = new byte[fis.available()];
                    fis.read(b);

                    String path = "D://project-132//correct_college//web//userimg//" + imgname;

                    FileOutputStream fos = new FileOutputStream(path);
                    fos.write(b);
                    fos.flush();
                    fos.close();
                    fis.close();
                    return imgname;
                }
            } else if (category.equals("college")) {
                String imgname = part.getSubmittedFileName();
                if (imgname == null || imgname=="") {
                    imgname = "collegedefault.png";
                    return  imgname;
                } else {
                    InputStream fis = part.getInputStream();
                    byte[] b = new byte[fis.available()];
                    fis.read(b);

                    String path = "D://project-132//correct_college//web//userimg//" + imgname;

                    FileOutputStream fos = new FileOutputStream(path);
                    fos.write(b);
                    fos.close();
                    fis.close();
                }
            } else {
                String imgname = part.getSubmittedFileName();
                if (imgname == null) {
                    imgname = "person.png";
                } else {
                    InputStream fis = part.getInputStream();
                    byte[] b = new byte[fis.available()];
                    fis.read(b);

                    String path = "D://project-132//correct_college//web//userimg//" + imgname;

                    FileOutputStream fos = new FileOutputStream(path);
                    fos.write(b);
                    fos.close();
                    fis.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return " ";
    }

    public void updateimage(Part part, String category, int id) {
        Connection con = ConnectionProvider.getConnection();
        if (category.equals("student")) {
             
           studentdao cd = new studentdao(con);
            student col = cd.findstudent(id);
            String imgname=part.getSubmittedFileName();
        
            if (!imgname.equals("person.png")) {
     
                delete(col.getSimg(), "student");
               

            }
             try {
                    if(imgname=="")
                    {
                          
                        imgname="person.png";
                
                    }
                    else
                    {
                        
                        InputStream is = part.getInputStream();
                        byte []b=new byte[is.available()];
                        is.read(b);
                        
                        FileOutputStream fos = new FileOutputStream("D://project-132//correct_college//web//userimg//"+imgname);
                        fos.write(b);
                        fos.flush();
                        fos.close();
                        is.close();
                    }
                    String qtr = "update students set simg=? where sid=?";
                    PreparedStatement ps = con.prepareStatement(qtr);
                    ps.setString(1, imgname);
                    ps.setInt(2, id);
                    ps.execute();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            
            

        } else if (category.equals("teacher")) {
            
            teacherdao cd = new teacherdao(con);
            teacher col = cd.findteacher(id);
            String imgname=part.getSubmittedFileName();
        
            if (!imgname.equals("person.png")) {
     
                delete(col.getTimg(),"teacher");
               

            }
             try {
                    if(imgname=="")
                    {
                          
                        imgname="person.png";
                
                    }
                    else
                    {
                        
                        InputStream is = part.getInputStream();
                        byte []b=new byte[is.available()];
                        is.read(b);
                        
                        FileOutputStream fos = new FileOutputStream("D://project-132//correct_college//web//userimg//"+imgname);
                        fos.write(b);
                        fos.flush();
                        fos.close();
                        is.close();
                    }
                    String qtr = "update teachers set timg=? where tid=?";
                    PreparedStatement ps = con.prepareStatement(qtr);
                    ps.setString(1, imgname);
                    ps.setInt(2, id);
                    ps.execute();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            
            

        } else if (category.equals("college")) {
            collegedao cd = new collegedao(con);
            college col = cd.findcollege(id);
            String imgname=part.getSubmittedFileName();
        
            if (!(col.getCimg()).equals("collegedefault.png")) {
     
                delete(col.getCimg(), "college");
               

            }
             try {
                    if(imgname=="")
                    {
                          
                        imgname="collegedefault.png";
                
                    }
                    else
                    {
                        
                        InputStream is = part.getInputStream();
                        byte []b=new byte[is.available()];
                        is.read(b);
                        
                        FileOutputStream fos = new FileOutputStream("D://project-132//correct_college//web//userimg//"+imgname);
                        fos.write(b);
                        fos.flush();
                        fos.close();
                        is.close();
                    }
                    String qtr = "update colleges set cimg=? where cid=?";
                    PreparedStatement ps = con.prepareStatement(qtr);
                    ps.setString(1, imgname);
                    ps.setInt(2, id);
                    ps.execute();
                } catch (Exception e) {
                    e.printStackTrace();
                }
        } else {
            //visitor update img 
        }
    }

    public void delete(String imgname,String category) {
       
        if (category.equals("college")) {
            if (!imgname.equals("collegedefault.png")) {
                System.out.println("delete file name :"+imgname);
                File f;
                f = new File("D://project-132//correct_college//web//userimg//"+imgname);
                f.delete();
            }
        }
        else if(category.equals("student"))
        {
              if (!imgname.equals("person.png")) {
                System.out.println("delete file name :"+imgname);
                File f;
                f = new File("D://project-132//correct_college//web//userimg//"+imgname);
                f.delete();
            }
        }
               else if(category.equals("teacher"))
        {
              if (!imgname.equals("person.png")) {
                System.out.println("delete file name :"+imgname);
                File f;
                f = new File("D://project-132//correct_college//web//userimg//"+imgname);
                f.delete();
            }
        }
    }
}
