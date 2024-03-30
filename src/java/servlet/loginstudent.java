
package servlet;
import  java.sql.*;
import dao.studentdao;
import entity.student;
import helper.ConnectionProvider;
import helper.message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class loginstudent extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
           String en_no= request.getParameter("sen_no");
          int cid=Integer.parseInt(request.getParameter("cid"));
            int sem=Integer.parseInt(request.getParameter("ssem"));
           String email = request.getParameter("email");
            
            Connection con=ConnectionProvider.getConnection();
            studentdao sd=new studentdao(con);
            
            HttpSession ss=request.getSession();
             
            student st=sd.loginstudent(en_no, sem, cid,email);
            
            message ms=new message("invalide Detail...!","error");
           
            if(st!=null)
            {
               ss.setAttribute("loginstudent", st);
               response.sendRedirect("./profile.jsp");
            }
            else
            {
                response.sendRedirect("./studentlogin.jsp");
                
                ss.setAttribute("studentloginerror", ms);
            }
            }
            
        }
    }

    