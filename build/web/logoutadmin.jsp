<%-- 
    Document   : logoutadmin
    Created on : 12-Feb-2024, 4:31:40 pm
    Author     : admin
--%>

<%@page import="entity.admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
           <%
                  admin cd = (admin)session.getAttribute("adminlogin");
                  session.removeAttribute("adminlogin");
                  response.sendRedirect("./index.jsp");
        %> 
    </body>
</html>
