<%-- 
    Document   : visitorlogout
    Created on : 15-Feb-2024, 4:48:13 pm
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
     <% 
     
     session.removeAttribute("visitorlogin");
     response.sendRedirect("./index.jsp");
     
     %>
    </body>
</html>
