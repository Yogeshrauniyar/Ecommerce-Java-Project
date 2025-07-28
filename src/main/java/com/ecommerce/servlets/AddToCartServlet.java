package com.ecommerce.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecommerce.db.DBConnection;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Parse product ID from request
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null || productIdParam.isEmpty()) {
            response.sendRedirect("error.jsp");  // Optional error page
            return;
        }

        int productId = Integer.parseInt(productIdParam);

        // Get session and cart
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        // Fetch product from DB
        Product product = getProductById(productId);
        if (product != null) {
            boolean found = false;

            // Check if the product is already in the cart
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    int newQuantity = item.getQuantity() + 1;

                    // Check if there is enough stock for the new quantity
                    if (product.getStock() >= newQuantity) {
                        item.setQuantity(newQuantity);
                        found = true;
                    } else {
                        request.setAttribute("errorMessage", "Not enough stock available.");
                    }
                    break;
                }
            }

            // If not found in cart, add it
            if (!found) {
                if (product.getStock() > 0) {
                    cart.add(new CartItem(product, 1));
                } else {
                    request.setAttribute("errorMessage", "Product is out of stock.");
                }
            }

            session.setAttribute("cart", cart);
        }

        // Redirect to cart or wherever needed
        response.sendRedirect("cart.jsp");
    }

    // Fetch product from DB using productId
    private Product getProductById(int productId) {
        Product product = null;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getString("image_url"),
                    rs.getDouble("price"),
                    rs.getInt("stock")  // Including stock field
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logger in real applications
        }

        return product;
    }
}
