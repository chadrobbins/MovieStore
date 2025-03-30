<%-- 
    Document   : history
    Created on : Mar 30, 2025, 3:48:17 PM
    Author     : chadrobbins
--%>

<%@page import="com.movie.classes.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.movie.classes.Movie"%>
<%@ page import="java.util.*, com.movie.classes.Movie, com.movie.classes.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Purchase History - Robbins Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
    <style>
        body { font-family: Arial; }
        header { display: flex; align-items: center; padding: 20px; border-bottom: 3px solid #ccc; }
        .logo { height: 80px; margin-right: 20px; }
        nav a { margin: 0 15px; font-size: 1.3em; text-decoration: none; font-weight: bold; color: black; }
        nav a.active { color: blueviolet; }
        .history-box {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
        }
    </style>
</head>
<body>

<header>
    <img src="images/robbins-logo.png" class="logo" alt="Robbins Movies Logo"/>
    <h1>Robbins Movies</h1>
    <nav class="ms-auto">
        <a href="index.jsp">Home</a>
        <a href="movies">Browse Movies</a>
        <a href="checkout.jsp">Checkout</a>
        <a href="history.jsp" class="active">My Movies</a>
        <a href="logout.jsp">Logout</a>
    </nav>
</header>

<div class="history-box">
    <h3>Your Past Purchases</h3>
    <ul class="list-group">
        <%
            List<Movie> history = new ArrayList<>();
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movie_store", "root", "your_password");
                String sql = "SELECT m.* FROM movies m JOIN purchases p ON m.id = p.movie_id WHERE p.user_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, user.getId());
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Movie m = new Movie(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("genre"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getDouble("rating")
                    );
                    history.add(m);
                }

                conn.close();
            } catch (Exception e) {
                out.println("<p>Error loading history.</p>");
                e.printStackTrace();
            }

            if (history.isEmpty()) {
                out.println("<li class='list-group-item'>You haven’t purchased anything yet.</li>");
            } else {
                for (Movie m : history) {
        %>
        <li class="list-group-item">
            <strong><%= m.getTitle() %></strong> — <%= m.getGenre() %>
        </li>
        <%
                }
            }
        %>
    </ul>
</div>
    
<!-- Recommendations Section -->
<div class="mt-5">
    <h4>Recommended For You</h4>
    <div class="row">
        <%
            Map<String, Integer> genreCount = new HashMap<>();
            for (Movie m : history) {
                genreCount.put(m.getGenre(), genreCount.getOrDefault(m.getGenre(), 0) + 1);
            }

            String topGenre = null;
            int maxCount = 0;
            for (Map.Entry<String, Integer> entry : genreCount.entrySet()) {
                if (entry.getValue() > maxCount) {
                    topGenre = entry.getKey();
                    maxCount = entry.getValue();
                }
            }

            if (topGenre != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/movie_store", "root", "your_password");

                    String sql = "SELECT * FROM movies WHERE genre = ? AND id NOT IN " +
                                 "(SELECT movie_id FROM purchases WHERE user_id = ?) LIMIT 3";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, topGenre);
                    stmt.setInt(2, user.getId());
                    ResultSet rs = stmt.executeQuery();

                    boolean hasRecs = false;
                    while (rs.next()) {
                        hasRecs = true;
        %>
        <div class="col-md-4 text-center mb-4">
            <img src="<%= rs.getString("image_url") %>" class="img-fluid mb-2" style="max-height: 200px;" />
            <h5><%= rs.getString("title") %></h5>
            <p><%= rs.getString("description") %></p>
        </div>
        <%
                    }
                    if (!hasRecs) {
                        out.println("<p>No new recommendations right now.</p>");
                    }

                    conn.close();
                } catch (Exception e) {
                    out.println("<p>Error loading recommendations.</p>");
                    e.printStackTrace();
                }
            } else {
                out.println("<p>No purchase history to recommend from.</p>");
            }
        %>
    </div>
</div>

</body>
</html>

