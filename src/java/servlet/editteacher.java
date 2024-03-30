
package servlet;

import dao.teacherdao;
import entity.teacher;
import helper.ConnectionProvider;
import helper.imageintration;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class editteacher extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
    
             String tname = request.getParameter("tname");
             int tsem = Integer.parseInt(request.getParameter("tsem"));
             String tsubject = request.getParameter("tsubject");
             String tsection = request.getParameter("tsection");
             int tid = Integer.parseInt(request.getParameter("tid"));
             int c_id = Integer.parseInt(request.getParameter("course-name"));
             Part part = request.getPart("timg");
            
             String imgname=part.getSubmittedFileName();
            System.out.println(tname+" "+tsem+" "+tsection+" "+tsubject+" "+imgname);
            
             teacherdao td = new teacherdao(ConnectionProvider.getConnection());
             td.updateteacher(tname, tsem, tsection, tsubject, tid,c_id);
             
             imageintration imgin = new imageintration();
             imgin.updateimage(part, "teacher", tid);
            
             HttpSession ss = request.getSession();
             ss.setAttribute("tech_edit","update");
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
