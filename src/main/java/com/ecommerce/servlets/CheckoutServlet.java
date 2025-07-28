import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecommerce.model.CartItem;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        // Get form values
        String name = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Get cart from session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double totalAmount = 0;

        out.println("<html><head><title>Order Confirmation</title></head>");
        out.println("<body style='font-family: Arial; background-color: #f5f7fa;'>");
        out.println("<div style='margin: 50px auto; width: 60%; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);'>");

        if (cart != null && !cart.isEmpty()) {
            out.println("<h2 style='color: #3b74c1;'>Order Confirmed!</h2>");
            out.println("<p><strong>Name:</strong> " + name + "</p>");
            out.println("<p><strong>Phone:</strong> " + phone + "</p>");
            out.println("<p><strong>Address:</strong> " + address + "</p>");

            out.println("<h3>Order Summary:</h3>");
            out.println("<table style='width: 100%; border-collapse: collapse;'>");
            out.println("<tr style='background-color: #f0f0f0;'><th>Product</th><th>Price</th><th>Quantity</th><th>Subtotal</th></tr>");

            for (CartItem item : cart) {
                String productName = item.getProduct().getName();
                double price = item.getProduct().getPrice();
                int quantity = item.getQuantity();
                double subtotal = price * quantity;
                totalAmount += subtotal;

                out.println("<tr style='text-align: center;'>");
                out.println("<td>" + productName + "</td>");
                out.println("<td>&#8377;" + String.format("%.2f", price) + "</td>");
                out.println("<td>" + quantity + "</td>");
                out.println("<td>&#8377;" + String.format("%.2f", subtotal) + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");
            out.println("<h3 style='text-align: right; margin-top: 20px;'>Total Amount: <span style='color: green;'>&#8377;" + String.format("%.2f", totalAmount) + "</span></h3>");
            out.println("<p style='color: #333; margin-top: 20px;'>Thank you for your purchase! Your order will be delivered soon.</p>");

            // Clear cart after checkout
            session.removeAttribute("cart");
        } else {
            out.println("<h2 style='color: red;'>Your cart is empty.</h2>");
        }

        out.println("<a href='dashboard.jsp' style='display: inline-block; margin-top: 30px; background-color: #337ab7; color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none;'>Return to Dashboard</a>");
        out.println("</div></body></html>");
    }
}
