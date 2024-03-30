<%-- 
    Document   : navbar
    Created on : 02-Jan-2024, 3:23:07 pm
    Author     : admin
--%>

<%@page import="helper.RatingCount"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Vector,java.sql.*"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.collegedao,java.sql.*,entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
               .star-bg{
              color:gold;
            }
            .select_college{
                background-color:white !important;
                border:none !important;
                box-shadow:none !important;
           }
           .card:hover  .select_college{
                  background-color: rgb(71, 78, 105) !important;
                  color:whitesmoke !important;
                  transition: all 0.9s;
            }
        </style>
        <%@include file="./links.html" %>
    </head>
    
    <body>
        <%@include file="./navbar.jsp" %>
                <!-- hero section or Main section or home main section  -->
<!--<div class="container-fluid hero-section">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-11 col-md-6 hero-detail">
         <h1>Welcome,<span style="color:#8490ff">Students</span></h1> 
        <p>Education is the systematic process of transferring knowledge, skills, values, and attitudes in a structured
          and formalized setting. It is facilitated through teaching, training, or research.</p>
      </div>
      <div class="col-11 col-md-6">
        <div>
        <img src="./webimage/college project-pana.png" alt="heroimage" class="img-fluid"/>
      </div>
      </div>
    </div>
  </div>
</div>-->
<div class="container-fluid m-0 p-0">
    <img src="./webimage/home page3.png" alt="" class="img-fluid" style="width:100vw;height:90vh;"/>
</div>
          
           <!-- popular college section or college card section -->
<div class="container-fluid popular-colleges">
 <div class="container py-5">
     <div class="row">
        <div class="h4-title">
           <h4>Popular Colleges</h4>
        </div>
     </div>
     <div class="row">
       <div class="col-8 col-md-5  offset-md-7 offset-4">
        
        <div class="searchbox">
          <input class="form-control me-2 search search-college" type="search" placeholder="Search" aria-label="Search">
          <i class="bi bi-search"></i>
        </div>
        
       </div>
     </div>
     <div class="row my-2 colleges-content">
<%
        Connection con = ConnectionProvider.getConnection();
     
        
        collegedao cd = new collegedao(con);
        Vector<college> vc = cd.getColleges();
        Iterator<college> it = vc.iterator();
        while(it.hasNext())
        {
         college col = it.next();
     
     %>
         <div class="col-md-6 col-sm-6">
        <div class="card mb-3 card1">
          <div class="row g-0 align-items-center">
            <div class="col-md-4">
                <img src="./userimg/<%= col.getCimg() %>" class="img-fluid rounded-start img-fluid py-2 px-2" alt="...">
            </div>
            <div class="col-md-8">
              <div class="card-body">
                <h5 class="card-title"><%= col.getCname() %></h5>
                                  <p class="text-start mb-0"><b>Course</b> :
                                         <% 
                                             collegedao col2=new collegedao(con);
                                             col2.findcollege(col.getCid());
                                        String qtr2 = "select c_name from course where cid=?";
//                                        Connection con1 = ConnectionProvider.getConnection();
                                        PreparedStatement ps1 = con.prepareStatement(qtr2);
                                        ps1.setInt(1,col.getCid());
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
                         
                            String qtr =  "select sum(c_rval) from coll_rating where cid="+col.getCid();
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery(qtr);
                             float star=0;
                            if(rs.next())
                            {
                            star = rs.getFloat(1);
           
                                      }
                         
                           String qtr1 = "select count(sid) from coll_rating where cid=?";
                           PreparedStatement ps = con.prepareStatement(qtr1);
                         
                           ps.setInt(1,col.getCid());
                           ResultSet rs1 = ps.executeQuery();
                            float user=0;
                            if(rs1.next())
                            {
                     
                             user = rs1.getInt(1);
                           
                              }
                            out.print(RatingCount.rcount(star,user));
                     
                          %>
                           </span> 
                            <span><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i></span></p>
                        <p class="popular-college-detail mb-0 fs-6"><i class="bi bi-person-fill-check"></i>
                            <%= user %>
                        </p>
                        <form action="./college.jsp" method="post" id="colleges">
                        <input type="hidden" value=<%= col.getCid() %> name="selectedcollege"/>
                        <button type="submit" class="btn-link select_college">More about...</button>
                        </form>
              </div>
            </div>
          </div>
        </div>
        </div>
   <% } %>


 </div>
</div>
</div>
   <script src="./jquery/jquery.js"></script>
 <script>
     
     //search college name
     $(".search-college").on("input",function()
     {
         let c_name = $(this).val();
         $.ajax({
             url:"./searched_college.jsp",
             data:{"search_value":c_name},
             success:function(data)
             {
                 $(".colleges-content").html(data);
             }
         })
     });
     let val = $(".college-rv");
   let c1,nextele,nextchild,x;
        for (c1 = 0; c1 < val.length; c1++)
        {
           let inn1 = parseInt(val[c1].innerText);
            nextele = $(val[c1]).next();
            nextchild = nextele.children();
//             console.log(nextchild);
            for (x = inn1; x < 5; x++)
            {

            
                $(nextchild[x]).removeClass("star-bg");
            }
 
            if (inn1 < val[c1].innerText)
            {
                
               
                $(nextchild[inn1]).removeClass("bi-star-fill");
                $(nextchild[inn1]).addClass("bi-star-half");
                $(nextchild[inn1]).addClass("star-bg");
            }
        }
        </script>
        <%@include file="./footer.html" %>
    </body>
</html>
