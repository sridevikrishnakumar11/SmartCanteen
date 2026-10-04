package com.smartcanteen.model;

import java.io.Serializable;

public class FoodItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String name;
    private String category;
    private double price;
    private boolean isVeg;
    private String image;
    private double rating;
    private boolean inStock;

    public FoodItem() {}

    public FoodItem(String id, String name, String category, double price, boolean isVeg, String image, double rating) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.isVeg = isVeg;
        this.image = image;
        this.rating = rating;
        this.inStock = true;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isVeg() {
        return isVeg;
    }

    public void setVeg(boolean isVeg) {
        this.isVeg = isVeg;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public boolean isInStock() {
        return inStock;
    }

    public void setInStock(boolean inStock) {
        this.inStock = inStock;
    }
}
