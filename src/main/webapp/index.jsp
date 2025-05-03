<%@ page import="java.util.*, com.movie.classes.Movie" %>
<%@ include file="header.jsp" %>

<%
    List<Movie> movieList = (List<Movie>) request.getAttribute("movieList");
%>

<div class="container mt-5">
    <div class="tv-frame mb-5">
        <div id="movieCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <%
                    if (movieList != null && !movieList.isEmpty()) {
                        for (int i = 0; i < movieList.size(); i++) {
                            Movie movie = movieList.get(i);
                %>
                <div class="carousel-item <%= (i == 0 ? "active" : "") %>">
                    <div class="row d-flex align-items-center text-white">
                        <div class="col-md-5">
                            <img src="<%= movie.getImageUrl() %>" class="d-block w-100 rounded" alt="<%= movie.getTitle() %> Poster">
                        </div>
                        <div class="col-md-7">
                            <h2><%= movie.getTitle() %></h2>
                            <p><%= movie.getDescription() %></p>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="carousel-item active">
                    <div class="text-white text-center p-5">
                        <h3>No movies available yet.</h3>
                    </div>
                </div>
                <%
                    }
                %>
            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#movieCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#movieCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>
    </div>

    <!-- Newsletter Signup -->
    <div class="newsletter">
        <form action="thankyou.jsp" method="post">
            <p>Join our newsletter for new releases:</p>
            Name: <input type="text" name="name" required /> &nbsp;
            Email: <input type="email" name="email" required />
            <br><br>
            <input type="submit" value="Sign Up" class="btn btn-primary mt-2"/>
        </form>
    </div>

</div>

<%@ include file="footer.jsp" %>

<style>
    .tv-frame {
        border: 12px solid black;
        border-radius: 30px;
        background: #2c2c2c;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.8);
        overflow: hidden;
        transition: box-shadow 0.3s ease-in-out;
    }

    .tv-frame:hover {
        box-shadow: 0 0 25px #0ff;
    }

    .carousel-item {
        padding: 30px;
    }

    .carousel img {
        max-height: 400px;
        object-fit: cover;
    }

    .carousel h2 {
        font-size: 2rem;
        margin-bottom: 15px;
    }

    .carousel p {
        font-size: 1.1rem;
    }
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
