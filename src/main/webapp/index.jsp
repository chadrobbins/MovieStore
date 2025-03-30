<%@ page import="java.util.*, com.movie.classes.Movie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Robbins Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff;
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
            text-decoration: none;
            font-weight: bold;
            color: black;
        }
        nav a.active {
            color: blueviolet;
        }
        .tv-frame {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 40px auto;
            border: 8px solid black;
            padding: 20px;
            width: 900px;
            height: 500px;
            background: url('images/tv_frame.png') no-repeat center center;
            background-size: contain;
            position: relative;
        }
        .slideshow {
            width: 80%;
            height: 100%;
            padding: 20px;
            background: white;
            overflow: hidden;
            text-align: center;
        }
        .carousel-item img {
            max-height: 250px;
            margin-bottom: 15px;
        }
        .btn-cart {
            background-color: #4CAF50;
            color: white;
            border: none;
        }
        .newsletter {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            border-top: 2px solid #ccc;
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

<!-- Movie Slideshow Area -->
<div class="tv-frame">
    <div id="carouselMovies" class="carousel slide slideshow" data-bs-ride="carousel">
        <div class="carousel-inner">
<%
    List<Movie> movieList = (List<Movie>) request.getAttribute("movieList");
    int slideIndex = 0;
    if (movieList != null) {
        for (Movie movie : movieList) {
%>
            <div class="carousel-item <%= (slideIndex == 0 ? "active" : "") %>">
                <img src="<%= movie.getImageUrl() %>" alt="Poster for <%= movie.getTitle() %>" class="img-fluid"/>
                <div class="carousel-caption d-none d-md-block">
                    <h5><%= movie.getTitle() %></h5>
                    <p><%= movie.getDescription() %></p>
                </div>
            </div>
<%
            slideIndex++;
        }
    } else {
%>
        <div class="alert alert-warning">No movies to show.</div>
<%
    }
%>

        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselMovies" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselMovies" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</div>

<!-- Newsletter Signup -->
<div class="newsletter">
    <p>Join our newsletter for new releases: &nbsp; 
        Name: <input type="text" name="name" /> &nbsp;
        Email: <input type="email" name="email" />
    </p>
    <small>Copyright 2025 Robbins Movies</small>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
