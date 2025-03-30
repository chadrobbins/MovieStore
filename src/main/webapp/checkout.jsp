<%-- 
    Document   : checkout
    Created on : Mar 30, 2025, 3:18:06 PM
    Author     : chadrobbins
--%>

<%@ page import="java.util.*, com.movie.classes.Movie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Robbins Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <style>
        body { font-family: Arial, sans-serif; }
        header { display: flex; align-items: center; padding: 20px; border-bottom: 3px solid #ccc; }
        .logo { height: 80px; margin-right: 20px; }
        nav a { margin: 0 15px; font-size: 1.3em; font-weight: bold; text-decoration: none; color: black; }
        nav a.active { color: blueviolet; }
        .checkout-container {
            display: flex;
            justify-content: space-between;
            padding: 30px;
        }
        .payment-form {
            width: 45%;
        }
        .receipt {
            width: 45%;
            border: 3px solid black;
            padding: 20px;
        }
        .receipt h4 {
            text-align: center;
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }
    </style>
</head>
<body>

<header>
    <img src="images/robbins-logo.png" class="logo" alt="Robbins Movies Logo"/>
    <h1>Robbins Movies</h1>
    <nav class="ms-auto">
        <a href="index.jsp">Home</a>
        <a href="browse.jsp">Browse Movies</a>
        <a href="checkout.jsp"  class="active">Checkout</a>
  
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

<div class="checkout-container">
    <div class="payment-form">
        <form action="checkout" method="post">
            <label>Name on Card:</label><br/>
            <input type="text" name="name" class="form-control mb-2" required/><br/>
            <label>Card Number:</label><br/>
            <input type="text" name="card" class="form-control mb-2" required/><br/>
            <label>Expiration Date:</label><br/>
            <input type="text" name="exp" class="form-control mb-2" required/><br/>
            <label>CVV:</label><br/>
            <input type="text" name="cvv" class="form-control mb-2" required/><br/>
            <button type="submit" class="btn btn-success">Complete Purchase</button>
        </form>
    </div>

    <div class="receipt">
        <h4>Receipt</h4>
        <%
            List<Movie> cart = (List<Movie>) session.getAttribute("cart");
            double total = 0;
            if (cart != null && !cart.isEmpty()) {
                for (Movie movie : cart) {
                    out.println("<p><strong>" + movie.getTitle() + "</strong> - $" + movie.getPrice() + "</p>");
                    total += movie.getPrice();
                }
                out.println("<hr><p><strong>Total:</strong> $" + String.format("%.2f", total) + "</p>");
            } else {
                out.println("<p>Your cart is empty.</p>");
            }
        %>
    </div>
</div>

<footer class="text-center mt-4 p-3 border-top">
    <small>Copyright 2025 Robbins Movies</small>
</footer>

</body>
</html>
