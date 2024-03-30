<%@page import="helper.ConnectionProvider,java.sql.*,helper.message"%>


  


        <div class="m-1">
            <h5 style="color:red;">
                <%
                    message mg = (message) session.getAttribute("collegeadd");

                    if (mg != null) {

                %>
                <div class="alert alert-danger" role="alert">
                    <%=mg.getMsg()%>
                </div>
                <%  }
                    session.setAttribute("collegeadd", null);
                    message mg1 = (message) session.getAttribute("username_collegeadmin");
                    if (mg1 != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%=mg1.getMsg()%>
                </div>

                <%}
                    session.setAttribute("username_collegeadmin", null);
                %>

     <%
                                    mg = (message)session.getAttribute("update_collegeadmin");
                                     if(mg!=null)
                                     {
                                   %>
                                      <div class="alert alert-danger" role="alert">
                                    <%=mg.getMsg()%>
                                      </div>
                                    <%} session.setAttribute("update_collegeadmin",null); %>
            </h5>
        </div>

        <!--admin home-->
        <div class="table-responsive ">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">Cname</th>
                       
                        <th scope="col">Cactivity</th>
                        <th scope="col">Course</th>
                        <th scope="col">Email</th>
                        <th scope="col">address</th>
                        <th scope="col">admin_email</th>
                        <th scope="col">Password</th>
                        <th scope="col">Edit</th>
                        <th scope="col">FeedBack</th>
                    </tr>
                </thead>
                <%
                    Connection con = ConnectionProvider.getConnection();

                    String q = "select * from colleges";
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery(q);
                    q = "select * from college_admin";
                    st = con.createStatement();
                    ResultSet rs1 = st.executeQuery(q);

                    while (rs.next()) {
                        rs1.next();


                %>
                <tr>
                    <td><%=rs.getString("cname")%></td>
                
                    <td><%=rs.getString("cactivity")%></td>
                    <td><%
                          
                                       String  qtr2 = "select c_name from course where cid=?";
                                    
                                      PreparedStatement   ps1 = con.prepareStatement(qtr2);
//                                      out.println("cid = "+rs.getInt("cid"));
                                        ps1.setInt(1,rs.getInt("cid"));
                                       ResultSet  rs2 = ps1.executeQuery();
                                       while(rs2.next())
                                       {
                                       out.println(rs2.getString(1));
                    }
                        
                        %></td>
                    <td><%=rs.getString("email")%></td>
                    <td><%=rs.getString("address") %>
                    <td><%=rs1.getString("email")%></td>
                    <td><%=rs1.getString("password")%></td>








                    <td><i class="bi bi-pencil-square me-3" data-bs-toggle="modal" data-bs-target="#exampleModal5"></i></td>
                    <td><p class="text-primary feedback-btn" style="cursor:pointer">Show</p><input type="hidden" class="college-all-feedback" value="<%= rs.getInt("cid") %>"/></td>
                </tr>
                <% }%>
            </table>
        </div>



        
       
        <script src="./jquery/jquery.js"></script>
        <script>
                $(".feedback-btn").on("click",function()
    {       
                  console.log("feedback-btn");
                  let child =  $(this).siblings();
                  let cid = $(child[0]).attr("value");
                  $.ajax({
                      url:"./getcollegecomment.jsp",
                      data:{"cid":cid},
                      success:function(data)
                      {
                          console.log("get feedback");
                          console.log(data);
                          $(".content").html(data);
                      }
                  });
    });
//    
            let cname;
            $(".bi-pencil-square").on("click",function(){
               let par=$($($(this).parent()).parent());
               cname=$(par).children();
               cname=cname[0].innerText;
               
               $(".cname").attr("value",cname);
               
//               console.log(cname);
            });
            
            </script>
