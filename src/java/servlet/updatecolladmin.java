/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import helper.ConnectionProvider;
import helper.message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/updatecolladmin"})
public class updatecolladmin extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String email=request.getParameter("username");
            String password=request.getParameter("Password");
             String cname=request.getParameter("cname");
      System.out.println("updatecollegeadmin email ="+email);
             Connection con=ConnectionProvider.getConnection();
             String qtr1 = "select * from college_admin where email='"+email+"'";
             Statement st1 = con.createStatement();
             ResultSet rs1= st1.executeQuery(qtr1);
             if(!rs1.next())
             {
           String qtr="select * from colleges where cname='"+cname+"'";
           
           Statement st=con.createStatement();
           
           ResultSet rs=st.executeQuery(qtr);
           
           if(rs.next())
           {
               int cid=rs.getInt("cid");
               
               out.println(cid);
              qtr="update college_admin set email=?,password=? where cid='"+cid+"'";
              
              PreparedStatement ps=con.prepareStatement(qtr);
              
              ps.setString(1, email);
              ps.setString(2, password);
              ps.execute();
              response.sendRedirect("./newadmin.jsp");
           }
             }
             else
             {
                 System.out.println("else part is execute");
                 message mg = new message("email id is already availble","error");
                 HttpSession ss = request.getSession();
                 ss.setAttribute("update_collegeadmin",mg);
                      response.sendRedirect("./newadmin.jsp");
             }
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println(e.getMessage());  
        }
    }



}
