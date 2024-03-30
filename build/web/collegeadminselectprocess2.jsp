<%@page import="dao.collegedao"%>
<%@page import="entity.course"%>
<%@page import="helper.message"%>
<%@page import="entity.student"%>
<%@page import="dao.studentdao"%>
<%@page import="helper.RatingCount"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="entity.teacher"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.teacherdao"%>

<div class="row">
    <%
     message mg = (message)session.getAttribute("studentaddservlet");
     if(mg!=null)
     {
    %>
    <div class="alert alert-warning" role="alert">
        <%= mg.getMsg() %>
    </div>
    <% mg=null; session.setAttribute("studentaddservlet",mg);} %>
</div>
<div class="row">

  
    

    <div class="col-1 offset-11">
        <i class="bi bi-plus-square-fill me-3" data-bs-toggle="modal" data-bs-target="#exampleModal3"></i>
    </div>

</div>
<%@page import="entity.collegeadmin"%>
<div class="row">
    <%
        collegeadmin cd = (collegeadmin) session.getAttribute("collegeadmin");

        if (cd != null) {
        String  category = request.getParameter("category");
            int sem = Integer.parseInt(request.getParameter("sem"));

            if (category.equals("Teacher")) {
                teacherdao td = new teacherdao(ConnectionProvider.getConnection());
                Vector<teacher> t = td.getsemteachers(cd.getCid(), sem);
               
                Iterator<teacher> it = t.iterator();
                if(it.hasNext())
                {
                while (it.hasNext()) {
                    teacher tech = it.next();

    %>


    <div class="col-sm-6 col-md-3" style="background-color:transparent;color:rgb(50, 50, 50)!important;">
        <div class="card mb-3">
            <div class="row g-0 align-items-center">
                <div class="col-4 col-md-4 d-flex justify-content-center ps-1">
                    <img src="./userimg/<%= tech.getTimg()%>" class="img-fluid rounded-start teacher-img" alt="...">
                </div>
                <div class="col-8 col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><%= tech.getTname()%></h5>

                        <div class="card-text mb-0 d-flex">
                            <p class="card-text mb-0"><%= tech.getTsubject()%></p>    <p class="card-text mb-0">(<%= tech.getTsection()%>)</p>
                        </div>
                        <div>
                            <p class="mb-0 ">
                                <span class="teacher-rv">
                                    <%
                                        Connection con = ConnectionProvider.getConnection();
                                        String qtr = "select sum(t_rval) from tech_rating where tid=" + tech.getTid();
                                        Statement st = con.createStatement();
                                        ResultSet rs = st.executeQuery(qtr);
                                        float star = 0;
                                        if (rs.next()) {
                                            star = rs.getFloat(1);
                                        }
                                        qtr = "select count(sid) from tech_rating where tid=" + tech.getTid();
                                        st = con.createStatement();
                                        rs = st.executeQuery(qtr);
                                        float user = 0;
                                        if (rs.next()) {
                                            user = rs.getFloat(1);
                                        }
                                        out.print(RatingCount.rcount(star, user));
                                    %>
                                </span>
                                <span><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i></span> </p>
                        </div>
                        <i class="bi bi-person-fill-check"></i>
                        <%= user%>

                        <div class="card-identy" style="display:none" value="teacher"></div>
                        <div class="text-end">
                            <input type="hidden" class="tid" value="<%= tech.getTid()%>" /> 
                            <i class="bi bi-pencil-square me-2 tech-edit" data-bs-toggle="modal" data-bs-target="#exampleModal4"></i>
                            <i class="bi bi-trash3-fill me-2 text-danger tech-delete"></i>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </div>   
    <% }}else{
         out.println("<h5 class='text-center m-2 me-2'>No any teacher is found</h5>");

}%>
</div>
    <!--teacher add modal-->
      <div class="modal fade" id="exampleModal3" style="z-index:9999 !important;" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Teacher Add</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
    
            <form action="teacheradd" method="post" enctype="multipart/form-data">
                <div class="mb-1">
                    <label for="sen_no" class="form-label">Name</label>
                    <input type="text" class="form-control" id="sen_no" name="tname" required>
                </div>
                
                <div class="mb-1">
                    <label for="college-name" class="form-label">Sem</label>
                    <select class="form-select" aria-label="Default select example" id="college-name" name="tsem" required placeholder="please select option">
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
                    <input type="text" class="form-control" id="ssection" name="tsection" required>
                </div>
       
         <div class="mb-1">
                    <label for="ssection" class="form-label">Subject</label>
                    <input type="text" class="form-control" id="ssection" name="tsubject" required>
                </div>
       <div class="mb-3">
                                <label for="college-name" class="form-label">Course</label>
                                <select class="form-select" aria-label="Default select example" id="college-name" name="course-name" required placeholder="please select option">
                                    <option selected disabled value="">-select-</option>
                                    <% 
                                        collegedao cld = new collegedao(ConnectionProvider.getConnection());
                                        Vector<course> vc = cld.getcourse(cd.getCid());
                                        Iterator<course> it1 = vc.iterator();
                                        while(it1.hasNext())
                                        {
                                        course cr = it1.next();
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
                    <input type="file" class="form-control" id="simg" name="timg" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">add</button>
                </div>
    
               <input type="hidden" value="<%= cd.getCid() %>" name="cid"/>
            </form>
        </div>
    
    </div>
    </div>
    </div>
    
    <!--teacher update-->
   
      <div class="modal fade" id="exampleModal4" style="z-index:9999 !important;" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Teacher Update</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
    
            <form action="editteacher" method="post" enctype="multipart/form-data">
                <div class="mb-1">
                    <label for="sen_no" class="form-label">Name</label>
                    <input type="text" class="form-control" id="tname" name="tname" required>
                </div>
                
                <div class="mb-1">
                    <label for="college-name" class="form-label">Sem</label>
                    <select class="form-select" aria-label="Default select example" id="tsem" name="tsem" required placeholder="please select option">
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
                    <input type="text" class="form-control" id="tsection" name="tsection" required>
                </div>
       
         <div class="mb-1">
                    <label for="ssection" class="form-label">Subject</label>
                    <input type="text" class="form-control" id="tsubject" name="tsubject" required>
                </div>
    
           <div class="mb-3">
                                <label for="college-name" class="form-label">Course</label>
                                <select class="form-select" aria-label="Default select example" id="course-name" name="course-name" required placeholder="please select option">
                                    <option selected disabled value="">-select-</option>
                                    <% 
                                       collegedao  cld1 = new collegedao(ConnectionProvider.getConnection());
                                       Vector<course>  vc1 = cld1.getcourse(cd.getCid());
                                       Iterator<course> it2 = vc1.iterator();
                                        while(it2.hasNext())
                                        {
                                        course cr = it2.next();
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
                    <input type="file" class="form-control" id="simg" name="timg">
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">update</button>
                </div>
    
    
                <input type="hidden" value="" name="tid" id="tid"/>
            </form>
        </div>
    
    </div>
    </div>
    </div>
<%   } else {%>
<div class="table-responsive m-0 p-0 student-data">
    <table class="table table-striped table-hover">
       
        <%
            studentdao td = new studentdao(ConnectionProvider.getConnection());
            Vector<student> t = td.getsemstudent(cd.getCid(), sem);
            Iterator<student> it = t.iterator();
            if(it.hasNext())
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
            while (it.hasNext()) {
                student stu = it.next();
        %>


        <tr>
            <td><%= stu.getSen_no()%></td>
            <td><%= stu.getSroll_no()%></td>

            <td><%= stu.getSname()%></td>
       
            <td><%= stu.getSsection()%></td>
            <td><%= stu.getSgender()%></td>
            <td><%= stu.getSmobile()%></td>
            <td><%= stu.getScity()%></td>
            <td><%= stu.getSemail() %></td>
     <td><%= stu.getSimg()%></td>






            <td><i class="bi bi-pencil-square me-3 student-edit" data-bs-toggle="modal" data-bs-target="#exampleModalmy"></i>
                <input type="hidden" value="<%=stu.getSid() %>" class="sid"/>
            </td>
            <td><i class="bi bi-trash3-fill me-3 text-danger delete-stu"></i>
                <input type="hidden" value="<%=stu.getSid() %>" class="sid"/>
            </td>
        </tr>



        <%
    }}else{
         out.println("<h5 class='text-center'>No any student is found</h5>");

}%>
    </table>
</div>    
</div>

</div>
</div
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
                                        Vector<course> vc3 = cld3.getcourse(cd.getCid());
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


<!--student add-->
    <div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index:9999 !important;">
    <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Student Add</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
    
            <form action="addstudent" method="post" enctype="multipart/form-data">
                <div class="mb-1">
                    <label for="sen_no" class="form-label">Enrollment No</label>
                    <input type="text" class="form-control" id="sen_no" name="sen_no" pattern="[A-Za-z0-9]{14}" required>
                </div>
                <div class="mb-1">
                    <label for="roll_no" class="form-label">Roll_No</label>
                    <input type="number" class="form-control" id="roll_no" name="sroll_no" required>
                </div>
                <div class="mb-1">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="sname" required> 
                </div>
                <div class="mb-1">
                    <label for="college-name" class="form-label">Sem</label>
                    <select class="form-select" aria-label="Default select example" id="tsem" name="ssem" required placeholder="please select option">
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
                            <input class="form-check-input" type="radio" name="sgender" value="male" id="flexRadioDefault1">
                            <label class="form-check-label" for="flexRadioDefault1">
                                Male
                            </label>
                        </div>
                        <div class="form-check ms-2">
                            <input class="form-check-input" type="radio" name="sgender" value="female" id="flexRadioDefault2" checked>
                            <label class="form-check-label" for="flexRadioDefault2">
                                Female
                            </label>
                        </div>
                    </div>
                </div>
    
    
                <div class="mb-1">
                    <label for="smobile" class="form-label">Mobile_no</label>
                    <input type="text" class="form-control" id="smobile" required name="smobile" pattern="[0-9]{10}">
                </div>
                <div class="mb-1">
                    <label for="exampleFormControlTextarea1" class="form-label">City</label>
                    <input type="text" class="form-control" id="exampleFormControlTextarea1" name="scity" required>
                </div>
                   <div class="mb-3">
                                <label for="college-name" class="form-label">Course</label>
                                <select class="form-select" aria-label="Default select example" id="course-name" name="course-name" required placeholder="please select option">
                                    <option selected disabled value="">-select-</option>
                                    <% 
                                        collegedao cld5 = new collegedao(ConnectionProvider.getConnection());
                                        Vector<course> vc5 = cld5.getcourse(cd.getCid());
                                       Iterator<course> it6 = vc5.iterator();
                                        while(it6.hasNext())
                                        {
                                        course cr = it6.next();
                                      %>
                                
    
                                    
                                      <option value="<%= cr.getC_id() %>"><%= cr.getC_name() %></option>
                                 
                                <% }%>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a valid state.
                                </div>
                            </div>
                    <div class="mb-1">
                    <label for="semail" class="form-label">Email</label>
                    <input type="email" class="form-control" id="semail" name="semail"  title="enter correct email format"  pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" required>
                </div>
                <div class="mb-1">
                    <label for="simg" class="form-label">Image</label>
                    <input type="file" class="form-control" id="simg" name="simg">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">add</button>
                </div>
    
                <input type="hidden" value=<%= cd.getCid()%> name="cid"/>
               
            </form>
        </div>
    
    </div>
    </div>
    </div>
<% } }
%>


<script src="./jquery/jquery.js"></script>

<script>
   
         //search student name
    
        val = $(".teacher-rv");
   
        for (c1 = 0; c1 < val.length; c1++)
        {
           let inn1 = parseInt(val[c1].innerText);
            nextele = $(val[c1]).next();
            nextchild = nextele.children();

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
        
        //edie teacher info
        $(".tech-edit").on("click",function()
        {
             let sib = $(this).siblings();
            
            console.log("siblings");
            console.log(sib);
            sib = sib[0];
            let tid =$(sib).attr("value");
        //set tid in teacher update modal    
        $("#tid").attr("value",tid);
            
           
            console.log("tid");
            console.log(tid);
            $.ajax({
                url:"edittechinfo",
                data:{"tid":tid},
                success:function(data)
                {
                         let arr = data.split("^");
                         console.log(arr);
                         $("#tname").attr("value",arr[0]);
                    
                     $(($("#tsem").children())[arr[1]]).attr("selected",true);
                         $("#tsubject").attr("value",arr[2]);
                         $("#tsection").attr("value",arr[3]);
                         $(($("#course-name").children())[arr[4]]).attr("selected",true);
                     }         
            });
        });
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
        
        //delete teacher
        $(".tech-delete").on("click",function()
        {
            let tid = ($(this).siblings())[0];
            tid = $(tid).attr("value");
            let x = confirm("Are you sure delete teacher");
            if(x==true)
            {
           $.ajax({
               url:"deleteteacher",
               data:{"tid":tid},
               success:function(data)
               {
                   window.location.href="./newcollegeadmin.jsp";
               }
           }); 
       }
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