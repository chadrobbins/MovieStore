/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.movie.classes;

/**
 *
 * @author chadrobbins
 */


public class Movie {
    private int id;
    private String title;
    private String genre;
    private String description;
    private double price;
    private String imageUrl;
    private double rating;

    public Movie() {}

    public Movie(int id, String title, String genre, String description, double price, String imageUrl, double rating) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.rating = rating;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
}
