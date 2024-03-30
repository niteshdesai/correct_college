
package servlet;

import helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;


public class addcollegerating extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int star_fill=Integer.parseInt(request.getParameter("star_fill"));
            int card_id=Integer.parseInt(request.getParameter("id"));
            String card_selected=request.getParameter("select_card");
            int sid=Integer.parseInt(request.getParameter("sid"));
          
            int cid=Integer.parseInt(request.getParameter("cid"));
            
            System.out.println(star_fill+" "+card_id+" "+card_selected+" "+cid+" "+sid);
            
            
            if(card_selected.equals("college")){
                Connection con=ConnectionProvider.getConnection();
                String qtr="select * from coll_rating where cid="+cid+" and sid="+sid;
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery(qtr);

                if(rs.next())
                {
                    qtr="update coll_rating set c_rval="+star_fill+" where cid="+cid+" and sid="+sid;
                    st=con.createStatement();
                    st.execute(qtr);
                    out.println("SeccessFully Rating Updated...");

                }else{
                    qtr="insert into coll_rating(c_rval,cid,sid)values(?,?,?)";
                    PreparedStatement ps=con.prepareStatement(qtr);
                    ps.setInt(1,star_fill);
                    ps.setInt(2,cid);
                    ps.setInt(3,sid);
                    ps.execute();
                    out.println("SuccessFully RAting Added...");

                }
            }else{
             
                Connection con=ConnectionProvider.getConnection();
                String qtr="select * from tech_rating where tid="+card_id+" and sid="+sid;
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery(qtr);

                if(rs.next())
                {
                    qtr="update tech_rating set t_rval="+star_fill+" where tid="+card_id+" and sid="+sid;
                    st=con.createStatement();
                    st.execute(qtr);
                    out.println("SeccessFully Rating Updated...");
                }else{

                    qtr="insert into tech_rating(t_rval,tid,sid)values(?,?,?)";
                    PreparedStatement ps=con.prepareStatement(qtr);
                    ps.setInt(1,star_fill);
                    ps.setInt(2,card_id);
                    ps.setInt(3,sid);
                    ps.execute();
                    out.println("SuccessFully Rating Added...");


                }
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
