<%-- 
    Document   : register
    Created on : Mar 30, 2025, 3:37:29 PM
    Author     : chadrobbins
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Robbins Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f5f5f5; }
        header { display: flex; align-items: center; padding: 20px; border-bottom: 3px solid #ccc; background-color: white; }
        .logo { height: 80px; margin-right: 20px; }
        nav a { margin: 0 15px; font-size: 1.3em; font-weight: bold; text-decoration: none; color: black; }
        nav a.active { color: blueviolet; }
        .form-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            background-color: white;
            border: 2px solid #ccc;
            border-radius: 10px;
        }
        .error { color: red; }
    </style>
</head>
<body>

<header>
    <img src="images/robbins-logo.png" class="logo" alt="Robbins Movies Logo"/>
    <h1>Robbins Movies</h1>
    <nav class="ms-auto">
        <a href="index.jsp" class="active">Home</a>
        <a href="browse.jsp">Browse Movies</a>
        <a href="checkout.jsp">Checkout</a>
  
        <%
    com.movie.classes.User loggedInUser = (com.movie.classes.User) session.getAttribute("user");
    if (loggedInUser != null) {
%>
    <span>Welcome, <%= loggedInUser.getName() %>!</span>
    <a href="logout.jsp" class="ms-2">Logout</a>
<%
    } else {
%>
    <a href="login.jsp">Login</a>
<%
    }
%>

    </nav>
</header>

<div class="form-container">
    <h3>Register</h3>
    <form action="user" method="post">
        <input type="hidden" name="action" value="register"/>
        <div class="mb-3">
            <label>Name:</label>
            <input type="text" name="name" class="form-control" required/>
        </div>
        <div class="mb-3">
            <label>Email:</label>
            <input type="email" name="email" class="form-control" required/>
        </div>
        <div class="mb-3">
            <label>Password:</label>
            <input type="password" name="password" class="form-control" required/>
        </div>
        <button type="submit" class="btn btn-success">Register</button>
    </form>
    <% if (request.getAttribute("error") != null) { %>
        <p class="error mt-2"><%= request.getAttribute("error") %></p>
    <% } %>
</div>

</body>
</html>
