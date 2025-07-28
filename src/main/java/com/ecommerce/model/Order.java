package com.ecommerce.model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private String productName;
    private int quantity;
    private double totalPrice;
    private Timestamp orderDate;

    public Order(int id, int userId, String productName, int quantity, double totalPrice, Timestamp orderDate) {
        this.id = id;
        this.userId = userId;
        this.productName = productName;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
    }

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getProductName() { return productName; }
    public int getQuantity() { return quantity; }
    public double getTotalPrice() { return totalPrice; }
    public Timestamp getOrderDate() { return orderDate; }
}
