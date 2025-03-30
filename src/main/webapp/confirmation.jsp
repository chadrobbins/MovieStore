<%-- 
    Document   : confirmation
    Created on : Mar 30, 2025, 3:33:33 PM
    Author     : chadrobbins
--%>

<%@ page import="java.util.*, com.movie.classes.Movie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation - Robbins Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        header {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 3px solid #ccc;
            background-color: white;
        }
        .logo {
            height: 80px;
            margin-right: 20px;
        }
        nav a {
            margin: 0 15px;
            font-size: 1.3em;
            text-decoration: none;
            font-weight: bold;
            color: black;
        }
        .confirmation-box {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            background-color: white;
            border: 2px solid #28a745;
            border-radius: 8px;
        }
        .confirmation-box h2 {
            color: #28a745;
        }
        footer {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            border-top: 2px solid #ccc;
            background-color: white;
        }
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

<div class="confirmation-box text-center">
    <h2>Thank You, <%= request.getAttribute("customerName") %>!</h2>
    <p>Your purchase was successful. Here's your receipt:</p>
    <hr/>
    <ul class="list-group">
        <%
            List<Movie> purchased = (List<Movie>) request.getAttribute("purchasedMovies");
            double total = 0;
            if (purchased != null) {
                for (Movie movie : purchased) {
                    total += movie.getPrice();
        %>
            <li class="list-group-item d-flex justify-content-between">
                <%= movie.getTitle() %>
                <span>$<%= String.format("%.2f", movie.getPrice()) %></span>
            </li>
        <%
                }
            }
        %>
        <li class="list-group-item d-flex justify-content-between fw-bold">
            Total
            <span>$<%= String.format("%.2f", total) %></span>
        </li>
    </ul>
    <p class="mt-4">Enjoy your movies!</p>
    <a href="index.jsp" class="btn btn-primary mt-3">Back to Home</a>
</div>

<footer>
    <small>&copy; 2025 Robbins Movies</small>
</footer>

</body>
</html>
