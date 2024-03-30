<%-- 
    Document   : studentlogout.jsp
    Created on : 14-Feb-2024, 4:39:25 pm
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
        
            session.removeAttribute("loginstudent");
                  response.sendRedirect("./index.jsp");
        %>
    </body>
</html>
