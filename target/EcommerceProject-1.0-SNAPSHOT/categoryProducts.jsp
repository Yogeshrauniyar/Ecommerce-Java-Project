<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Product" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ShopMate - Products</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f0f2f5;
    }

    .sidebar {
      width: 220px;
      background: #2c3e50;
      color: white;
      height: 100vh;
      float: left;
      padding: 20px;
      box-sizing: border-box;
    }

    .sidebar h2 {
      text-align: center;
      margin-bottom: 30px;
    }

    .sidebar a {
      display: block;
      color: white;
      text-decoration: none;
      margin-bottom: 15px;
    }

    .sidebar a:hover {
      background-color: #1a252f;
      border-radius: 5px;
      padding-left: 5px;
    }

    .main {
      margin-left: 220px;
      padding: 40px;
    }

    .main h1 {
      text-align: center;
      margin-bottom: 30px;
    }

    .product-grid {
      display: flex;
      justify-content: center;
      gap: 30px;
      flex-wrap: wrap;
    }

    .product-card {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      width: 250px;
      padding: 20px;
      text-align: center;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .product-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 10px 18px rgba(0, 0, 0, 0.2);
    }

    .product-card img {
      width: 100%;
      height: 160px;
      object-fit: cover;
      border-radius: 10px;
      margin-bottom: 15px;
    }

    .product-card h3 {
      margin: 10px 0 5px;
    }

    .product-card p {
      color: #555;
      font-size: 14px;
    }

    .product-card .price {
      font-weight: bold;
      color: #2c3e50;
      margin: 10px 0;
    }

    .footer {
      text-align: center;
      margin-top: 50px;
      color: #888;
    }
  </style>
</head>
<body>

  <div class="sidebar">
    <h2>ShopMate</h2>
    <a href="dashboard.jsp">Home</a>
    <a href="recommendations">Recommended</a>
    <a href="#">Cart</a>
  </div>

  <div class="main">
    <h1><%= request.getParameter("category").toUpperCase() %> Products</h1>

    <div class="product-grid">
      <%
        List<Product> products = (List<Product>) request.getAttribute("products");
        if (products != null && !products.isEmpty()) {
          for (Product product : products) {
      %>
      <div class="product-card">
        <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
        <h3><%= product.getName() %></h3>
        <p class="price">₹<%= product.getPrice() %></p>
        <p><%= product.getCategory() %></p>
      </div>
      <%
          }
        } else {
      %>
        <p>No products found for this category.</p>
      <%
        }
      %>
    </div>

    <div class="footer">
      &copy; 2025 ShopMate. All rights reserved.
    </div>
  </div>

</body>
</html>
