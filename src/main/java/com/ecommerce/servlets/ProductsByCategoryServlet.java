package com.ecommerce.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecommerce.model.Product;

@WebServlet("/category")
public class ProductsByCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        List<Product> products = new ArrayList<>();

        // ✅ Validate category
        if (category != null && !category.isEmpty()) {
            switch (category.toLowerCase()) {
                case "laptops":
                    products.add(new Product(1, "MacBook Pro", "laptops", "assets/macbook.jpg", 1599.99, 10)); // Added stock
                    products.add(new Product(2, "HP Pavilion", "laptops", "assets/laptop.jpg", 849.50, 15)); // Added stock
                    products.add(new Product(3, "Dell XPS", "laptops", "assets/macbook.jpg", 1199.00, 20)); // Added stock
                    break;

                case "mobiles":
                    products.add(new Product(4, "iPhone 14", "mobiles", "assets/iphone.jpg", 999.00, 30)); // Added stock
                    products.add(new Product(5, "Samsung Galaxy S23", "mobiles", "assets/mobile.jpg", 899.00, 25)); // Added stock
                    products.add(new Product(6, "OnePlus 11", "mobiles", "assets/mobile.jpg", 699.99, 40)); // Added stock
                    break;

                case "accessories":
                    products.add(new Product(7, "Noise Smartwatch", "accessories", "assets/smartwatch.jpg", 199.99, 50)); // Added stock
                    products.add(new Product(8, "Bluetooth Speaker", "accessories", "assets/accessories.jpg", 79.99, 100)); // Added stock
                    products.add(new Product(9, "AirPods Pro", "accessories", "assets/accessories.jpg", 249.00, 30)); // Added stock
                    break;

                case "home decor":
                    products.add(new Product(10, "Wall Art", "home decor", "assets/wallart.jpg", 129.99, 10)); // Added stock
                    products.add(new Product(11, "Table Lamp", "home decor", "assets/home-decor.jpg", 49.99, 15)); // Added stock
                    products.add(new Product(12, "Photo Frame", "home decor", "assets/home-decor.jpg", 19.99, 50)); // Added stock
                    break;

                default:
                    // Optional: set an error message or leave products empty
                    break;
            }
        }

        // ✅ Set data for the JSP
        request.setAttribute("products", products);
        request.setAttribute("selectedCategory", category);

        // ✅ Forward to the category display page
        request.getRequestDispatcher("categories.jsp").forward(request, response);
    }
}
