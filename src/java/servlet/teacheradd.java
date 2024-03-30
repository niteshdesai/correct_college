
package servlet;

import dao.teacherdao;
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
public class teacheradd extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String tname = request.getParameter("tname");
            String tsubject = request.getParameter("tsubject");
            String tsection = request.getParameter("tsection");
            int tsem = Integer.parseInt(request.getParameter("tsem"));
            int cid = Integer.parseInt(request.getParameter("cid"));
            int c_id = Integer.parseInt(request.getParameter("course-name"));
            Part part = request.getPart("timg");
            imageintration imgin = new imageintration();
            String imgname=imgin.addimage(part, "teacher");
            teacherdao td = new teacherdao(ConnectionProvider.getConnection());
            td.addteacher(tname, tsem, tsection, tsubject, imgname, cid,c_id);
               HttpSession ss = request.getSession();
             ss.setAttribute("tech_edit","added");
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
