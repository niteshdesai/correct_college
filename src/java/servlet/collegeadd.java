/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import dao.collegedao;
import helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.*;
import helper.imageintration;
import helper.message;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@WebServlet(urlPatterns = {"/collegeadd"})
@MultipartConfig
public class collegeadd extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession ss=request.getSession();
            String cname=request.getParameter("cname");
            String cdesc=request.getParameter("cdesc");
            String cactivity=request.getParameter("cactivity");
            String username=request.getParameter("username");
            String password=request.getParameter("password");
            String course=request.getParameter("course");
            String email=request.getParameter("email");
            String caddress = request.getParameter("caddress");
            String cimg=request.getParameter("cimg");
            String cd_email = request.getParameter("cd_email");
            String timg=null;
            Connection con=ConnectionProvider.getConnection();
           collegedao cd=new collegedao(con);
            System.out.println("college name:"+cname);
           String qtr="select*from colleges where cname='"+cname+"'";
           Statement st=con.createStatement();
           ResultSet rst=st.executeQuery(qtr);
           
           if(rst.next())
           {
               message mg=new message();
               
               mg.setMsg("add college  is already available");
               ss.setAttribute("collegeadd", mg);
               response.sendRedirect("./newadmin.jsp");
           }
           else
           {
               
               
                   
               
               qtr="select*from college_admin where email='"+cd_email+"'";
               
               Statement std=con.createStatement();
               ResultSet rs=std.executeQuery(qtr);
               
                        qtr="select*from college_admin where username='"+username+"'";
               
              std=con.createStatement();
               ResultSet rs1=std.executeQuery(qtr);
               
                
                        qtr="select*from colleges where email='"+email+"'";
               
              std=con.createStatement();
               ResultSet rs2=std.executeQuery(qtr);
               if(rs.next())
               {
                   message mg=new message();
                   mg.setMsg("add collegeAdomin email_id is already exits");
                   ss.setAttribute("username_collegeadmin",mg);
                   response.sendRedirect("./newadmin.jsp");
               }
               else if(rs1.next())
               {
                    message mg=new message();
                   mg.setMsg("add collegeadmin username is already exits");
                   ss.setAttribute("username_collegeadmin",mg);
                   response.sendRedirect("./newadmin.jsp"); 
               }
               else if(rs2.next())
               {  message mg=new message();
                      mg.setMsg("add college_email id is already exits");
                   ss.setAttribute("username_collegeadmin",mg);
                   response.sendRedirect("./newadmin.jsp");   
               }
               else
               {
                           Part pimg8=request.getPart("cimg");
                timg=pimg8.getSubmittedFileName();
               imageintration img=new imageintration();
               System.out.println("college  add servlet : "+timg);
               if(timg.equals(""))
               {
                   System.out.println("timg is college add servelr set default img");
                   timg="collegedefault.png";
               }
                     
               collegedao cd1 = new collegedao(ConnectionProvider.getConnection());
               cd1.addcollege(cname, cdesc, cactivity, cimg, email, caddress, timg, username, password,cd_email);
               
               img.addimage(pimg8, "college");
                      response.sendRedirect("./newadmin.jsp");
               }
               
               
               }    
               
        }
               
           
            
         catch (SQLException ex) {
          
        }
    }



}
