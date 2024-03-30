
package servlet;

import dao.commentdao;
import helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class add_com_reply extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
 



       int com_id = Integer.parseInt(request.getParameter("com_id"));
     String id1 = request.getParameter("id");
     id1=id1.trim();
    System.out.println("id1 ="+id1);
     int id = Integer.parseInt(id1);
    
      String category = request.getParameter("category");
    
       int like =Integer.parseInt(request.getParameter("like"));
       int dislike =Integer.parseInt(request.getParameter("dislike"));
       
            commentdao cmd = new commentdao(ConnectionProvider.getConnection());
            cmd.com_reply(com_id, id, category, like, dislike);
       
       out.print(cmd.countlike(com_id)+"^"+cmd.countdislike(com_id));
       
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
