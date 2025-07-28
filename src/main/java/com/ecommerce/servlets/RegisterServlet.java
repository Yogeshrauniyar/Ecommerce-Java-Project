package com.ecommerce.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecommerce.db.DBConnection;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        // ✅ Validation using regex
        String nameRegex = "^[A-Za-z\\s]+$"; // Alphabets and spaces
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$"; // Email format

        if (name.isEmpty() || !name.matches(nameRegex)) {
            response.sendRedirect("register.jsp?error=invalid_name");
            return;
        }
        if (email.isEmpty() || !email.matches(emailRegex)) {
            response.sendRedirect("register.jsp?error=invalid_email");
            return;
        }
        if (password.isEmpty() || password.length() < 6) {
            response.sendRedirect("register.jsp?error=short_password");
            return;
        }

        // ✅ Database Insertion
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, password);
                int rows = stmt.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("success.jsp");
                } else {
                    response.sendRedirect("register.jsp?error=failed");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=db_error");
        }
    }
}
