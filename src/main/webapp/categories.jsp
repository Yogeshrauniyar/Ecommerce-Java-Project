<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>ShopMate - Products</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" />
  <style>
    /* Same CSS styling as you provided — no changes */
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background: #f0f4f8;
    }
    .sidebar {
      width: 250px;
      background-color: #22313f;
      color: white;
      height: 100vh;
      float: left;
      padding: 20px;
      box-sizing: border-box;
    }
    .sidebar h2 {
      margin-bottom: 30px;
    }
    .sidebar a {
      display: block;
      color: white;
      text-decoration: none;
      margin: 15px 0;
      font-size: 16px;
    }
    .sidebar a:hover {
      text-decoration: underline;
      color: #ffc107;
    }
    .main {
      margin-left: 250px;
    }
    .header {
      background: white;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .header input[type="text"] {
      width: 300px;
      padding: 8px;
      border-radius: 4px;
      border: 1px solid #ccc;
    }
    .products-section {
      text-align: center;
      padding: 40px 20px;
    }
    .products-section h1 {
      font-size: 2em;
      margin-bottom: 10px;
    }
    .cards {
      display: flex;
      justify-content: center;
      gap: 30px;
      flex-wrap: wrap;
      margin-top: 30px;
    }
    .card {
      background: white;
      border-radius: 12px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      width: 230px;
      padding: 20px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .card:hover {
      transform: translateY(-10px);
      box-shadow: 0 10px 16px rgba(0, 0, 0, 0.2);
    }
    .card img {
      width: 100%;
      height: 150px;
      object-fit: cover;
      border-radius: 8px;
    }
    .card h3 {
      margin: 15px 0 5px;
    }
    .card p {
      font-size: 14px;
      color: #555;
    }
    .card form button {
      margin-top: 10px;
      padding: 8px 16px;
      background-color: #3273dc;
      color: white;
      border: none;
      border-radius: 20px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .card form button:hover {
      background-color: #225ba6;
    }
    .footer {
      background-color: #1c1c1c;
      color: white;
      text-align: center;
      padding: 15px;
      font-size: 14px;
    }
  </style>
</head>
<body>

  <div class="sidebar">
    <h2>ShopMate</h2>
    <a href="dashboard.jsp">Home</a>
    <a href="recommendations">Recommended</a>
    <a href="cart.jsp">Cart</a>
  </div>

  <div class="main">
    <div class="header">
      <div style="font-size: 20px; font-weight: bold;">ShopMate</div>
      <input type="text" placeholder="Search for products..." />
      <div style="font-size: 18px;">🛒</div>
    </div>

    <div class="products-section">
      <h1><%= request.getAttribute("selectedCategory") != null ? request.getAttribute("selectedCategory").toString().toUpperCase() : "Products" %></h1>
      <p>Explore top picks in this category</p>

      <div class="cards">
        <%
          List<Product> products = (List<Product>) request.getAttribute("products");
          if (products != null && !products.isEmpty()) {
            for (Product p : products) {
        %>
          <div class="card">
            <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
            <h3><%= p.getName() %></h3>
            <p>₹<%= String.format("%.2f", p.getPrice()) %></p>
            <form action="addToCart" method="post">
              <input type="hidden" name="productId" value="<%= p.getId() %>">
              <button type="submit">Add to Cart</button>
            </form>
          </div>
        <%
            }
          } else {
        %>
          <p>No products available in this category.</p>
        <%
          }
        %>
      </div>
    </div>

    <div class="footer">
      © 2025 ShopMate. All rights reserved.
    </div>
  </div>

</body>
</html>
