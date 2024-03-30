<%@page import="java.util.Iterator"%>
<%@page import="entity.course"%>
<%@page import="entity.course"%>
<%@page import="java.util.Vector"%>
<%@page import="dao.collegedao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="java.sql.*"%>
<% 
  String s = request.getParameter("data");
  System.out.println("search studetn data : "+s);
        String q="select * from students where sname like '%"+s+"%' or '%"+s+"' or '"+s+"%'";
        int cid=0;
%>
<div class="table-responsive m-0 p-0 student-data">
    <table class="table table-striped table-hover">
       
        <%
            Connection con = ConnectionProvider.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(q);
            if(rs.next())
            {%>
             <thead>
            <tr>

                <th scope="col">Enrollment_No</th>
                <th scope="col">Roll_No</th>
                <th scope="col">Name</th>
               
                <th scope="col">Section</th>
                <th scope="col">Gender</th>
                <th scope="col">Mobile_no</th>
                <th scope="col">City</th>
                 <th scope="col">Email</th>
                 <th scope="col">Image Name</th>
                <th scope="col">Edit</th>
                <th scope="col">Delete</th>
            </tr>
        </thead><%
            rs = st.executeQuery(q);
            while (rs.next()) {
               cid=rs.getInt("cid");
        %>


        <tr>
            <td><%= rs.getString("sen_no")%></td>
            <td><%= rs.getInt("sroll_no")%></td>

            <td><%= rs.getString("sname")%></td>
       
            <td><%= rs.getString("ssection")%></td>
            <td><%= rs.getString("sgender")%></td>
            <td><%= rs.getString("smobile")%></td>
            <td><%= rs.getString("scity")%></td>
            <td><%= rs.getString("semail")%></td>
     <td><%= rs.getString("simg")%></td>

      




            <td><i class="bi bi-pencil-square me-3 student-edit" data-bs-toggle="modal" data-bs-target="#exampleModalmy"></i>
                <input type="hidden" value="<%= rs.getInt("sid") %>" class="sid"/>
            </td>
            <td><i class="bi bi-trash3-fill me-3 text-danger delete-stu"></i>
                <input type="hidden" value="<%= rs.getInt("sid") %>" class="sid"/>
            </td>
        </tr>



        <%
    }}else{
         out.println("<h5 class='text-center'>No any student is found</h5>");

}%>
    </table>
</div>
    <!--student update-->
    <div class="modal fade" style="z-index:9999 !important;" id="exampleModalmy" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Student Update</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
    
            <form action="editstudent" method="post" enctype="multipart/form-data">
                <div class="mb-1">
                    <label for="sen_no" class="form-label">Enrollment No</label>
                    <input type="text" class="form-control" id="sen_no"  required="true"  required name="sen_no" pattern="[A-Za-z,0-9]{14}">
                </div>
                <div class="mb-1">
                    <label for="roll_no" class="form-label">Roll_No</label>
                    <input type="number" class="form-control" id="roll_no" name="sroll_no" required>
                </div>
                <div class="mb-1">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="sname" name="sname" required>
                </div>
                <div class="mb-1">
                    <label for="college-name" class="form-label">Sem</label>
                    <select class="form-select" aria-label="Default select example" id="ssem" name="ssem" required placeholder="please select option">
                        <option selected disabled value="">-select-</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
    
                    </select>
                    <div class="invalid-feedback">
                        Please select a valid state.
                    </div>
                </div>
                <div class="mb-1">
                    <label for="ssection" class="form-label">Section</label>
                    <input type="text" class="form-control" id="ssection" name="ssection" required>
                </div>
                <div class="mb-1">
                    <label for="collegename" class="form-label">Gender</label>
                    <div class="d-flex">
                        <div class="form-check">
                            <input class="form-check-input" type="radio"  name="sgender" value="male" id="male">
                            <label class="form-check-label" for="flexRadioDefault1">
                                Male
                            </label>
                        </div>
                        <div class="form-check ms-2">
                            <input class="form-check-input" type="radio" class="sgender" name="sgender" value="female" id="female" checked>
                            <label class="form-check-label" for="flexRadioDefault2">
                                Female
                            </label>
                        </div>
                    </div>
                </div>
    
    
                <div class="mb-1">
                    <label for="smobile" class="form-label">Mobile_no</label>
                    <input type="text" class="form-control" required id="smobile" name="smobile" pattern="[0-9]{10}" required />
                </div>
                <div class="mb-1">
                    <label for="exampleFormControlTextarea1" class="form-label">City</label>
                     <input type="text" class="form-control" id="scity" name="scity" required>
                </div>
                    <div class="mb-3">
                                <label for="college-name" class="form-label">Course</label>
                                <select class="form-select" aria-label="Default select example" id="course-name2" name="course-name" required placeholder="please select option">
                                    <option selected disabled value="">-select-</option>
                                    <% 
                                        collegedao cld3 = new collegedao(ConnectionProvider.getConnection());
                                        Vector<course> vc3 = cld3.getcourse(cid);
                                       Iterator<course> it4 = vc3.iterator();
                                        while(it4.hasNext())
                                        {
                                        course cr = it4.next();
                                      %>
                                
    
                                    
                                      <option value="<%= cr.getC_id() %>"><%= cr.getC_name() %></option>
                                 
                                <% }%>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a valid state.
                                </div>
                            </div>
                <div class="mb-1">
                    <label for="simg" class="form-label">Image</label>
                    <input type="file" class="form-control" id="simg" name="simg">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
    
    
                <input type="hidden" value="" name="sid" id="sid"/>
            </form>
        </div>
    
    </div>
    </div>
    </div>
                           <script src="./jquery/jquery.js"></script>          
                                <script>
                                    //edie student info
          $(".student-edit").on("click",function()
        {
            let sid = $(this).siblings();
            sid = $(sid[0]).attr("value");
            $("#sid").attr("value",sid);
            $.ajax({
                url:"editstudentinfo",
                data:{"sid":sid},
                success:function(data)
                {
                    let arr=data.split("^");
                    console.log(arr);
                    $("#sen_no").attr("value",arr[0]);
                    $("#roll_no").attr("value",arr[1]);
                    $("#sname").attr("value",arr[2]);
                
                     $(($("#ssem").children())[arr[3]]).attr("selected",true);
                    let g = arr[5];
                    if(g=="male")
                    {
                      $($("#male")[0]).attr("checked",true); 
                     
                    }
                    else
                    {
                       $($("#female")[0]).attr("checked",true);  
                       
                    }
                    $("#ssection").attr("value",arr[4]);
                    $("#smobile").attr("value",arr[6]);
                    $("#scity").attr("value",arr[7]);
                 $(($("#course-name2").children())[arr[8]]).attr("selected",true);
                }
            });
        });
        
                                    
                                       //delete student
        $(".delete-stu").on("click",function()
        {
            
            let sib = $(this).siblings();
            sib = $(sib[0]).attr("value");
             let x = confirm("Are you sure delete student");
            if(x==true)
            {
            $.ajax({
               url:"deletestudent",
               data:{"sid":sib},
               success:function(data)
               {
                   window.location.href="./newcollegeadmin.jsp";
               }
           });
            }
        });
                                </script>

