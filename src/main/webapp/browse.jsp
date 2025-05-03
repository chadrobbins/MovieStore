<%-- 
    Document   : browse
    Created on : Mar 30, 2025, 3:13:24 PM
    Author     : chadrobbins
--%>

<%@ page import="java.util.*, com.movie.classes.Movie" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<div class="container mt-4">
    <h2 class="text-center mb-4">Browse Movies</h2>

    <form method="get" action="movies" class="d-flex align-items-end gap-3 mb-4">
    <div>
        <label class="form-label mb-1">Sort By:</label>
        <select name="sort" class="form-select">
            <option value="">Sort by</option>
            <option value="price" <%= "price".equals(request.getParameter("sort")) ? "selected" : "" %>>Price</option>
            <option value="rating" <%= "rating".equals(request.getParameter("sort")) ? "selected" : "" %>>Rating</option>
            <option value="title" <%= "title".equals(request.getParameter("sort")) ? "selected" : "" %>>Title A-Z</option>
        </select>
    </div>

    <div>
        <label class="form-label mb-1">Genre:</label>
        <select name="genre" class="form-select">
            <option value="">All Genres</option>
            <option value="Action" <%= "Action".equals(request.getParameter("genre")) ? "selected" : "" %>>Action</option>
            <option value="Comedy" <%= "Comedy".equals(request.getParameter("genre")) ? "selected" : "" %>>Comedy</option>
            <option value="Drama" <%= "Drama".equals(request.getParameter("genre")) ? "selected" : "" %>>Drama</option>
            <option value="Animation" <%= "Animation".equals(request.getParameter("genre")) ? "selected" : "" %>>Animation</option>
            <option value="Fantasy" <%= "Fantasy".equals(request.getParameter("genre")) ? "selected" : "" %>>Fantasy</option>
            <option value="Musical" <%= "Musical".equals(request.getParameter("genre")) ? "selected" : "" %>>Musical</option>
            <option value="Horror" <%= "Horror".equals(request.getParameter("genre")) ? "selected" : "" %>>Horror</option>
        </select>
    </div>

    <div>
        <button type="submit" class="btn btn-primary mt-4">Apply</button>
    </div>
</form>

    <div class="row">
        <%
            List<Movie> movieList = (List<Movie>) request.getAttribute("movieList");
            if (movieList != null) {
                for (Movie movie : movieList) {
                    if (movie.getQuantity() > 0) {  // Only show movies with quantity > 0
        %>
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <img src="<%= movie.getImageUrl() %>" class="card-img-top" alt="<%= movie.getTitle() %> Poster" style="height: 300px; object-fit: cover;">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title"><%= movie.getTitle() %></h5>
                        <p class="card-text"><strong>Genre:</strong> <%= movie.getGenre() %></p>
                        <p class="card-text"><strong>Price:</strong> $<%= String.format("%.2f", movie.getPrice()) %></p>
                        <p class="card-text"><strong>Rating:</strong> <%= movie.getRating() %>/10</p>

                        <form method="post" action="cart" class="mt-auto">
                            <input type="hidden" name="movieId" value="<%= movie.getId() %>">
                            <button type="submit" class="btn btn-primary w-100">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </div>
        <%
                    }
                }
            } else {
        %>
            <div class="alert alert-warning text-center">
                No movies available at this time.
            </div>
        <%
            }
        %>
    </div>
</div>

<%@ include file="footer.jsp" %>
