<%@page import="helper.message"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.admindao"%>
<%@page import="entity.admin"%>
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
    <link rel="stylesheet" href="./css/owncss.css"/>



  


    
 <style>
          .comment{
                margin: 5px;
                border: 1px solid rgba(0,0,0,.125);
                box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                -webkit-box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                -moz-box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
            }
            .comment-contain img{
                width: 2rem;
                height:2rem;
                border-right:50% !important;

            }
            .comment-header{
                display: flex;
                gap:0.5rem;
                align-items: center;
            }
            .comment-header p{
                position: relative;
                top: 0.3rem;
            }
            .reply-contain{
                display: flex;
                gap:0.5rem;
                display: flex;
                gap:0.5rem;
                align-items: center;
            }
            .comment-header p{
                position: relative;
                top: 0.3rem;
            }
            .reply-contain{
                display: flex;
                gap:0.5rem;
            }
            .like-dilike-icon-contain{
                background-color:#f3f4fe;   
                box-shadow:0px 0px 0px 1px black;
                padding: 0.3rem;
                border-radius:50%;
                color:black;
            }
.admin-pro{
  
  position: absolute !important;
  right:0rem !important;
  top:-1.5rem !important;
}
.bi-pencil-square {
    color:green;
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
       
       admin ad = (admin)session.getAttribute("adminlogin");
       if(ad!=null)
       {
    %>
    
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
                <a class="nav-link position-relative colleges">
                 
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
   

            
            </li>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed position-relative" href="#" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
             
                    <span class="sem-drop contacts">Contact</span>
                    <i class="bi bi-chevron-right position-absolute end-0 pe-md-3"></i>
                </a>
     
               
            </li>

                         <li class="nav-item">
   
                <a class="nav-link collapsed  position-relative" class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
          
                    <span class="sem-drop" data-bs-toggle="modal" data-bs-target="#exampleModal4">add</span>
                    <i class="bi bi-chevron-right position-absolute end-0 pe-md-3"></i>
                </a>
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

<!--                     Topbar Search 
                    <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary admin-search" type="button">
                                    <i class="bi bi-search "></i>
                                </button>
                            </div>
                        </div>
                    </form>-->



                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow admin-pro">
                            <a class="nav-link dropdown-toggle" href="#"  role="button"
                                 id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small p-2"><%= ad.getUsername() %></span>
                                <img class="img-profile rounded-circle adminimg"
                                    src="./userimg/<%= ad.getImage() %>" style="width:2rem;height:2rem;"/>
                            </a>
                          
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                            aria-labelledby="dropdownMenuButton1" id="mydropdown">
                            
                              
                                <a class="dropdown-item" href="./logoutadmin.jsp" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
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
                                                Colleges</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><% 
                                                 admindao ad1 = new admindao(ConnectionProvider.getConnection());
                                                 out.print(ad1.countColleges());
                                                %></div>
                                            <p class=" text-gray-800" style="font-size: 0.5rem;opacity: 60%;">It show number of colleges present on website</p>
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
                                               Contacts</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                <%      ad1 = new admindao(ConnectionProvider.getConnection());
                                                 out.print(ad1.countcontact()); %>
                                            </div>
                                            <p class=" text-gray-800" style="font-size: 0.5rem;opacity: 60%;">Total number of contact to our website</p>
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
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                                 Students
                                            </div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                                                             <%      ad1 = new admindao(ConnectionProvider.getConnection());
                                                 out.print(ad1.countStudent()); %>
                                                    </div>
                                                </div>
                                                <p class=" text-gray-800" style="font-size: 0.5rem;opacity: 60%;">Total number of student register to our website </p>
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
                                                Visitor</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                                     <%      ad1 = new admindao(ConnectionProvider.getConnection());
                                                 out.print(ad1.contVistor()); %>
                                            </div>
                                            <p class=" text-gray-800" style="font-size: 0.5rem;opacity: 60%;">Total visitor,who is register to our website</p>
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
                                    <h6 class="m-0 font-weight-bold text-primary text-content">College Details</h6>
                           
                                </div>
                                <!-- Card Body -->
                                <div class="card-body content college-detail">
                              
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


  <!--add college-->

        <div class="modal fade" style="z-index:99999 !important;" id="exampleModal4" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                <input type="text" class="form-control" id="username" name="cname" required>
                            </div>


                            <div class="mb-1">
                                <label for="ssection" class="form-label">Description</label>
                                <textarea class="form-control" name="cdesc" pattern=".{15,}" title="Description must greater than 15 character" required></textarea>
                            </div>

                            <div class="mb-1">
                                <label for="ssection" class="form-label">Activity</label>
                                <input type="text" class="form-control" id="ssection" name="cactivity" required>
                            </div>


                            <div class="mb-1">
                                <label for="ssection" class="form-label">College_Email</label>
                                <input type="email" class="form-control" id="ssection" name="email" title="enter correct email format"  pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" required>
                            </div>
                            <div class="mb-1">
                                <label for="ssection" class="form-label">Address</label>
                                <textarea class="form-control" name="caddress" required></textarea>
                            </div>
                            
                            <div class="mb-1">
                                <label for="ssection" class="form-label">username</label>
                                <input type="text" class="form-control" id="ssection" name="username" required>
                            </div>
                            
                            <div class="mb-1">
                                <label for="ssection" class="form-label">collegeadmin_email</label>
                                <input type="email" class="form-control" id="ssection" name="cd_email"  title="enter correct email format"  pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" required>
                            </div>
                            <div class="mb-1">
                                <label for="ssection" class="form-label">password</label>
                                <input type="password" class="form-control" id="ssection" name="password" pattern=".{5,}" title="password must greater than 5 character" required>
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


        <div class="modal fade" style="z-index:9999 !important" id="exampleModal5" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Update </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <form action="updatecolladmin" method="post">
                            <div class="mb-1">
                                <label for="username" class="form-label">Email</label>
                                <input type="email" class="form-control" id="username" name="username" title="enter correct email format"  pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" required>
                            </div>
                            <div class="mb-1">
                                <label for="Password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="Password" name="Password" pattern=".{5,}" title="password must greater than 5 character" required>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </div>
                            <input type="hidden" value="" name="cname" class="cname"/>
                        </form>
                    </div>

                </div>
            </div>
        </div>
  <% }
  else
{
  response.sendRedirect("./adminlogin.jsp");
}
  %>
    <!-- <script src="./ownjs.js"></script> -->
    
     <!-- Bootstrap core JavaScript -->
     <script src="./jquery/jquery.js"></script>
    <script>
        
        
        !function(l){"use strict";l("#sidebarToggle, #sidebarToggleTop").on("click",function(e){l("body").toggleClass("sidebar-toggled"),l(".sidebar").toggleClass("toggled"),l(".sidebar").hasClass("toggled")&&l(".sidebar .collapse").collapse("hide")}),l(window).resize(function(){l(window).width()<768&&l(".sidebar .collapse").collapse("hide"),l(window).width()<480&&!l(".sidebar").hasClass("toggled")&&(l("body").addClass("sidebar-toggled"),l(".sidebar").addClass("toggled"),l(".sidebar .collapse").collapse("hide"))}),l("body.fixed-nav .sidebar").on("mousewheel DOMMouseScroll wheel",function(e){var o;768<l(window).width()&&(o=(o=e.originalEvent).wheelDelta||-o.detail,this.scrollTop+=30*(o<0?1:-1),e.preventDefault())}),l(document).on("scroll",function(){100<l(this).scrollTop()?l(".scroll-to-top").fadeIn():l(".scroll-to-top").fadeOut()}),l(document).on("click","a.scroll-to-top",function(e){var o=l(this);l("html, body").stop().animate({scrollTop:l(o.attr("href")).offset().top},1e3,"easeInOutExpo"),e.preventDefault()})}(jQuery);
    
    let id5,category;
    $(".btn-close").on("click",function()
     {
        window.location.href="./newadmin.jsp"; 
     });
    
    //delete comment
     

    
    $(".nav-link").on("click",function()
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
         $(document).ready(function()
         {
                  $.ajax({
              url:"./getcolleges.jsp",
        
              success:function(data){
               $(".content").html(data);  
              }
          });
         });
      $(".colleges").on("click",function()
      {
          window.location.href="./newadmin.jsp";
      });
      $(".contacts").on("click",function()
      {
             $.ajax({
              url:"getcontacts.jsp",
        
              success:function(data){
               $(".content").html(data);  
               $(".text-content").text("Contact details..");
              }
          });
      });

      

    </script>


 

</body>

</html>
