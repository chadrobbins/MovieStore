/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.movie.servlets;

/**
 *
 * @author chadrobbins
 */


import com.movie.classes.User;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("moviePU");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        EntityManager em = emf.createEntityManager();

        try {
            // Check if the user already exists
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);
            if (!query.getResultList().isEmpty()) {
                request.setAttribute("error", "An account with this email already exists.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Create and persist new user
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);

            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();

            // Auto login and redirect to home
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("home");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error registering user.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
