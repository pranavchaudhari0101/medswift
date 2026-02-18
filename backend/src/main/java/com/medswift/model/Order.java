package com.medswift.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "pharmacy_id", nullable = false)
    private Pharmacy pharmacy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "prescription_id")
    private Prescription prescription;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> items = new ArrayList<>();

    @Column(nullable = false)
    private BigDecimal totalAmount;

    private BigDecimal discount;

    @Column(nullable = false)
    private String deliveryAddress;

    @Enumerated(EnumType.STRING)
    private OrderStatus status = OrderStatus.PLACED;

    @Enumerated(EnumType.STRING)
    private PaymentMethod paymentMethod = PaymentMethod.COD;

    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus = PaymentStatus.PENDING;

    private String specialInstructions;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    private LocalDateTime updatedAt = LocalDateTime.now();

    @PreUpdate
    public void preUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    public enum OrderStatus {
        PLACED, CONFIRMED, PRESCRIPTION_VERIFIED, PACKING, OUT_FOR_DELIVERY, DELIVERED, CANCELLED
    }

    public enum PaymentMethod {
        UPI, CARD, NET_BANKING, WALLET, COD
    }

    public enum PaymentStatus {
        PENDING, COMPLETED, FAILED, REFUNDED
    }

    // Constructors
    public Order() {
    }

    public Order(Long id, User user, Pharmacy pharmacy, Prescription prescription, List<OrderItem> items,
            BigDecimal totalAmount, BigDecimal discount, String deliveryAddress, OrderStatus status,
            PaymentMethod paymentMethod, PaymentStatus paymentStatus, String specialInstructions,
            LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.user = user;
        this.pharmacy = pharmacy;
        this.prescription = prescription;
        this.items = items;
        this.totalAmount = totalAmount;
        this.discount = discount;
        this.deliveryAddress = deliveryAddress;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.specialInstructions = specialInstructions;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Pharmacy getPharmacy() {
        return pharmacy;
    }

    public void setPharmacy(Pharmacy pharmacy) {
        this.pharmacy = pharmacy;
    }

    public Prescription getPrescription() {
        return prescription;
    }

    public void setPrescription(Prescription prescription) {
        this.prescription = prescription;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getDiscount() {
        return discount;
    }

    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(PaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getSpecialInstructions() {
        return specialInstructions;
    }

    public void setSpecialInstructions(String specialInstructions) {
        this.specialInstructions = specialInstructions;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Builder
    public static OrderBuilder builder() {
        return new OrderBuilder();
    }

    public static class OrderBuilder {
        private Long id;
        private User user;
        private Pharmacy pharmacy;
        private Prescription prescription;
        private List<OrderItem> items = new ArrayList<>();
        private BigDecimal totalAmount;
        private BigDecimal discount;
        private String deliveryAddress;
        private OrderStatus status = OrderStatus.PLACED;
        private PaymentMethod paymentMethod = PaymentMethod.COD;
        private PaymentStatus paymentStatus = PaymentStatus.PENDING;
        private String specialInstructions;
        private LocalDateTime createdAt = LocalDateTime.now();
        private LocalDateTime updatedAt = LocalDateTime.now();

        OrderBuilder() {
        }

        public OrderBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public OrderBuilder user(User user) {
            this.user = user;
            return this;
        }

        public OrderBuilder pharmacy(Pharmacy pharmacy) {
            this.pharmacy = pharmacy;
            return this;
        }

        public OrderBuilder prescription(Prescription prescription) {
            this.prescription = prescription;
            return this;
        }

        public OrderBuilder items(List<OrderItem> items) {
            this.items = items;
            return this;
        }

        public OrderBuilder totalAmount(BigDecimal totalAmount) {
            this.totalAmount = totalAmount;
            return this;
        }

        public OrderBuilder discount(BigDecimal discount) {
            this.discount = discount;
            return this;
        }

        public OrderBuilder deliveryAddress(String deliveryAddress) {
            this.deliveryAddress = deliveryAddress;
            return this;
        }

        public OrderBuilder status(OrderStatus status) {
            this.status = status;
            return this;
        }

        public OrderBuilder paymentMethod(PaymentMethod paymentMethod) {
            this.paymentMethod = paymentMethod;
            return this;
        }

        public OrderBuilder paymentStatus(PaymentStatus paymentStatus) {
            this.paymentStatus = paymentStatus;
            return this;
        }

        public OrderBuilder specialInstructions(String specialInstructions) {
            this.specialInstructions = specialInstructions;
            return this;
        }

        public OrderBuilder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public OrderBuilder updatedAt(LocalDateTime updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }

        public Order build() {
            return new Order(id, user, pharmacy, prescription, items, totalAmount, discount, deliveryAddress, status,
                    paymentMethod, paymentStatus, specialInstructions, createdAt, updatedAt);
        }
    }
}
