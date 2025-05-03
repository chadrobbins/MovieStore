/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.movie.classes;

/**
 *
 * @author chadrobbins
 */
// File: src/java/model/User.java
import jakarta.persistence.*;


@NamedQueries({
    @NamedQuery(name = "User.findByEmailAndPassword",
                query = "SELECT u FROM User u WHERE u.email = :email AND u.password = :password")
})

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "password")
    private String password;
    
    @Column(name = "is_admin")
    private boolean isAdmin;

    @Transient
    private boolean loggedIn; // Not stored in DB — used for session tracking

    public User() {}

    public User(int id, String name, String email, String password) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // Getters and setters
    public int getId() { 
        return id; 
    }
    public void setId(int id) { 
        this.id = id; 
    }

    public String getName() { 
        return name; 
    }
    public void setName(String name) { 
        this.name = name; 
    }

    public String getEmail() { 
        return email; 
    }
    public void setEmail(String email) { 
        this.email = email; 
    }

    public String getPassword() { 
        return password; 
    }
    public void setPassword(String password) { 
        this.password = password; 
    }

    public boolean isLoggedIn() { 
        return loggedIn; 
    }
    public void setLoggedIn(boolean loggedIn) { 
        this.loggedIn = loggedIn; 
    }
    
    public boolean isAdmin() {
    return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
}