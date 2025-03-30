<%-- 
    Document   : logout
    Created on : Mar 30, 2025, 3:37:55?PM
    Author     : chadrobbins
--%>

<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate(); // Destroys session and logs out user
    }
    response.sendRedirect("index.jsp");
%>

