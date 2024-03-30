<%-- 
    Document   : logoutcollegeadmin
    Created on : 10-Feb-2024, 3:07:56 pm
    Author     : admin
--%>

<%@page import="entity.collegeadmin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
                  collegeadmin cd = (collegeadmin)session.getAttribute("collegeadmin");
                  session.removeAttribute("collegeadmin");
                  response.sendRedirect("./index.jsp");
        %> 
    </body>
</html>
