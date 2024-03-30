
package servlet;

import dao.collegedao;
import helper.ConnectionProvider;
import helper.message;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class courseadd extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
         
            String cname = request.getParameter("cname");
            String c_duration = request.getParameter("c_duration");
            String c_since = request.getParameter("c_since");
            int cid = Integer.parseInt(request.getParameter("cid"));
            
            
            
            collegedao cd = new collegedao(ConnectionProvider.getConnection());
            if(!cd.addcourse(cname, Integer.parseInt(c_duration), Integer.parseInt(c_since), cid))
            {
           
                HttpSession ss = request.getSession();
                    ss.setAttribute("addcourse_error","course is already available");
            }
            else
            {
                       HttpSession ss  = request.getSession();
               ss.setAttribute("course","added");
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
