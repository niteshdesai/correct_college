

<%@page import="helper.RatingCount"%>
<%@page import="dao.collegedao"%>
<%@page import="entity.course"%>
<%@page import="helper.ConnectionProvider,java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
              
              String  s= request.getParameter("search_value");
            
            
            Connection con=ConnectionProvider.getConnection();
         
               String q="select * from colleges where cname like '%"+s+"%' or '%"+s+"' or '"+s+"%'";

          PreparedStatement psp = con.prepareStatement(q);
                  ResultSet col_rs=null;
            col_rs= psp.executeQuery();

          while(col_rs.next())
            {
                      System.out.println(" while loop rs = "+col_rs);
            
            int cid= col_rs.getInt("cid");
            System.out.println("cid = "+cid);

          

%>
         <div class="col-md-6 col-sm-6">
        <div class="card mb-3 card1">
          <div class="row g-0 align-items-center">
            <div class="col-md-4">
                <img src="./userimg/<%= col_rs.getString("cimg")%>" class="img-fluid rounded-start img-fluid py-2 px-2" alt="...">
            </div>
            <div class="col-md-8">
              <div class="card-body">
                <h5 class="card-title"><%= col_rs.getString("cname") %></h5>
                                  <p class="text-start mb-0"><b>Course</b> :
                                      <% 
                                             collegedao col=new collegedao(con);
                                       col.findcollege(col_rs.getInt("cid"));
                                        String qtr2 = "select c_name from course where cid=?";
//                                        Connection con1 = ConnectionProvider.getConnection();
                                        PreparedStatement ps1 = con.prepareStatement(qtr2);
                                        ps1.setInt(1,col_rs.getInt("cid"));
                                        ResultSet rs2 = ps1.executeQuery();
                                        while(rs2.next())
                                        {
                                          out.println(rs2.getString(1));
                                      }
                                      %>
                  </p>
<!--                <p class="card-text mb-1 popular-college-detail"></p> -->
                        <p class="mb-0"><span class="college-rv">
                                      <% 
                         
                            String qtr =  "select sum(c_rval) from coll_rating where cid="+cid;
                            Statement st1 = con.createStatement();
                            ResultSet rs1 = st1.executeQuery(qtr);
                             float star=0;
                            if(rs1.next())
                            {
                            star = rs1.getFloat(1);
           
                                      }
                         
                           String qtr1 = "select count(sid) from coll_rating where cid=?";
                           PreparedStatement ps = con.prepareStatement(qtr1);
                         
                           ps.setInt(1,cid);
                           ResultSet rs3 = ps.executeQuery();
                            float user=0;
                            if(rs3.next())
                            {
                     
                             user = rs3.getInt(1);
                           
                              }
                            out.print(RatingCount.rcount(star,user));
                     
                          %>
                           </span> 
                            <span><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i></span></p>
                        <p class="popular-college-detail mb-0 fs-6"><i class="bi bi-person-fill-check"></i>
                            <%= user %>
                        </p>
                        <form action="./college.jsp" method="post" id="colleges">
                            <input type="hidden" value=<%= cid %> name="selectedcollege"/>
                        <button type="submit" class="btn-link select_college">More about...</button>
                        </form>
              </div>
            </div>
          </div>
        </div>
        </div>
                        <%  } 

                      %>
                        
