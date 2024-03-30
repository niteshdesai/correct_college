<%@page import="helper.message"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%@include  file="./links.html" %>

</head>
<body>
    <%@include  file="./navbar.jsp" %>
    <%
      message mg =(message)session.getAttribute("visitor_reg");
      
    %>
    <div class="container-fluid px-3 py-5" >
        <div class="container my-contain login-form d-flex flex-column">
            <div class="col-12 col-sm-8 col-md-8 col-lg-4  offset-sm-2 offset-md-2 offset-lg-4 p-4" style="background-color: rgb(231, 231, 231);box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -webkit-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -moz-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);" >
                <div class="row">
                    <div class="h4-title h4-title-login my-3" style="width:15rem;">
                        <h4>User Registation</h4>
    
                    </div>
                </div>
                <div class="row">
          <% 
            if(mg!=null)
            {
          %>
             <div class="alert alert-warning" role="alert">
           <%= mg.getMsg() %>
             </div>
           <% session.setAttribute("visitor_reg",null); }%>
                </div>
                <div class="row">
                    <div class="col-12 col-md-12 ">
                        <form action="visitorreg" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="vname" class="form-label">FullName</label>
                                <input type="text" class="form-control" id="enrollment"  name="vname"  title="enter only letter" pattern="[a-zA-Z\s]+" required>
                            </div>
                            <div class="mb-3">
                                <label for="vcity" class="form-label">City</label>
                                <input type="text" class="form-control" id="enrollment"  name="vcity" required>
                            </div>
                            <div class="mb-3">
                                <label for="vemail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="vemail"  name="vemail" title="please,enter correct email" pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" required>
                            </div>
                             <div class="mb-3">
                                <label for="vmobile" class="form-label">Mobile</label>
                                <input type="text" class="form-control" id="vmobile"  name="vmobile" maxlength="10" pattern="[0-9]{10}" title="enter only 10 digit" required >
                            </div>
                                    <div class="mb-3">
                                <label for="vemail" class="form-label">Password</label>
                                <input type="password" class="form-control" id="vemail"  name="vpassword" pattern=".{5,}" title="password must greater than 5 character" required>
                            </div>
                                  <div class="mb-3">
                                <label for="vname" class="form-label">Give name of teacher in 12th class</label>
                                <input type="text" class="form-control" id="enrollment"  name="tech_name" required>
                            </div>
                            <div class="mb-3">
                                <label for="simg" class="form-label">Image</label>
                                <input type="file" class="form-control" id="vimg" name="vimg">
                            </div>
     
                            <button type="submit" class="btn btn1">Registration</button>
                        
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
