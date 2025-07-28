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

@WebServlet("/recommendations")
public class RecommendationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = new ArrayList<>();
        products.add(new Product("MacBook Air M2", "Powerful & lightweight laptop for professionals.", "assets/laptop.jpg"));
        products.add(new Product("iPhone 14", "Latest smartphone with cutting-edge features.", "assets/iphone.jpg"));
        products.add(new Product("Smartwatch", "Track health, fitness, and notifications on the go.", "assets/smartwatch.jpg"));
        products.add(new Product("Wall Art", "Decorate your room with aesthetic art pieces.", "assets/wallart.jpg"));

        request.setAttribute("products", products);
        request.getRequestDispatcher("recommendation.jsp").forward(request, response);
    }
}
