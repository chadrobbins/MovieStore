/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.movie.utils;

/**
 *
 * @author chadrobbins
 */

public class OMDbMovie {
    private String description;
    private double rating;
    private String imageUrl;

    // Constructor
    public OMDbMovie(String description, String imageUrl, double rating) {
        this.description = description;
        this.rating = rating;
        this.imageUrl = imageUrl;
    }

    // Getters
    public String getDescription() {
        return description;
    }

    public double getRating() {
        return rating;
    }

    public String getImageUrl() {
        return imageUrl;
    }
}
