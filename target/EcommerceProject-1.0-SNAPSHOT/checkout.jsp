<%@ page import="java.util.List" %>
<%@ page import="com.ecommerce.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
    <style>
        body {
            background-color: #f5f7fa;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            padding-top: 30px;
        }

        .container {
            background: white;
            border-radius: 12px;
            padding: 30px;
            width: 400px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #3b74c1;
        }

        label {
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .order-summary {
            margin-top: 20px;
        }

        .order-summary h3,
        .total,
        .payment-label {
            color: #3b74c1;
            font-weight: bold;
        }

        .total {
            margin-top: 10px;
        }

        .payment-method {
            margin-top: 15px;
        }

        .payment-option {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 8px 0;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s ease;
        }

        .payment-option:hover {
            background-color: #f0f4ff;
        }

        .place-order-btn {
            background-color: #337ab7;
            color: white;
            padding: 12px;
            border: none;
            width: 100%;
            border-radius: 6px;
            font-weight: bold;
            margin-top: 20px;
            cursor: pointer;
        }

        .place-order-btn:hover {
            background-color: #2c68a0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Checkout</h2>
        <form method="post" action="CheckoutServlet">
            <label>Full Name:</label>
            <input type="text" name="fullname" required>

            <label>Phone Number:</label>
            <input type="text" name="phone" required>

            <label>Delivery Address:</label>
            <input type="text" name="address" required>

            <div class="order-summary">
                <h3>Order Summary</h3>
                <%
                    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                    double total = 0;
                    if (cart != null && !cart.isEmpty()) {
                        for (CartItem item : cart) {
                            String name = item.getProduct().getName();
                            double price = item.getProduct().getPrice();
                            int qty = item.getQuantity();
                            double sub = price * qty;
                            total += sub;
                %>
                    <p><%= name %> - ₹<%= price %> x <%= qty %></p>
                <%
                        }
                    } else {
                %>
                    <p>Your cart is empty.</p>
                <%
                    }
                %>
                <p class="total">Total: ₹<%= String.format("%.2f", total) %></p>
            </div>

            <div class="payment-method">
                <p class="payment-label">Select Payment Method</p>

                <div class="payment-option">🚚 Cash on Delivery</div>
                <div class="payment-option">💳 Pay via UPI</div>
                <div class="payment-option">💳 Pay via Credit/Debit Card</div>
            </div>

            <button type="submit" class="place-order-btn">Place Order</button>
        </form>
    </div>
</body>
</html>
