<%@ page import="java.util.*, com.ecommerce.model.CartItem" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Shopping Cart</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #f5f8fc;
            font-family: 'Noto Sans', sans-serif;
        }
        h2 {
            text-align: center;
            color: #337ab7;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            font-weight: bold;
        }
        .btn {
            background-color: #337ab7;
            color: white;
            border: none;
            padding: 8px 14px;
            cursor: pointer;
            border-radius: 3px;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #286090;
        }
        .total {
            font-size: 20px;
            font-weight: bold;
            margin-left: 10%;
        }
        .buttons {
            margin-left: 10%;
            margin-top: 20px;
        }
    </style>
    <script>
        function updateTotal() {
            const rows = document.querySelectorAll('.cart-row');
            let grandTotal = 0;
            rows.forEach(row => {
                const priceText = row.querySelector('.price').innerText.replace(/[^\d.]/g, '');
                const qtyInput = row.querySelector('.quantity');
                const quantity = parseInt(qtyInput.value);
                const price = parseFloat(priceText);

                if (!isNaN(price) && !isNaN(quantity)) {
                    const subtotal = price * quantity;
                    row.querySelector('.subtotal').innerHTML = "&#8377;" + subtotal.toFixed(2);
                    grandTotal += subtotal;
                }
            });
            document.getElementById("grandTotal").innerHTML = "&#8377;" + grandTotal.toFixed(2);
        }

        function confirmRemove(productId) {
            if (confirm("Are you sure you want to remove this item from the cart?")) {
                window.location.href = "removeFromCart.jsp?productId=" + productId;
            }
        }

        function checkEmptyCart() {
            const cartTable = document.getElementById("cartTable");
            const emptyMsg = document.getElementById("emptyMsg");
            const totalRow = document.getElementById("totalRow");
            const buttons = document.querySelector(".buttons");
            if (cartTable.rows.length <= 1) {
                emptyMsg.style.display = "block";
                totalRow.style.display = "none";
                buttons.style.display = "none";
            }
        }

        window.onload = () => {
            updateTotal();
            checkEmptyCart();
        }
    </script>
</head>
<body>
    <h2>Your Shopping Cart</h2>

    <%
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double cartTotal = 0;
        if (cart != null) {
            for (CartItem item : cart) {
                cartTotal += item.getProduct().getPrice() * item.getQuantity();
            }
        }
    %>

    <!-- Empty Cart Message -->
    <div id="emptyMsg" style="text-align: center; display: <%= (cart == null || cart.isEmpty()) ? "block" : "none" %>;">
        <h3>Your cart is empty. <a href="dashboard.jsp">Start shopping now!</a></h3>
    </div>

    <!-- Cart Table -->
    <table id="cartTable" style="display: <%= (cart != null && !cart.isEmpty()) ? "table" : "none" %>;">
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Action</th>
        </tr>
        <%
            if (cart != null) {
                for (CartItem item : cart) {
        %>
        <tr class="cart-row">
            <td><%= item.getProduct().getName() %></td>
            <td class="price">&#8377;<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
            <td>
                <form action="updateQuantity.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                    <input type="number" name="quantity" class="quantity" value="<%= item.getQuantity() %>" min="1" onchange="updateTotal()">
                    <input type="submit" value="Update" class="btn">
                </form>
            </td>
            <td class="subtotal">&#8377;0.00</td>
            <td><button class="btn" onclick="confirmRemove(<%= item.getProduct().getId() %>)">Remove</button></td>
        </tr>
        <%
                }
            }
        %>
    </table>

    <!-- Grand Total Display -->
    <div class="total" id="totalRow" style="display: <%= (cart != null && !cart.isEmpty()) ? "block" : "none" %>;">
        Total: <span id="grandTotal">&#8377;<%= String.format("%.2f", cartTotal) %></span>
    </div>

    <!-- Buttons -->
    <div class="buttons" style="display: <%= (cart != null && !cart.isEmpty()) ? "block" : "none" %>;">
        <button class="btn" onclick="window.location.href='checkout.jsp'">Proceed to Checkout</button>
        <a href="dashboard.jsp" class="btn">Continue Shopping</a>
    </div>
</body>
</html>
