package com.ecommerce.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecommerce.db.DBConnection;
import com.ecommerce.model.Product;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Handle GET request (fetching products)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Redirect to login if user is not authenticated
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=unauthorized");
            return;
        }

        ArrayList<Product> products = new ArrayList<>();
        String category = request.getParameter("category");

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM products";
            if (category != null && !category.trim().isEmpty()) {
                sql += " WHERE category = ?";
            }

            PreparedStatement stmt = conn.prepareStatement(sql);

            if (category != null && !category.trim().isEmpty()) {
                stmt.setString(1, category);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                );
                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to fetch products from the database.");
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    // Handle POST request (adding a new product)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String imageUrl = request.getParameter("imageUrl");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Product newProduct = new Product(0, name, category, imageUrl, price, stock); // Default ID as 0
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO products (name, category, image_url, price, stock) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setString(3, imageUrl);
            stmt.setDouble(4, price);
            stmt.setInt(5, stock);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to add product to the database.");
        }

        // Redirect to dashboard after adding the product
        response.sendRedirect("dashboard");
    }
}
