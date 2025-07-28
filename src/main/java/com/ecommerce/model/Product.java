package com.ecommerce.model;

public class Product {
    private int id;
    private String name;
    private String category;
    private String imageUrl;
    private double price;
    private int stock; // ✅ New field added

    // ✅ Full constructor (updated)
    public Product(int id, String name, String category, String imageUrl, double price, int stock) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.imageUrl = imageUrl;
        this.price = price;
        this.stock = stock;
    }

    // ✅ Overloaded constructor (with default price & stock)
    public Product(String name, String category, String imageUrl) {
        this.name = name;
        this.category = category;
        this.imageUrl = imageUrl;
        this.id = 0;
        this.price = 0.0;
        this.stock = 0;
    }

    // ✅ Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
}
