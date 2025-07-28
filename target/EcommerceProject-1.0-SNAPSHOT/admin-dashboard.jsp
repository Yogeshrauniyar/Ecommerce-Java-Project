<%@ page import="java.util.*, com.ecommerce.model.User, com.ecommerce.model.Product, com.ecommerce.model.Order" %>
<%@ page import="com.ecommerce.model.UserDAO, com.ecommerce.model.ProductDAO, com.ecommerce.model.OrderDAO" %>
<%@ page import="com.ecommerce.model.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page session="true" %>

<%
    // Admin check
    User user = (User) session.getAttribute("user");
    if (user == null || !"1032222795@mitwpu.edu.in".equalsIgnoreCase(user.getEmail())) {
        response.sendRedirect("login.jsp");
        return;
    }

    ProductDAO productDAO = new ProductDAO(DBUtil.getConnection());

    // Handle product delete
    String deleteId = request.getParameter("deleteId");
    if (deleteId != null) {
        productDAO.deleteProduct(Integer.parseInt(deleteId));
        response.sendRedirect("admin-dashboard.jsp");
        return;
    }

    // Handle edit submit
    String editId = request.getParameter("editId");
    if ("POST".equalsIgnoreCase(request.getMethod()) && editId != null) {
        int id = Integer.parseInt(editId);
        String name = request.getParameter("editName");
        String category = request.getParameter("editCategory");
        String imageUrl = request.getParameter("editImageUrl");
        double price = Double.parseDouble(request.getParameter("editPrice"));
        int stock = Integer.parseInt(request.getParameter("editStock"));

        Product p = new Product(id, name, category, imageUrl, price, stock);
        productDAO.updateProduct(p);
        response.sendRedirect("admin-dashboard.jsp");
        return;
    }

    // Handle add product
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("addProduct") != null) {
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String imageUrl = request.getParameter("imageUrl");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        Product newProduct = new Product(0, name, category, imageUrl, price, stock);
        productDAO.addProduct(newProduct);
        response.sendRedirect("admin-dashboard.jsp");
        return;
    }

    // Fetch all
    UserDAO userDAO = new UserDAO(DBUtil.getConnection());
    List<User> users = userDAO.getAllUsers();
    List<Product> products = productDAO.getAllProducts();
    OrderDAO orderDAO = new OrderDAO(DBUtil.getConnection());
    List<Order> orders = orderDAO.getAllOrders();

    String editProductId = request.getParameter("editFormId");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        h1 { color: darkblue; }
        .logout { float: right; }
        table { width: 90%; margin: 20px auto; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background-color: #f2f2f2; }
        .btn {
            padding: 5px 10px; background-color: #337ab7;
            color: white; text-decoration: none; border-radius: 4px;
        }
        .btn:hover { background-color: #286090; }
        .form-inline { margin: 20px auto; width: 60%; }
        input[type=text], input[type=number] {
            width: 90%; padding: 5px; margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="logout">
    <a href="login.jsp" class="btn">Logout</a>
</div>

<h1>Welcome, Admin!</h1>

<!-- Users -->
<h2>View Users</h2>
<table>
    <tr><th>ID</th><th>Name</th><th>Email</th></tr>
    <% for (User u : users) { %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getName() %></td>
            <td><%= u.getEmail() %></td>
        </tr>
    <% } %>
</table>

<!-- Add Product -->
<h2>Add Product</h2>
<form action="admin-dashboard.jsp" method="post" class="form-inline">
    <input type="hidden" name="addProduct" value="1">
    <input type="text" name="name" placeholder="Name" required><br>
    <input type="text" name="category" placeholder="Category" required><br>
    <input type="text" name="imageUrl" placeholder="Image URL" required><br>
    <input type="number" step="0.01" name="price" placeholder="Price" required><br>
    <input type="number" name="stock" placeholder="Stock" required><br>
    <button type="submit" class="btn">Add Product</button>
</form>

<!-- Products -->
<h2>Manage Products</h2>
<table>
    <tr><th>ID</th><th>Name</th><th>Category</th><th>Image</th><th>Price</th><th>Stock</th><th>Actions</th></tr>
    <% for (Product p : products) {
        boolean editing = (editProductId != null && Integer.toString(p.getId()).equals(editProductId));
    %>
        <tr>
        <% if (editing) { %>
            <form action="admin-dashboard.jsp?editId=<%= p.getId() %>" method="post">
                <td><%= p.getId() %></td>
                <td><input type="text" name="editName" value="<%= p.getName() %>" required></td>
                <td><input type="text" name="editCategory" value="<%= p.getCategory() %>" required></td>
                <td><input type="text" name="editImageUrl" value="<%= p.getImageUrl() %>" required></td>
                <td><input type="number" name="editPrice" value="<%= p.getPrice() %>" required></td>
                <td><input type="number" name="editStock" value="<%= p.getStock() %>" required></td>
                <td><button type="submit" class="btn">Save</button></td>
            </form>
        <% } else { %>
            <td><%= p.getId() %></td>
            <td><%= p.getName() %></td>
            <td><%= p.getCategory() %></td>
            <td><img src="<%= p.getImageUrl() %>" alt="Image" width="50" height="50"></td>
            <td><%= p.getPrice() %></td>
            <td><%= p.getStock() %></td>
            <td>
                <a href="admin-dashboard.jsp?editFormId=<%= p.getId() %>" class="btn">Edit</a>
                <a href="admin-dashboard.jsp?deleteId=<%= p.getId() %>" class="btn"
                   onclick="return confirm('Delete this product?');">Delete</a>
            </td>
        <% } %>
        </tr>
    <% } %>
</table>

<!-- Orders -->
<h2>View Orders</h2>
<table>
    <tr>
        <th>Order ID</th>
        <th>User ID</th>
        <th>Product Name</th>
        <th>Quantity</th>
        <th>Total Price</th>
        <th>Order Date</th>
    </tr>
    <% for (Order o : orders) { %>
        <tr>
            <td><%= o.getId() %></td>
            <td><%= o.getUserId() %></td>
            <td><%= o.getProductName() %></td>
            <td><%= o.getQuantity() %></td>
            <td><%= o.getTotalPrice() %></td>
            <td><%= o.getOrderDate() %></td>
        </tr>
    <% } %>
</table>

</body>
</html>
