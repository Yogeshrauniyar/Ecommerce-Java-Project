<%@ page import="java.util.*, com.ecommerce.model.CartItem" %>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));

    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

    if (cart != null) {
        for (CartItem item : cart) {
            if (item.getProduct().getId() == productId) {
                item.setQuantity(quantity);
                break;
            }
        }
        session.setAttribute("cart", cart);
    }

    response.sendRedirect("cart.jsp");
%>
