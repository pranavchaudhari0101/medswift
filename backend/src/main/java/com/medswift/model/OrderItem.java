package com.medswift.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "order_items")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medicine_id", nullable = false)
    private Medicine medicine;

    @Column(nullable = false)
    private int quantity;

    @Column(nullable = false)
    private BigDecimal unitPrice;

    @Column(nullable = false)
    private BigDecimal totalPrice;

    // Constructors
    public OrderItem() {
    }

    public OrderItem(Long id, Order order, Medicine medicine, int quantity, BigDecimal unitPrice,
            BigDecimal totalPrice) {
        this.id = id;
        this.order = order;
        this.medicine = medicine;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Medicine getMedicine() {
        return medicine;
    }

    public void setMedicine(Medicine medicine) {
        this.medicine = medicine;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    // Builder
    public static OrderItemBuilder builder() {
        return new OrderItemBuilder();
    }

    public static class OrderItemBuilder {
        private Long id;
        private Order order;
        private Medicine medicine;
        private int quantity;
        private BigDecimal unitPrice;
        private BigDecimal totalPrice;

        OrderItemBuilder() {
        }

        public OrderItemBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public OrderItemBuilder order(Order order) {
            this.order = order;
            return this;
        }

        public OrderItemBuilder medicine(Medicine medicine) {
            this.medicine = medicine;
            return this;
        }

        public OrderItemBuilder quantity(int quantity) {
            this.quantity = quantity;
            return this;
        }

        public OrderItemBuilder unitPrice(BigDecimal unitPrice) {
            this.unitPrice = unitPrice;
            return this;
        }

        public OrderItemBuilder totalPrice(BigDecimal totalPrice) {
            this.totalPrice = totalPrice;
            return this;
        }

        public OrderItem build() {
            return new OrderItem(id, order, medicine, quantity, unitPrice, totalPrice);
        }
    }
}
