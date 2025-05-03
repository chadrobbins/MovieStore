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
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("moviePU");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String movieIdStr = request.getParameter("movieId");

        if (movieIdStr != null) {
            int movieId = Integer.parseInt(movieIdStr);

            EntityManager em = emf.createEntityManager();

            try {
                Movie movie = em.find(Movie.class, movieId);

                if (movie != null) {
                    HttpSession session = request.getSession();
                    List<Movie> cart = (List<Movie>) session.getAttribute("cart");

                    if (cart == null) {
                        cart = new ArrayList<>();
                    }

                    cart.add(movie);
                    session.setAttribute("cart", cart);
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                em.close();
            }
        }

        response.sendRedirect("movies"); // back to browse
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
