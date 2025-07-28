package com.ecommerce.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        switch (action) {
            case "add":
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                Product product = getProductById(productId);

                if (product != null) {
                    // Check if there's enough stock
                    if (product.getStock() >= quantity) {
                        boolean found = false;
                        for (CartItem item : cart) {
                            if (item.getProduct().getId() == productId) {
                                item.setQuantity(item.getQuantity() + quantity);
                                found = true;
                                break;
                            }
                        }

                        if (!found) {
                            cart.add(new CartItem(product, quantity));
                        }
                    } else {
                        request.setAttribute("errorMessage", "Not enough stock available.");
                    }
                }
                break;

            case "remove":
                cart.removeIf(item -> item.getProduct().getId() == productId);
                break;

            case "update":
                int newQty = Integer.parseInt(request.getParameter("quantity"));
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == productId) {
                        Product updatedProduct = getProductById(productId);

                        // Ensure that updated quantity does not exceed stock
                        if (updatedProduct != null && updatedProduct.getStock() >= newQty) {
                            item.setQuantity(newQty);
                        } else {
                            request.setAttribute("errorMessage", "Not enough stock available.");
                        }
                        break;
                    }
                }
                break;
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }

    private Product getProductById(int id) {
        Product product = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM products WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                product = new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getString("image_url"),
                        rs.getDouble("price"),
                        rs.getInt("stock") // Include stock field
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
}
