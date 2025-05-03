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
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.movie.classes.Purchase;
import java.io.IOException;
import java.util.List;


@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("moviePU");
    }

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    System.out.println("🔵 CheckoutServlet POST called!"); 

    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    List<Movie> cart = (List<Movie>) session.getAttribute("cart");

    if (user != null && cart != null && !cart.isEmpty()) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            double total = 0.0;
            for (Movie movie : cart) {
                Movie dbMovie = em.find(Movie.class, movie.getId());

                if (dbMovie != null && dbMovie.getQuantity() > 0) {
                    dbMovie.setQuantity(dbMovie.getQuantity() - 1);
                    em.persist(new Purchase(user, dbMovie));
                    total += dbMovie.getPrice();
                    System.out.println("✅ Purchased movie: " + dbMovie.getTitle());
                } else {
                    System.out.println("⚠️ Movie not found or out of stock: " + movie.getTitle());
                }
            }

            tx.commit();
            System.out.println("✅ Transaction committed!");

            // Set confirmation data
            session.removeAttribute("cart");

            request.setAttribute("totalPrice", total);
            request.setAttribute("dueDate", java.time.LocalDate.now().plusDays(5).toString());
            request.setAttribute("purchasedMovies", cart);

            request.getRequestDispatcher("confirmation.jsp").forward(request, response);

        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            System.out.println("❌ ERROR during checkout: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Checkout failed", e);
        } finally {
            em.close();
        }
    } else {
        System.out.println("⚠️ User not logged in or cart is empty!");
        response.sendRedirect("checkout.jsp?error=missingData");
    }
}


    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
