<%-- 
    Document   : login
    Created on : 02-Jan-2024, 3:38:46 pm
    Author     : admin
--%>

<%@page import="entity.student"%>
<%@page import="helper.message"%>
<%@page import="java.util.Vector,java.sql.*"%>
<%@page import="java.util.Iterator"%>
<%@page import="entity.college"%>
<%@page import="dao.collegedao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%@include file="links.html" %>
    </head>
    
    
    <body>
    <%@include file="navbar.jsp"%>
    <% 
         student st = (student)session.getAttribute("loginstudent");
       if(st!=null)
       {
        response.sendRedirect("./profile.jsp");
    }
    %>
    <div class="container-fluid px-3 py-5" >
        <div class="container my-contain login-form d-flex flex-column">
            <div class="col-12 col-sm-8 col-md-8 col-lg-4  offset-sm-2 offset-md-2 offset-lg-4 p-4" style="background-color: rgb(231, 231, 231);box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -webkit-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -moz-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);" >
                <div class="row">
                    <div class="h4-title h4-title-login">
                        <h4>login form</h4>
    
                    </div>
                </div>
                <div class="row">
          <%
             message mg = (message)session.getAttribute("studentloginerror");
             if(mg!=null)
             {
          %>
             <div class="alert alert-warning mt-1" role="alert">
           <%= mg.getMsg() %>
             </div>
          <%  session.setAttribute("studentloginerror",null);} %>
                </div>
                <div class="row">
                    <div class="col-12 col-md-12">
                        <form action="loginstudent" method="post">
                            <div class="mb-3 mt-2">
                                <label for="enrollment" class="form-label">Enrollment No</label>
                                <input type="text" class="form-control" id="enrollment" title="enrollment_no must be 14 letter"  pattern="[a-zA-z0-9]{14}" name="sen_no" required>
                            </div>
                            <div class="mb-3">
                                <label for="college-name" class="form-label">College</label>
                                <select class="form-select" aria-label="Default select example" id="college-name" name="cid"  placeholder="please select option" required> 
                                    <option selected disabled value="">-select-</option>
                                        <%
                                      Connection con=ConnectionProvider.getConnection();
                                      collegedao cd=new collegedao(con);
                                     Vector<college> vd=cd.getColleges();
                                     Iterator<college> it = vd.iterator();
                                     
                                     while(it.hasNext())
                                    {
                                      college col = it.next();
     
                                  %>
                                
    
                                    
                                    <option value="<%= col.getCid() %>"><%= col.getCname() %></option>
                                 
                                <% }%>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a valid state.
                                </div>
                            </div>
                                  <div class="mb-3 mt-2">
                                <label for="enrollment" class="form-label">Email</label>
                                <input type="email" class="form-control" id="enrollment" title="enter correct email format"   name="email" pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$"  required>
                            </div>
                            <div class="mb-3">
                                <label for="college-name" class="form-label">Sem</label>
                                <select class="form-select" aria-label="Default select example" id="college-name" name="ssem" required>
                                    <option selected disabled value="">-select-</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                     <option value="5">5</option>
                                      <option value="6">6</option>
                                </select>
                            </div>  
                            <button type="submit" class="btn btn1">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
       
    </body>
</html>
