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
import com.movie.classes.User;
import com.movie.utils.OMDbAPIClient;
import com.movie.utils.OMDbMovie;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("moviePU");
    }

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user == null || !user.isAdmin()) {
        response.sendRedirect("login.jsp");
        return;
    }

    EntityManager em = emf.createEntityManager();
    try {
        List<Movie> movieList = em.createQuery("SELECT m FROM Movie m", Movie.class).getResultList();
        request.setAttribute("movieList", movieList);
    } finally {
        em.close();
    }

    request.getRequestDispatcher("admin.jsp").forward(request, response);
}


 @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    EntityManager em = emf.createEntityManager();
    EntityTransaction tx = em.getTransaction();

    try {
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        OMDbAPIClient client = new OMDbAPIClient();
        OMDbMovie movieInfo = client.fetchMovieData(title);

        Movie movie = new Movie();
        movie.setTitle(title);
        movie.setGenre(genre);
        movie.setPrice(price);
        movie.setQuantity(quantity);

        if (movieInfo != null) {
            movie.setRating(movieInfo.getRating());
            movie.setDescription(movieInfo.getDescription());
            movie.setImageUrl(movieInfo.getImageUrl());
        } else {
            movie.setRating(0.0);
            movie.setDescription("No description available.");
            movie.setImageUrl("images/default.png");
        }

        tx.begin();
        em.persist(movie);
        tx.commit();

        
        response.sendRedirect("admin?success=true");

    } catch (Exception e) {
        if (tx.isActive()) tx.rollback();
        e.printStackTrace();
        throw new ServletException("Error saving movie", e);
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
