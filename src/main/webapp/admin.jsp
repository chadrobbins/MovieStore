<%-- 
    Document   : admin
    Created on : Apr 5, 2025, 1:05:26?PM
    Author     : chadrobbins
--%>


<%@ page import="java.util.*, com.movie.classes.Movie" %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2>Add New Movie</h2>
    
    <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">Movie successfully added!</div>
    <% } %>

    <form action="admin" method="post" class="mb-5">
        <div class="mb-3">
            <label for="title" class="form-label">Movie Title</label>
            <input type="text" class="form-control" id="title" name="title" required/>
        </div>
        <div class="mb-3">
            <label for="genre" class="form-label">Genre</label>
            <input type="text" class="form-control" id="genre" name="genre" required/>
        </div>
        <div class="mb-3">
            <label for="price" class="form-label">Price ($)</label>
            <input type="number" step="0.01" class="form-control" id="price" name="price" required/>
        </div>
        <div class="mb-3">
            <label for="quantity" class="form-label">Quantity</label>
            <input type="number" class="form-control" id="quantity" name="quantity" required/>
        </div>
        <button type="submit" class="btn btn-primary">Add Movie</button>
    </form>

    <h3>Current Movies</h3>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>Title</th>
                <th>Price</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Movie> movieList = (List<Movie>) request.getAttribute("movieList");
                if (movieList != null && !movieList.isEmpty()) {
                    for (Movie movie : movieList) {
            %>
                <tr>
                    <td><%= movie.getTitle() %></td>
                    <td>$<%= String.format("%.2f", movie.getPrice()) %></td>
                    <td><%= movie.getQuantity() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="3" class="text-center">No movies available yet.</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

<%@ include file="footer.jsp" %>