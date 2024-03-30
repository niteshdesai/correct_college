
package servlet;

import com.mysql.cj.conf.ConnectionPropertiesTransform;
import dao.studentdao;
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
public class editstudent extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

          String sen_no = request.getParameter("sen_no");
             System.out.println("studet edit serverl println");
             System.out.println("sroll_no :"+request.getParameter("sroll_no"));
            int sroll_no = Integer.parseInt(request.getParameter("sroll_no"));
            
            String sname = request.getParameter("sname");
            int ssem = Integer.parseInt(request.getParameter("ssem"));
            String ssection = request.getParameter("ssection");
            String scity = request.getParameter("scity");
            String sgender = request.getParameter("sgender");
            String mobile_no = request.getParameter("smobile");
            
            System.out.println("studet edit serverl println");
              
            
            int sid = Integer.parseInt(request.getParameter("sid"));
            
            Part part  = request.getPart("simg");
            
            studentdao sd = new studentdao(ConnectionProvider.getConnection());
            sd.updatestudent(sid, sen_no, sroll_no, sname, scity, ssem, ssection, sgender, mobile_no);
            
            imageintration imgin = new imageintration();
            imgin.updateimage(part, "student", sid);
                 HttpSession ss  = request.getSession();
            ss.setAttribute("stu_edit","updated");
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
