<%-- 
    Document   : browse
    Created on : Mar 30, 2025, 3:13:24 PM
    Author     : chadrobbins
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.movie.classes.Movie" %>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Movies - Robbins Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        header {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 3px solid #ccc;
        }
        .logo {
            height: 80px;
            margin-right: 20px;
        }
        nav a {
            margin: 0 15px;
            font-size: 1.3em;
            font-weight: bold;
            text-decoration: none;
            color: black;
        }
        nav a.active {
            color: blueviolet;
        }
        .container {
            padding: 30px;
        }
        .movie-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .movie-card {
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
            text-align: center;
            background-color: #f9f9f9;
        }
        .movie-card img {
            max-width: 100%;
            height: 300px;
            object-fit: cover;
        }
    </style>
</head>
<body>

<header>
    <img src="images/robbins-logo.png" class="logo" alt="Robbins Movies Logo"/>
    <h1>Robbins Movies</h1>
    <nav class="ms-auto">
        <a href="index.jsp">Home</a>
        <a href="movies" class="active">Browse Movies</a>
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

<div class="container">
    <h2>Browse Movies</h2>
    <div class="movie-grid">
        <%
            List<Movie> movieList = (List<Movie>) request.getAttribute("movieList");
            if (movieList != null) {
                for (Movie movie : movieList) {
        %>
            <div class="movie-card" data-genre="<%= movie.getGenre() %>" data-title="<%= movie.getTitle().toLowerCase() %>">
                <img src="<%= movie.getImageUrl() %>" alt="<%= movie.getTitle() %> Poster"/>
                <h5><%= movie.getTitle() %></h5>
                <p><%= movie.getDescription() %></p>
                <p><strong>$<%= movie.getPrice() %></strong></p>
                <p>⭐ <%= movie.getRating() %></p>
            </div>
        <%
                }
            } else {
        %>
            <p>No movies available at the moment.</p>
        <%
            }
        %>
    </div>
</div>

</body>
</html>
