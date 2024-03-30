
package servlet;

import dao.studentdao;
import entity.student;
import helper.ConnectionProvider;
import helper.imageintration;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class deletestudent extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int sid = Integer.parseInt(request.getParameter("sid"));
            System.out.println("delete servelet sid :"+sid);
            
            studentdao sd = new studentdao(ConnectionProvider.getConnection());
            student st = sd.findstudent(sid);
            
            sd.deletestudent(sid);
            
            imageintration imgin = new imageintration();
            System.out.println("deletestudetn servlet img name :"+st.getSimg());
            imgin.delete(st.getSimg(),"student");
                 HttpSession ss  = request.getSession();
          //  ss.setAttribute("stu_edit","deleted");
          ss.setAttribute("stu_edit","deleted");
          //  response.sendRedirect("./newcollegeadmin.jsp");
            
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
