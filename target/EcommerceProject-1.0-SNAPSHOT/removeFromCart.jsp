<%@ page import="java.util.*, com.ecommerce.model.CartItem" %>
<%
    int productId = Integer.parseInt(request.getParameter("productId"));
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

    if (cart != null) {
        Iterator<CartItem> iterator = cart.iterator();
        while (iterator.hasNext()) {
            CartItem item = iterator.next();
            if (item.getProduct().getId() == productId) {
                iterator.remove();
                break;
            }
        }
        session.setAttribute("cart", cart);
    }

    response.sendRedirect("cart.jsp");
%>
