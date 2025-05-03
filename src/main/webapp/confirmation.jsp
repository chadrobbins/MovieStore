<%-- 
    Document   : confirmation
    Created on : Mar 30, 2025, 3:33:33?PM
    Author     : chadrobbins
--%>



<%@ page import="java.util.*, com.movie.classes.Movie" %>
<%@ include file="header.jsp" %>

<div class="container text-center mt-5">
    <h2>Thank you for your purchase!</h2>

    <h4 class="mt-4">Rental Summary:</h4>

    <%
        List<Movie> purchased = (List<Movie>) request.getAttribute("purchasedMovies");
        Double totalPrice = (Double) request.getAttribute("totalPrice");
        String dueDate = (String) request.getAttribute("dueDate");
    %>

    <% if (purchased != null && !purchased.isEmpty()) { %>
    <table class="table table-striped mt-4">
        <thead>
            <tr>
                <th>Movie Title</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
            <% 
                for (Movie movie : purchased) { 
            %>
            <tr>
                <td><%= movie.getTitle() %></td>
                <td>$<%= String.format("%.2f", movie.getPrice()) %></td>
            </tr>
            <% 
                }
            %>
            <tr>
                <th>Grand Total</th>
                <th>$<%= String.format("%.2f", totalPrice) %></th>
            </tr>
        </tbody>
    </table>

    <h5 class="mt-4">Return Due Date: <strong><%= dueDate %></strong></h5>

    <% } else { %>
        <div class="alert alert-warning">No purchase details available.</div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
