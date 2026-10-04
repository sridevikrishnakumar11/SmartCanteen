package com.smartcanteen.model;

import java.io.Serializable;

public class Order implements Serializable {
    private static final long serialVersionUID = 1L;

    private String orderId;
    private String customerName;
    private String userEmail;
    private String pickupSlot;
    private double totalAmount;
    private String paymentMethod;
    private String status; // Preparing, Ready, Completed, Cancelled
    private String time;

    public Order() {}

    public Order(String orderId, String customerName, String pickupSlot, double totalAmount, String paymentMethod, String status, String time) {
        this(orderId, customerName, "", pickupSlot, totalAmount, paymentMethod, status, time);
    }

    public Order(String orderId, String customerName, String userEmail, String pickupSlot, double totalAmount, String paymentMethod, String status, String time) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.userEmail = userEmail;
        this.pickupSlot = pickupSlot;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.time = time;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getPickupSlot() {
        return pickupSlot;
    }

    public void setPickupSlot(String pickupSlot) {
        this.pickupSlot = pickupSlot;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getOrderTime() {
        return time;
    }

    public void setOrderTime(String orderTime) {
        this.time = orderTime;
    }
}
