package com.movie.utils;

import java.io.BufferedReader;
import org.json.JSONObject;


import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;


public class OMDbAPIClient {

    private static final String API_KEY = "efbc8421"; 
    
    public OMDbMovie fetchMovieData(String title) {
    try {
        String urlStr = "https://www.omdbapi.com/?apikey=" + API_KEY + "&t=" + URLEncoder.encode(title, "UTF-8");
        URL url = new URL(urlStr);
        System.out.println("OMDb API Request: " + urlStr);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        JSONObject json = new JSONObject(response.toString());

        if (json.getBoolean("Response")) {
            String plot = json.optString("Plot", "No description available.");
            String poster = json.optString("Poster", "images/default.png");
            double rating = 0.0;
            try {
                rating = Double.parseDouble(json.optString("imdbRating", "0.0"));
            } catch (NumberFormatException ignore) {}

            return new OMDbMovie(plot, poster, rating);
        } else {
            System.out.println("OMDb Error: " + json.optString("Error"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return new OMDbMovie("No description available.", "images/default.png", 0.0);
}

}
