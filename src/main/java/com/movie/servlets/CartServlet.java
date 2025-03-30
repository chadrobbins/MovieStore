/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.movie.servlets;

/**
 *
 * @author chadrobbins
 */

import com.movie.classes.Movie;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private String jdbcURL = "jdbc:mysql://localhost:3306/movie_scatalog";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Rdahc3392!";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        Movie selectedMovie = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
                String sql = "SELECT * FROM movies WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, movieId);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    selectedMovie = new Movie(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("genre"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("image_url"),
                        rs.getDouble("rating")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        List<Movie> cart = (List<Movie>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        cart.add(selectedMovie);
        session.setAttribute("cart", cart);

        response.sendRedirect("checkout.jsp");
    }
}
