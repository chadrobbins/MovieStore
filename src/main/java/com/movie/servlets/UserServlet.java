/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.movie.servlets;

/**
 *
 * @author chadrobbins
 */
// File: src/java/controller/UserServlet.java

import com.movie.classes.User;
import javax.servlet.annotation.WebServlet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Simple hardcoded validation (replace with DB check if needed)
        if ("test@example.com".equals(email) && "password123".equals(password)) {
            User user = new User(1, "Test User", email);
            request.getSession().setAttribute("user", user);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
