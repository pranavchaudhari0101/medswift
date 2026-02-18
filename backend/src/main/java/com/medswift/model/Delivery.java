package com.medswift.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "deliveries")
public class Delivery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false, unique = true)
    private Order order;

    @Enumerated(EnumType.STRING)
    private DeliveryStatus status = DeliveryStatus.ASSIGNED;

    private String deliveryPartnerName;
    private String deliveryPartnerPhone;

    private LocalDateTime estimatedDeliveryTime;
    private LocalDateTime actualDeliveryTime;

    private Double currentLatitude;
    private Double currentLongitude;

    private String proofOfDeliveryUrl;

    private LocalDateTime createdAt = LocalDateTime.now();

    public enum DeliveryStatus {
        ASSIGNED, PICKED_UP, IN_TRANSIT, ARRIVED, DELIVERED, FAILED
    }

    // Constructors
    public Delivery() {
    }

    public Delivery(Long id, Order order, DeliveryStatus status, String deliveryPartnerName,
            String deliveryPartnerPhone, LocalDateTime estimatedDeliveryTime, LocalDateTime actualDeliveryTime,
            Double currentLatitude, Double currentLongitude, String proofOfDeliveryUrl, LocalDateTime createdAt) {
        this.id = id;
        this.order = order;
        this.status = status;
        this.deliveryPartnerName = deliveryPartnerName;
        this.deliveryPartnerPhone = deliveryPartnerPhone;
        this.estimatedDeliveryTime = estimatedDeliveryTime;
        this.actualDeliveryTime = actualDeliveryTime;
        this.currentLatitude = currentLatitude;
        this.currentLongitude = currentLongitude;
        this.proofOfDeliveryUrl = proofOfDeliveryUrl;
        this.createdAt = createdAt;
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

    public DeliveryStatus getStatus() {
        return status;
    }

    public void setStatus(DeliveryStatus status) {
        this.status = status;
    }

    public String getDeliveryPartnerName() {
        return deliveryPartnerName;
    }

    public void setDeliveryPartnerName(String deliveryPartnerName) {
        this.deliveryPartnerName = deliveryPartnerName;
    }

    public String getDeliveryPartnerPhone() {
        return deliveryPartnerPhone;
    }

    public void setDeliveryPartnerPhone(String deliveryPartnerPhone) {
        this.deliveryPartnerPhone = deliveryPartnerPhone;
    }

    public LocalDateTime getEstimatedDeliveryTime() {
        return estimatedDeliveryTime;
    }

    public void setEstimatedDeliveryTime(LocalDateTime estimatedDeliveryTime) {
        this.estimatedDeliveryTime = estimatedDeliveryTime;
    }

    public LocalDateTime getActualDeliveryTime() {
        return actualDeliveryTime;
    }

    public void setActualDeliveryTime(LocalDateTime actualDeliveryTime) {
        this.actualDeliveryTime = actualDeliveryTime;
    }

    public Double getCurrentLatitude() {
        return currentLatitude;
    }

    public void setCurrentLatitude(Double currentLatitude) {
        this.currentLatitude = currentLatitude;
    }

    public Double getCurrentLongitude() {
        return currentLongitude;
    }

    public void setCurrentLongitude(Double currentLongitude) {
        this.currentLongitude = currentLongitude;
    }

    public String getProofOfDeliveryUrl() {
        return proofOfDeliveryUrl;
    }

    public void setProofOfDeliveryUrl(String proofOfDeliveryUrl) {
        this.proofOfDeliveryUrl = proofOfDeliveryUrl;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // Builder
    public static DeliveryBuilder builder() {
        return new DeliveryBuilder();
    }

    public static class DeliveryBuilder {
        private Long id;
        private Order order;
        private DeliveryStatus status = DeliveryStatus.ASSIGNED;
        private String deliveryPartnerName;
        private String deliveryPartnerPhone;
        private LocalDateTime estimatedDeliveryTime;
        private LocalDateTime actualDeliveryTime;
        private Double currentLatitude;
        private Double currentLongitude;
        private String proofOfDeliveryUrl;
        private LocalDateTime createdAt = LocalDateTime.now();

        DeliveryBuilder() {
        }

        public DeliveryBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public DeliveryBuilder order(Order order) {
            this.order = order;
            return this;
        }

        public DeliveryBuilder status(DeliveryStatus status) {
            this.status = status;
            return this;
        }

        public DeliveryBuilder deliveryPartnerName(String deliveryPartnerName) {
            this.deliveryPartnerName = deliveryPartnerName;
            return this;
        }

        public DeliveryBuilder deliveryPartnerPhone(String deliveryPartnerPhone) {
            this.deliveryPartnerPhone = deliveryPartnerPhone;
            return this;
        }

        public DeliveryBuilder estimatedDeliveryTime(LocalDateTime estimatedDeliveryTime) {
            this.estimatedDeliveryTime = estimatedDeliveryTime;
            return this;
        }

        public DeliveryBuilder actualDeliveryTime(LocalDateTime actualDeliveryTime) {
            this.actualDeliveryTime = actualDeliveryTime;
            return this;
        }

        public DeliveryBuilder currentLatitude(Double currentLatitude) {
            this.currentLatitude = currentLatitude;
            return this;
        }

        public DeliveryBuilder currentLongitude(Double currentLongitude) {
            this.currentLongitude = currentLongitude;
            return this;
        }

        public DeliveryBuilder proofOfDeliveryUrl(String proofOfDeliveryUrl) {
            this.proofOfDeliveryUrl = proofOfDeliveryUrl;
            return this;
        }

        public DeliveryBuilder createdAt(LocalDateTime createdAt) {
            this.createdAt = createdAt;
            return this;
        }

        public Delivery build() {
            return new Delivery(id, order, status, deliveryPartnerName, deliveryPartnerPhone, estimatedDeliveryTime,
                    actualDeliveryTime, currentLatitude, currentLongitude, proofOfDeliveryUrl, createdAt);
        }
    }
}
