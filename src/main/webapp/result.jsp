<%@include file="header.jsp" %>

<%@ page import="java.util.List, com.movie.classes.Movie" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Results</title>
</head>
<body>
    <div class="containter">
    <h2>Filtered Movies</h2>
    <ul>
        <%List<Movie> movies = (List<Movie>) request.getAttribute("movies");
            if (movies != null && !movies.isEmpty()) {
                for (Movie movie : movies) {
        %>
        <li>
            <strong><%= movie.getTitle() %></strong> - <%= movie.getSynopsis() %>
        </li>
        <%
                }
            } else {
        %>
        <p>No movies found for the selected genre.</p>
        <%
            }
        %>
    </ul>
    <a href="index.jsp">Go Back</a>
    </div>
</body>
</html>
