/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.movie.servlets;

/**
 *
 * @author chadrobbins
 */
// File: src/java/controller/CheckoutServlet.java

import com.movie.classes.Movie;
import com.movie.classes.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    
    private String jdbcURL = "jdbc:mysql://localhost:3306/movie_catalog";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Rdahc3392!";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String card = request.getParameter("card");
        String exp = request.getParameter("exp");
        String cvv = request.getParameter("cvv");

        HttpSession session = request.getSession();
        List<Movie> cart = (List<Movie>) session.getAttribute("cart");

        // Simple validation
        if (name == null || card == null || exp == null || cvv == null || cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Please complete all fields and add items to your cart.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // In a real app: save the order to DB, charge card, etc.

        // Clear cart after "purchase"
        session.removeAttribute("cart");

        // Store success message and name
        request.setAttribute("customerName", name);
        request.setAttribute("purchasedMovies", cart);

        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
        
        
        User user = (User) session.getAttribute("user");

if (user != null && cart != null && !cart.isEmpty()) {
    try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword)) {
        String sql = "INSERT INTO purchases (user_id, movie_id) VALUES (?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        for (Movie m : cart) {
            stmt.setInt(1, user.getId());
            stmt.setInt(2, m.getId());
            stmt.addBatch();
        }
        stmt.executeBatch();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    }
    
    
}


