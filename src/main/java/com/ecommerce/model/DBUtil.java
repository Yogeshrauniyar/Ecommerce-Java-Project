package com.ecommerce.model;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/ecommerce"; // Change the DB name if necessary
    private static final String USER = "root"; // Your DB username
    private static final String PASSWORD = "Simra2009#"; // Your DB password

    // Method to establish and return a database connection
    public static Connection getConnection() throws SQLException {
        try {
            // Load the MySQL driver (optional for newer JDBC versions)
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Database connection error", e);
        }
    }
}
