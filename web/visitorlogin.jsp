<%@page import="helper.message"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   
    <title>Document</title>
    <%@include file="./links.html"%>

</head>
<body>
    <%@include file="./navbar.jsp" %>
    <div class="container-fluid px-3 py-5" style='width:100vw;height:86vh;display:flex;justify-content: center;align-items: center'>
        <div class="container my-contain login-form d-flex flex-column">
            <div class="col-12 col-sm-8 col-md-8 col-lg-4  offset-sm-2 offset-md-2 offset-lg-4 p-4" style="background-color: rgb(231, 231, 231);box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -webkit-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -moz-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);" >
                <div class="row">
                    <div class="h4-title h4-title-login my-3">
                        <h4>User Login</h4>
    
                    </div>
                </div>
                <div class="row">
          <%
              
            message mg = (message)session.getAttribute("visitorloginerror");
            
           if(mg!=null)
           {
           
          %>
             <div class="alert alert-danger" role="alert">
             <%= mg.getMsg() %>
             </div>
             <% session.setAttribute("visitorloginerror", null);} %>
                </div>
                <div class="row">
                    <div class="col-12 col-md-12 ">
                        <form action="visitorlogin" method="post">
                            <div class="mb-3">
                                <label for="vname" class="form-label">Email</label>
                                <input type="email" class="form-control" id="enrollment"  name="vemail" title="enter correct email format"  pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" required>
                            </div>
                            <div class="mb-3">
                                <label for="vcity" class="form-label">Password</label>
                                <input type="password" class="form-control" id="enrollment"  name="vpassword" required>
                            </div>
                            
                            <button type="submit" class="btn btn1">Login</button>
                        
                            <a href="./visitorreg.jsp" style="margin-left: 1rem">Register here</a>
                            <p class="text-center mb-0"><a href="./forgetpassword.jsp">Forgate Password</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>