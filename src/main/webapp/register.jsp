<%-- 
    Document   : register
    Created on : Mar 30, 2025, 3:37:29 PM
    Author     : chadrobbins
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<h2 class="text-center mb-4">Create an Account</h2>

<div class="container" style="max-width: 500px;">
    <form method="post" action="register">
        <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" name="name" id="name" required />
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" class="form-control" name="email" id="email" required />
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" id="password" required />
        </div>
        <button type="submit" class="btn btn-primary">Register</button>
    </form>

    <div class="mt-3">
        <p>Already have an account? <a href="login.jsp">Login here</a>.</p>
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
