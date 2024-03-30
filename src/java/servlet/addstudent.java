
package servlet;


import dao.studentdao;
import entity.student;
import helper.ConnectionProvider;
import helper.imageintration;
import helper.message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import  java.sql.*;

@MultipartConfig
public class addstudent extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           
            String sen_no = request.getParameter("sen_no");
            int sroll_no = Integer.parseInt(request.getParameter("sroll_no"));
            String sname = request.getParameter("sname");
            int ssem = Integer.parseInt(request.getParameter("ssem"));
            String ssection = request.getParameter("ssection");
            String scity = request.getParameter("scity");
            String sgender = request.getParameter("sgender");
            String mobile_no = request.getParameter("smobile");
            int cid = Integer.parseInt(request.getParameter("cid"));
            int c_id = Integer.parseInt(request.getParameter("course-name"));
            String email=request.getParameter("semail");
            Part part = request.getPart("simg");
            
            imageintration imgin = new imageintration();
            String imgname = imgin.addimage(part, "student");
            
            studentdao sd = new studentdao(ConnectionProvider.getConnection());
            boolean t=true;
            try {
                  String qtr = "select * from students where smobile=? and cid=?";
                  PreparedStatement ps = ConnectionProvider.getConnection().prepareStatement(qtr);
                  ps.setString(1,mobile_no);
                  ps.setInt(2, cid);
                  ResultSet rs = ps.executeQuery();
                  if(rs.next())
                  {
                                      HttpSession ss = request.getSession();
                    ss.setAttribute("addcourse_error","this mobile_no student is already exits");
                    t=false;
                    
                  }
                  
                  qtr = "select * from students where semail=? and cid=?";
                  ps = ConnectionProvider.getConnection().prepareStatement(qtr);
                  ps.setString(1, email);
                  ps.setInt(2, cid);
                   rs = ps.executeQuery();
                  if(rs.next())
                  {
                                      HttpSession ss = request.getSession();
                    ss.setAttribute("addcourse_error","this email_id student is already exits");
                    t=false;
                           
                  }
                  
            } catch (Exception e) {
                e.printStackTrace();
            }
          
            
           if(t==true)
           {
            if(sd.addstudent(sen_no, sroll_no, sname, ssem, ssection, sgender, mobile_no, scity, imgname,email, cid,c_id)==0)
            {
         
              HttpSession ss = request.getSession();
           
              ss.setAttribute("addcourse_error","student enrollment number is already availabe");
                
            }
            else
            {
              out.println("add student sucessfully");
               HttpSession ss  = request.getSession();
               ss.setAttribute("stu_edit","added");
            }
           
           
        }
            response.sendRedirect("./newcollegeadmin.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
