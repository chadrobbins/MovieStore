<%-- 
    Document   : login
    Created on : Mar 30, 2025, 3:36:58 PM
    Author     : chadrobbins
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<h2 class="text-center mb-4">User Login</h2>

<div class="container" style="max-width: 500px;">
    <form method="post" action="user">
        <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" class="form-control" id="email" name="email" required />
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required />
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>

    <div class="mt-3">
        <p>Don't have an account? <a href="register.jsp">Register here</a>.</p>
    </div>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="alert alert-danger mt-3"><%= error %></div>
    <%
        }
    %>
</div>

<%@ include file="footer.jsp" %>
