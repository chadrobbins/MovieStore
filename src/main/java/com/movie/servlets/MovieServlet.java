package com.movie.servlets;

// File: src/java/controller/MovieServlet.java
// File: src/java/controller/MovieServlet.java


import com.movie.classes.Movie;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {

    private String jdbcURL = "jdbc:mysql://localhost:3306/movie_catalog";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Rdahc3392!"; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String genre = request.getParameter("genre");
        String sort = request.getParameter("sort");
        String search = request.getParameter("search");

        List<Movie> movieList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                StringBuilder sql = new StringBuilder("SELECT * FROM movies WHERE 1=1");

                if (genre != null && !genre.isEmpty()) {
                    sql.append(" AND genre = ?");
                }

                if (search != null && !search.isEmpty()) {
                    sql.append(" AND LOWER(title) LIKE ?");
                }

                if ("rating".equals(sort)) {
                    sql.append(" ORDER BY rating DESC");
                } else if ("price".equals(sort)) {
                    sql.append(" ORDER BY price ASC");
                }

                PreparedStatement statement = connection.prepareStatement(sql.toString());

                int paramIndex = 1;
                if (genre != null && !genre.isEmpty()) {
                    statement.setString(paramIndex++, genre);
                }

                if (search != null && !search.isEmpty()) {
                    statement.setString(paramIndex, "%" + search.toLowerCase() + "%");
                }

                ResultSet result = statement.executeQuery();

                while (result.next()) {
                    Movie movie = new Movie(
                        result.getInt("id"),
                        result.getString("title"),
                        result.getString("genre"),
                        result.getString("description"),
                        result.getDouble("price"),
                        result.getString("image_url"),
                        result.getDouble("rating")
                    );
                    movieList.add(movie);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("movieList", movieList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("browse.jsp");
        dispatcher.forward(request, response);
    }
}
