<%-- 
    Document   : admin_contact
    Created on : 20-Jan-2024, 2:33:21 pm
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="helper.ConnectionProvider,java.sql.*"%>





        <div class="table-responsive m-4">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th scope="col">id</th>
                        <th scope="col">fname</th>
                        <th scope="col">cname</th>
                        <th scope="col">city</th>
                        <th scope="col">mobile</th>

                        <th scope="col">email</th>

                    </tr>
                </thead>
        <%
            Connection con = ConnectionProvider.getConnection();

            String q = "select*from contact order by id desc";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(q);
              while (rs.next()) {
                      
                      
                 
        %>
                <tr>
                    <td><%=rs.getInt("id")%></td>
                    <td><%=rs.getString("fname")%></td>

                    <td><%=rs.getString("cname")%></td>
                    <td><%=rs.getString("city")%></td>
                    <td><%=rs.getString("mobile")%></td>
                    <td><%=rs.getString("email")%></td>
                </tr>
                
                <%}%>

            </table>
        </div>
                
                        <!--add college-->

<!--        <div class="modal fade" id="exampleModal4" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Add college</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <form action="collegeadd" method="post" enctype="multipart/form-data">
                            <div class="mb-1">
                                <label for="" class="form-label">college</label>
                                <input type="text" class="form-control" id="username" name="cname">
                            </div>


                            <div class="mb-1">
                                <label for="ssection" class="form-label">Description</label>
                                <textarea class="form-control" name="cdesc"></textarea>
                            </div>

                            <div class="mb-1">
                                <label for="ssection" class="form-label">Activity</label>
                                <input type="text" class="form-control" id="ssection" name="cactivity">
                            </div>

                            <div class="mb-1">
                                <label for="ssection" class="form-label">Course</label>
                                <input type="text" class="form-control" id="ssection" name="course">
                            </div>

                            <div class="mb-1">
                                <label for="ssection" class="form-label">Email</label>
                                <input type="text" class="form-control" id="ssection" name="email">
                            </div>
                            <div class="mb-1">
                                <label for="ssection" class="form-label">username</label>
                                <input type="text" class="form-control" id="ssection" name="username">
                            </div>
                            <div class="mb-1">
                                <label for="ssection" class="form-label">password</label>
                                <input type="text" class="form-control" id="ssection" name="password">
                            </div>
                            <div class="mb-1">
                                <label for="simg" class="form-label">Image</label>
                                <input type="file" class="form-control" id="simg" name="cimg">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">add</button>
                            </div>


                            <input type="hidden" value= name="cid"/>
                        </form>
                    </div>

                </div>
            </div>
        </div>
-->
