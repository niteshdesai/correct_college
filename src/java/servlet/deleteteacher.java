
package servlet;

import dao.teacherdao;
import entity.teacher;
import helper.ConnectionProvider;
import helper.imageintration;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;


public class deleteteacher extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
 
            int tid = Integer.parseInt(request.getParameter("tid"));
           
            String qtr= "delete from tech_rating where tid =?";
            Connection con = ConnectionProvider.getConnection();
            
            PreparedStatement ps = con.prepareStatement(qtr);
            ps.setInt(1, tid);
            ps.execute();
            
                     
           
            teacherdao td = new teacherdao(ConnectionProvider.getConnection());
            teacher t = td.findteacher(tid);
            td.deleteteacher(tid);
            
            imageintration imgin = new imageintration();
            imgin.delete(t.getTimg(),"teacher");
            
                 HttpSession ss = request.getSession();
             ss.setAttribute("tech_edit","deleted");
              
          
           // response.sendRedirect("./newcollegeadmin.jsp");
             
         
            
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
