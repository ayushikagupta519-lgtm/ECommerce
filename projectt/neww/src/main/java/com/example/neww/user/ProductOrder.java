package com.example.neww.user;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "product_orders")
public class ProductOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderId;
    
    private int customerId;
    private String customerName;
    private String paymentMethod;
    private String orderDate;
    private String totalAmount;
    private String itemSummary; // Stores a clean comma-separated list of items bought (e.g. "Pen x2, Notebook x1")

    public ProductOrder() {}

    public ProductOrder(int customerId, String customerName, String paymentMethod, String orderDate, String totalAmount, String itemSummary) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.paymentMethod = paymentMethod;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.itemSummary = itemSummary;
    }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getOrderDate() { return orderDate; }
    public void setOrderDate(String orderDate) { this.orderDate = orderDate; }

    public String getTotalAmount() { return totalAmount; }
    public void setTotalAmount(String totalAmount) { this.totalAmount = totalAmount; }

    public String getItemSummary() { return itemSummary; }
    public void setItemSummary(String itemSummary) { this.itemSummary = itemSummary; }
}
