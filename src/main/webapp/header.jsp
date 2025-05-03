<%-- 
    Document   : header
    Created on : Apr 5, 2025, 1:22:35 PM
    Author     : chadrobbins
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.movie.classes.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Robbins Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <style>
        title {
            color: white;
        }
        
        body {
            font-family: Arial, sans-serif;
            background-color: hsl(0, 0%, 96%);
        }
        header {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 3px solid #ccc;
            background-color: hsl(270, 40%, 25%);
            color: white;
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
        nav a:hover {
            text-decoration: underline;
        }

        nav a:active {
            color: hsl(45, 100%, 60%); 
        }

        nav a:visited {
            color: white; 
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
        <a href="home" class="active">Home</a>
        <a href="movies">Browse Movies</a>
        <a href="checkout.jsp">Checkout</a>
        <% 
            User loggedInUser = (User) session.getAttribute("user"); 
            if (loggedInUser != null && loggedInUser.isAdmin()) { 
        %>
            <a href="admin">Admin</a>
        <% 
            } 
        %>

        <% if (loggedInUser != null) { %>
            <span>Welcome, <%= loggedInUser.getName() %>!</span>
            <a href="logout.jsp" class="ms-2">Logout</a>
        <% } else { %>
            <a href="login.jsp">Login</a>
        <% } %>
    </nav>
</header>
