<%@page import="helper.RatingCount"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.studentdao"%>
<%@page import="java.security.Timestamp"%>
<%@page import="java.util.Date,java.sql.*"%>
<%@page import="entity.collegeadmin"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>
    <%@include file="./links.html" %>

    <!-- Custom fonts for this template-->
  

    <!-- Custom styles for this template-->
    <link href="./css/owncss.css" rel="stylesheet"> 
    <style>
            .bi-plus-square-fill{
    font-size:1.6rem;
    color:#8490ff;
}
.bi-pencil-square {
    color:green;
}
.bi-trash3-fill{
    color:red;
}

.admin-pro{
  
  position: absolute !important;
  right:0rem !important;
  top:-1.5rem !important;
}
    .mylogo{
        width:5rem !important;
        height: 5rem !important;
    }
    .sidebar
    {
        background-color:#353a61 !important ;
        height: 100vh !important;
        position: sticky;
        top:0px;
    }
    .admin-search
    {
        background-color:#353a61 !important ; 
        position: relative;
        right: 2.5rem;
        z-index: 9999 !important;
    }
    .text-gray-600
    {
        color: #353a61 !important;
        font-weight: 700;
    }
    #mydropdown{
     position: relative !important;
     right: 5rem !important;
    }
    li{
        cursor: pointer;
    }
    .sem-ul li:hover{
            background-color: #3c427a;
            color:whitesmoke;
            padding:0.1rem;
           }
           .collegeadmin-college-img{
               width:3rem;
               height:3rem;
           } 
           .adminimg{
               width:2rem !important;
               height:2rem !important;
               
           }
    /* .card-img{
        width:3rem;
        height:3rem;
    } */

 </style>
</head>

<body id="page-top">

        <%
        collegeadmin cd = (collegeadmin)session.getAttribute("collegeadmin");
            String tsem = " ";
            String ssem = " ";
            String course=" ";
            if(session.getAttribute("course")!=null)
            {
            course=(String)session.getAttribute("course");
            session.setAttribute("course",null);
        }
            if(session.getAttribute("stu_edit")!=null)
            {
                ssem = (String) session.getAttribute("stu_edit");
    session.setAttribute("stu_edit",null);
        }
        
         
        if(session.getAttribute("tech_edit")!=null)
        {
    tsem = (String) session.getAttribute("tech_edit");
  
    session.setAttribute("tech_edit",null);
        }
      
        
        if(session.getAttribute("addcourse_error")!=null)
        {
        String msg = (String) session.getAttribute("addcourse_error");
    
        %>
           <div class="alert alert-danger" role="alert">
           <%= msg %>
             </div>
    <%
            session.setAttribute("addcourse_error",null);
        }
        
        if(cd!=null)
        {
      %>
       <input type="hidden" value="<%= course %>" class="course_add"/>
      <input type="hidden" value="<%= tsem %>" class="tsem-edit"/>
      <input type="hidden" value="<%= ssem %>" class="student_edit"/>
    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">
                    <img src="./webimage/mylogo2.png" alt="mylogo" class="mylogo"/>
                </div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link position-relative college">
                 
                    <span>Dashboard</span>
                    <i class="bi bi-chevron-right position-absolute end-0 pe-md-3"></i>
                </a>
                 
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
          <li class="nav-item">
        <a class="nav-link collapsed position-relative" href="#">
             
                    <span class="course">Course</span>
                    <i class="bi bi-chevron-right position-absolute end-0 pe-md-3"></i>
                </a>
   </li>
            <li class="nav-item">
   
                <a class="nav-link nav-link1 collapsed  position-relative" class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          
                    <span class="sem-drop">Teacher</span>
                    <i class="bi bi-chevron-right position-absolute end-0 pe-md-3"></i>
                </a>
                <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                    <div class="accordion-body p-0">
                      <ul class="sem-ul text-center p-0 tech">
                        <li value="1">Sem1</li>
                        <li value="2">Sem2</li>
                        <li value="3">Sem3</li>
                        <li value="4">Sem4</li>
                        <li value="5">Sem5</li>
                        <li value="6">Sem6</li>
                        <li style="display: none;">Teacher</li>
                      </ul>
                  </div>
                  </div>
            
            </li>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link nav-link1 collapsed position-relative" href="#" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
             
                    <span class="sem-drop">Student</span>
                    <i class="bi bi-chevron-right position-absolute end-0 pe-md-3"></i>
                </a>
                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                    <div class="accordion-body p-0">
                        <ul class="sem-ul text-center p-0">
                            <li value="1">Sem1</li>
                            <li value="2">Sem2</li>
                            <li value="3">Sem3</li>
                            <li value="4">Sem4</li>
                            <li value="5">Sem5</li>
                            <li value="6">Sem6</li>
                            <li style="display: none;">Stduent</li>
                          </ul>
                    </div>
                  </div>
                    
               
            </li>
    

        </ul>
          
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="bi bi-list" style="color:black;font-weight: 900 !important;"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small search-student" placeholder="Search only students..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary admin-search" type="button">
                                    <i class="bi bi-search " style="z-index:-1;"></i>
                                </button>
                            </div>
                        </div>
                    </form>



                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow admin-pro">
                            <a class="nav-link dropdown-toggle" href="#"  role="button"
                                 id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small p-2"><%= cd.getUsername() %></span>
                                <img class="img-profile rounded-circle adminimg"
                                    src="./userimg/<%= cd.getImage() %>" style="width:2rem;height:2rem;">
                            </a>
                          
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                            aria-labelledby="dropdownMenuButton1" id="mydropdown">
                                <a class="dropdown-item" href="./logoutcollegeadmin.jsp">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Log Out
                                </a>
                    
                          
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                    
                    </div>

                    <!-- Content Row -->
                    <div class="row">

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Student</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                <% 
                                                  studentdao sd1 = new studentdao(ConnectionProvider.getConnection());
                                                  out.println(sd1.countStudent(cd.getCid()));
                                                %>
                                            </div>
                                            <p class=" text-gray-800" style="font-size: 0.5rem;opacity: 60%;">its show total student in your college </p>
                                        </div>
                                        <div class="col-auto">
                                            <i class="bi bi-person-lines-fill h1 text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                FeedBack</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                <% 
                                                  sd1 = new studentdao(ConnectionProvider.getConnection());
                                                  out.println(sd1.countReview(cd.getCid()));
                                                %>
                                            </div>
                                            <p class=" text-gray-800" style="font-size: 0.5rem;opacity: 60%;">its show total feedback of your college </p>
                                        </div>
                                        <div class="col-auto">
                                            <i class="bi bi-person-vcard h1 text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Course
                                            </div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                                                        <%
                                                              sd1 = new studentdao(ConnectionProvider.getConnection());
                                                  out.println(sd1.countCourse(cd.getCid()));
                                                            %>
                                                    </div>
                                                </div>
                                                <p class=" text-gray-800" style="font-size: 0.5rem;opacity: 60%;">its show total courses of your college </p>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="bi bi bi-yelp h1 text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
<!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                Rating</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                <%
                                      Connection con = ConnectionProvider.getConnection();
                                                            String qtr =  "select sum(c_rval) from coll_rating where cid="+cd.getCid();
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery(qtr);
                             float star=0;
                            if(rs.next())
                            {
                            star = rs.getFloat(1);
                                      }
                            qtr = "select count(sid) from coll_rating where cid="+cd.getCid();
                            st=con.createStatement();
                            rs = st.executeQuery(qtr);
                            float user=0;
                            if(rs.next())
                            {
                             user = rs.getFloat(1);
                                      }
                            out.print(RatingCount.rcount(star,user));
                               
%>
                                            </div>
                                            <p class=" text-gray-800" style="font-size: 0.5rem;opacity: 60%;">it is show rating of college</p>
                                        </div>
                                        <div class="col-auto">
                                            <i class="bi bi-chat-dots h1 text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

  
                    <!-- Content Row -->

                    <div class="row">

                        <!-- Area Chart -->
                        <div class="col-xl-12 col-lg-12">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary content-text">College Details</h6>
                                 <div style="cursor: pointer;display:none;" class="add-course-btn" data-bs-toggle="modal"  data-bs-target="#examplemodelcourse"><p style="color: #3c427a"><i class="bi bi-plus-square"></i>&nbsp;Add Course</i></p></div>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body content">
                                    <!-- <div class="chart-area"> -->
                   
                                        <!--<div class="card border-0">-->
<!--                                            <div class="row g-0">
                                          
                                              <div class="col-md-8">
                                               <div class="card-body">
                                                  <h5 class="card-title">Card title</h5>
                                                  <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                                                  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                                                </div>
                                              </div>
                                              <div class="col-12 col-md-3">
                                                <img src="./images/college.jpg" class="img-fluid rounded-start" alt="">
                                              </div>
                                            </div>
                                          </div>
                                      -->
                                    <!-- </div> -->
                                </div>
                            </div>
                        </div>

     
                    </div>
         
    
 

               
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->


        </div>
        <!-- End of Content Wrapper -->


    </div>
    <!-- End of Page Wrapper -->
                <!--course add modal-->
                   <div class="modal fade mt-5" id="examplemodelcourse" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="model-title" id="exampleModelLabel">Course detail</h5>
                <button type="button" class="btn-close" data-bs-dismiss="model" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="courseadd" method="post">

                 <div class="mb-3" >
                     <label for="tname2" class="form-lable">Name</label>
                     <input type="text" class="form-control" id="tname2" name="cname" required>
                         </div>
                  <div class="mb-3" >
                    <label for="tname2" class="form-lable">Duration</label>
                    <input type="number" class="form-control" id="tname2" name="c_duration" pattern="[0-9]" required>
                  </div>
                    <div class="mb-3" >
               
                    <input type="hidden" class="form-control" id="tname2" name="c_since" value ="2024">
                     </div>
                    <input type="hidden" value="<%= cd.getCid() %>" class="cid" name="cid"/>
    <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Add</button>

            </div>

                 </div>                  
                </form>
            </div>
        
        </div>
    </div>

  
    <!-- <script src="./ownjs.js"></script> -->
    
     <!-- Bootstrap core JavaScript -->
  


     <script src="./jquery/jquery.js"></script>
 
    
    <script>
        !function(l){"use strict";l("#sidebarToggle, #sidebarToggleTop").on("click",function(e){l("body").toggleClass("sidebar-toggled"),l(".sidebar").toggleClass("toggled"),l(".sidebar").hasClass("toggled")&&l(".sidebar .collapse").collapse("hide")}),l(window).resize(function(){l(window).width()<768&&l(".sidebar .collapse").collapse("hide"),l(window).width()<480&&!l(".sidebar").hasClass("toggled")&&(l("body").addClass("sidebar-toggled"),l(".sidebar").addClass("toggled"),l(".sidebar .collapse").collapse("hide"))}),l("body.fixed-nav .sidebar").on("mousewheel DOMMouseScroll wheel",function(e){var o;768<l(window).width()&&(o=(o=e.originalEvent).wheelDelta||-o.detail,this.scrollTop+=30*(o<0?1:-1),e.preventDefault())}),l(document).on("scroll",function(){100<l(this).scrollTop()?l(".scroll-to-top").fadeIn():l(".scroll-to-top").fadeOut()}),l(document).on("click","a.scroll-to-top",function(e){var o=l(this);l("html, body").stop().animate({scrollTop:l(o.attr("href")).offset().top},1e3,"easeInOutExpo"),e.preventDefault()})}(jQuery);
 //search studens
    $(".search-student").on("input",function()
    {
       let val =  $(this).val();
      $.ajax({
          url:"searchstudent.jsp",
          data:{"data":val},
          success:function(data)
          {
                     $('.content').html(data);
          }
      })
    });
        
    
    $(".nav-link1").on("click",function()
         {
            let child = $(this).children();
            if($(this).hasClass("collapsed"))
            {
                $(child[1]).attr("class","bi bi-chevron-right position-absolute end-0 pe-md-3");
            }
            else
            {
                $(child[1]).attr("class","bi bi-chevron-down position-absolute end-0 pe-md-3");
            }
         });
        
            $(".sem-ul li").on("click",function()
  {
      let sem = $(this).attr("value");
      let cat = ($(this).siblings())[5].innerText;
      console.log(sem);
      console.log(cat);
      $.ajax({
          url:"./collegeadminselectprocess2.jsp",
          data:{"category":cat, "sem": sem},
            success: function (data) {
                console.log("collegeadminselect2process");
                    console.log(data);
                    $('.content').html(data);
                    
                       $(this).on("click",function()
                    {
                        alert("edit is call");
                    });
                    
                    
                    if(cat=="Teacher")
                    {
                       $(".content-text").text("Teacher Details"); 
                  $(".add-course-btn").attr("style","display:none");
                    }
                    else if(cat=="Stduent")
                    {
                        $(".content-text").text("Student Details");
                     $(".add-course-btn").attr("style","display:none");
                    }
                    
                 
                }
      });
  });
  
  
             let val4, inn, c, xl, nextele, nextchild;
       let val,x,rat,nexele,fill;
        let inn1;
      $(".college").on("click", function () {
            $.ajax({
                url: "./collegeadminselectprocess.jsp",
                success: function (data) {
                    $('.content').html(data);
                    $(".content-text").text("College Details");
                    $(".add-course-btn").attr("style","display:none");
                }
            });
        });

   
        $("document").ready(function () {
            let tsem = $(".tsem-edit").attr("value");
            let ssem = $(".student_edit").attr("value");
            let course = $(".course_add").attr("value");
            if(course!=" ")
            {
                alert("course added successfully");
            }
            if(tsem!=" ")
            {
                alert("teacher "+tsem+" successfully");
            }
            if(ssem!=" ")
            {
                alert("student "+ssem+" successfully");
            }
//            let child = $(".tech").children();

            $.ajax({
                url: "./collegeadminselectprocess.jsp",
                success: function (data) {
                    $('.content').html(data);
                  $(".add-course-btn").attr("style","display:none");
                }
            });
        });

         
     $(".course").on("click",function()
     {
         $.ajax({
             url:"./getcourses.jsp",
             data:{"cid":<%=cd.getCid()%>},
             success: function (data) 
                {
                               $('.content').html(data);     
                               $(".content-text").text("Course Details");
                               $(".add-course-btn").attr("style","display:block");
                    }
         });
     });
         

    </script>


  
  <%
      
      }else
{
 response.sendRedirect("./collegeadminlogin.jsp");
}
  %>

</body>

</html>