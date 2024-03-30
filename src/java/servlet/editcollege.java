
package servlet;

import dao.collegedao;
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

@MultipartConfig
public class editcollege extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
       
             String cname = request.getParameter("cname");
             String cdesc = request.getParameter("cdesc");
             String ccourse = request.getParameter("ccourse");
             String cactivity = request.getParameter("cactivity");
//             String cemail = request.getParameter("cemail");
             String caddress = request.getParameter("caddress");
             int cid = Integer.parseInt(request.getParameter("cid"));
             Part part = request.getPart("cimg");
             
             collegedao cd = new collegedao(ConnectionProvider.getConnection());
             cd.updatecollege(cname, cdesc, cactivity, ccourse,caddress,cid);
            
             
          
             
             imageintration imgint = new imageintration();
             imgint.updateimage(part, "college", cid);
             
             response.sendRedirect("./newcollegeadmin.jsp");
//             out.println(cname+" "+cdesc+" "+ccourse+" "+cactivity+" "+cemail);
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
