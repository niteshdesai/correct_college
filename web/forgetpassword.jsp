<%-- 
    Document   : forgetpassword
    Created on : 20-Feb-2024, 4:25:20 pm
    Author     : admin
--%>

<%@page import="helper.message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
            <%@include file="./links.html"%>
    </head>
    <body>
            <%@include file="./navbar.jsp" %>
  <div class="container-fluid px-3 py-5" style='width:100vw;height:86vh;display:flex;justify-content: center;align-items: center'>
        <div class="container my-contain login-form d-flex flex-column">
            <div class="col-12 col-sm-8 col-md-8 col-lg-4  offset-sm-2 offset-md-2 offset-lg-4 p-4" style="background-color: rgb(231, 231, 231);box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -webkit-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -moz-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);" >
                 <div class="row another-h4">
                    <div class="h4-title h4-title-login my-3">
                        <h4>Forgate Password</h4>
    
                    </div>
                </div>
          
                <div class="row">
                    <div class="col-12 col-md-12 ">
                        <% 
                         message mg =(message) session.getAttribute("forgeterror");
                         if(mg!=null)
                         {
                        %>
                        <div class="row">
                           <div class="alert alert-danger" role="alert">
             <%= mg.getMsg() %>
                           </div></div>
                        <% } session.setAttribute("forgeterror",null); %>
                        
                        <form action="forgetpassword" method="post">
                                    <div class="mb-3">
                                <label for="vname" class="form-label">Email</label>
                                <input type="email" class="form-control" id="enrollment"  name="email" title="enter correct email format"  pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" required>
                            </div>
                            <div class="mb-3">
                                <label for="vname" class="form-label">Give name of teacher in 12th class</label>
                                <input type="text" class="form-control" id="enrollment"  name="tech_name" required>
                            </div>
                            <div class="mb-3">
                                <label for="vcity" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="enrollment"  name="vpassword" required>
                            </div>
                            
                            <button type="submit" class="btn btn1">Submit</button>
                        
                         
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </body>
</html>
