package com.movie.servlets;

import com.movie.classes.Movie;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("moviePU");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        try {
            String sortBy = request.getParameter("sort");
            String genre = request.getParameter("genre");

            List<Movie> movieList;

            if (genre != null && !genre.isEmpty()) {
                TypedQuery<Movie> query = em.createQuery(
                    "SELECT m FROM Movie m WHERE m.genre = :genre", Movie.class);
                query.setParameter("genre", genre);
                movieList = query.getResultList();
            } else {
                movieList = em.createQuery("SELECT m FROM Movie m", Movie.class).getResultList();
            }

            // Add sorting
            if (sortBy != null) {
                switch (sortBy) {
                    case "price":
                        movieList.sort(Comparator.comparingDouble(Movie::getPrice));
                        break;
                    case "rating":
                        movieList.sort(Comparator.comparingDouble(Movie::getRating).reversed());
                        break;
                    case "title":
                        movieList.sort(Comparator.comparing(Movie::getTitle));
                        break;
                }
            }

            request.setAttribute("movieList", movieList);
            request.getRequestDispatcher("browse.jsp").forward(request, response);

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
