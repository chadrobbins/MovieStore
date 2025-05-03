<%-- 
    Document   : checkout
    Created on : Mar 30, 2025, 3:18:06 PM
    Author     : chadrobbins
--%>
<%@ page import="java.util.*, com.movie.classes.Movie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<h2 class="text-center mb-4">Checkout</h2>

<div class="container">
<%
    String errorParam = request.getParameter("error");
    if ("missingData".equals(errorParam)) {
%>
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <strong>Oops!</strong> You must be <a href="login.jsp" class="alert-link">logged in</a> to complete checkout.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
    }
%>


    <%
        List<Movie> cart = (List<Movie>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
    %>
        <div class="alert alert-info">Your cart is currently empty.</div>
    <%
        } else {
            double total = 0;
    %>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Movie movie : cart) {
                    total += movie.getPrice();
            %>
                <tr>
                    <td><%= movie.getTitle() %></td>
                    <td>$<%= String.format("%.2f", movie.getPrice()) %></td>
                </tr>
            <%
                }
            %>
                <tr>
                    <th>Total</th>
                    <th>$<%= String.format("%.2f", total) %></th>
                </tr>
            </tbody>
        </table>

        <h4 class="mt-4">Payment Details</h4>
        <form method="post" action="checkout">
            <div class="mb-3">
                <label for="cardNumber" class="form-label">Card Number</label>
                <input type="text" class="form-control" id="cardNumber" name="cardNumber" required>
            </div>
            <div class="mb-3">
                <label for="phoneNumber" class="form-label">Phone Number</label>
                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
            </div>

            <button type="submit" class="btn btn-success">Complete Checkout</button>
        </form>

    <%
        }
    %>
</div>

<%@ include file="footer.jsp" %>
