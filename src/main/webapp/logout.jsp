<%-- 
    Document   : logout
    Created on : Mar 30, 2025, 3:37:55?PM
    Author     : chadrobbins
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>



<%
    if (session != null) {
        session.invalidate();
    }
    response.sendRedirect("home");
%>

<%@ include file="footer.jsp" %>