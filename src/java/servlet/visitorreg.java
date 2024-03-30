
package servlet;

import dao.visitiordao;
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
import javax.servlet.http.Part;
import java.sql.*;
import javax.servlet.http.HttpSession;

@MultipartConfig
public class visitorreg extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String name = request.getParameter("vname");
            String city = request.getParameter("vcity");
            String email = request.getParameter("vemail");
            String password = request.getParameter("vpassword");
            String mobile = request.getParameter("vmobile");
            String qtr = "select * from visitor_reg where vemail=?";
            
  
            Connection con = ConnectionProvider.getConnection();
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setString(1,email);
            ResultSet rs = ps.executeQuery();
            
              qtr = "select * from visitor_reg where vmobile=?";
            
  

            ps = con.prepareStatement(qtr);
            ps.setString(1,mobile);
           ResultSet rs2 = ps.executeQuery();
            
            
            HttpSession ss = request.getSession();
                      String tech_name = request.getParameter("tech_name");
            String imgname=null;
            if(rs.next())
            {
                message mg =new message("Email id is already present...", "error");
                ss.setAttribute("visitor_reg",mg);
                response.sendRedirect("./visitorreg.jsp");
            }
            else if(rs2.next())
            {
                  message mg =new message("mobile_no is already present...", "error");
                ss.setAttribute("visitor_reg",mg);
                response.sendRedirect("./visitorreg.jsp"); 
            }
            else
            {
                Part part = request.getPart("vimg"); 
                visitiordao vd = new visitiordao(ConnectionProvider.getConnection());
                imgname=part.getSubmittedFileName();
                if(imgname=="")
                {
                   imgname="person.png";
                }else
                {   imageintration imgin = new imageintration();
                        imgin.addimage(part, "visitor"); 
                }
                vd.insertvisitor(name, email, password, city, imgname,tech_name,mobile);
                
            
          
                
                response.sendRedirect("./visitorlogin.jsp");
            }
            
            
            
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
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
