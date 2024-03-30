/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
@WebServlet(urlPatterns = {"/contactdetailadd"})
public class contactdetailadd extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
 String fname=request.getParameter("pname");
 String cname=request.getParameter("cname");
 String city=request.getParameter("ccity");
 String mobile=request.getParameter("mobile");
 String email=request.getParameter("email");
 
 out.println(":"+fname+":"+cname+":"+city+":"+mobile+":"+email);
 Connection con=ConnectionProvider.getConnection();
 String qtr="insert into contact(fname,cname,city,mobile,email) values(?,?,?,?,?)";
PreparedStatement ps=con.prepareStatement(qtr);
 ps.setString(1,fname);
 ps.setString(2,cname);
 ps.setString(3,city);
 ps.setString(4,mobile);
 ps.setString(5,email);
 ps.execute();
 response.sendRedirect("./index.jsp");

        } catch (Exception e) {
        }
    }
}


