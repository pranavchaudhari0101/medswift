package com.medswift.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import jakarta.validation.constraints.*;

public class OrderDto {

    public static class CreateOrderRequest {
        @NotNull(message = "Pharmacy ID is required")
        private Long pharmacyId;
        private Long prescriptionId;
        @NotEmpty(message = "Order must have at least one item")
        private List<OrderItemRequest> items;
        @NotBlank(message = "Delivery address is required")
        private String deliveryAddress;
        private String paymentMethod;
        private String specialInstructions;

        public CreateOrderRequest() {
        }

        public CreateOrderRequest(Long pharmacyId, Long prescriptionId, List<OrderItemRequest> items,
                String deliveryAddress, String paymentMethod, String specialInstructions) {
            this.pharmacyId = pharmacyId;
            this.prescriptionId = prescriptionId;
            this.items = items;
            this.deliveryAddress = deliveryAddress;
            this.paymentMethod = paymentMethod;
            this.specialInstructions = specialInstructions;
        }

        public Long getPharmacyId() {
            return pharmacyId;
        }

        public void setPharmacyId(Long pharmacyId) {
            this.pharmacyId = pharmacyId;
        }

        public Long getPrescriptionId() {
            return prescriptionId;
        }

        public void setPrescriptionId(Long prescriptionId) {
            this.prescriptionId = prescriptionId;
        }

        public List<OrderItemRequest> getItems() {
            return items;
        }

        public void setItems(List<OrderItemRequest> items) {
            this.items = items;
        }

        public String getDeliveryAddress() {
            return deliveryAddress;
        }

        public void setDeliveryAddress(String deliveryAddress) {
            this.deliveryAddress = deliveryAddress;
        }

        public String getPaymentMethod() {
            return paymentMethod;
        }

        public void setPaymentMethod(String paymentMethod) {
            this.paymentMethod = paymentMethod;
        }

        public String getSpecialInstructions() {
            return specialInstructions;
        }

        public void setSpecialInstructions(String specialInstructions) {
            this.specialInstructions = specialInstructions;
        }
    }

    public static class OrderItemRequest {
        @NotNull
        private Long medicineId;
        @Min(1)
        private int quantity;

        public OrderItemRequest() {
        }

        public OrderItemRequest(Long medicineId, int quantity) {
            this.medicineId = medicineId;
            this.quantity = quantity;
        }

        public Long getMedicineId() {
            return medicineId;
        }

        public void setMedicineId(Long medicineId) {
            this.medicineId = medicineId;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }
    }

    public static class OrderResponse {
        private Long id;
        private Long pharmacyId;
        private String pharmacyName;
        private List<OrderItemResponse> items;
        private BigDecimal totalAmount;
        private BigDecimal discount;
        private String deliveryAddress;
        private String status;
        private String paymentMethod;
        private String paymentStatus;
        private String specialInstructions;
        private LocalDateTime createdAt;
        private DeliveryInfo delivery;

        public OrderResponse() {
        }

        public OrderResponse(Long id, Long pharmacyId, String pharmacyName, List<OrderItemResponse> items,
                BigDecimal totalAmount, BigDecimal discount, String deliveryAddress, String status,
                String paymentMethod, String paymentStatus, String specialInstructions,
                LocalDateTime createdAt, DeliveryInfo delivery) {
            this.id = id;
            this.pharmacyId = pharmacyId;
            this.pharmacyName = pharmacyName;
            this.items = items;
            this.totalAmount = totalAmount;
            this.discount = discount;
            this.deliveryAddress = deliveryAddress;
            this.status = status;
            this.paymentMethod = paymentMethod;
            this.paymentStatus = paymentStatus;
            this.specialInstructions = specialInstructions;
            this.createdAt = createdAt;
            this.delivery = delivery;
        }

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public Long getPharmacyId() {
            return pharmacyId;
        }

        public void setPharmacyId(Long pharmacyId) {
            this.pharmacyId = pharmacyId;
        }

        public String getPharmacyName() {
            return pharmacyName;
        }

        public void setPharmacyName(String pharmacyName) {
            this.pharmacyName = pharmacyName;
        }

        public List<OrderItemResponse> getItems() {
            return items;
        }

        public void setItems(List<OrderItemResponse> items) {
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

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getPaymentMethod() {
            return paymentMethod;
        }

        public void setPaymentMethod(String paymentMethod) {
            this.paymentMethod = paymentMethod;
        }

        public String getPaymentStatus() {
            return paymentStatus;
        }

        public void setPaymentStatus(String paymentStatus) {
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

        public DeliveryInfo getDelivery() {
            return delivery;
        }

        public void setDelivery(DeliveryInfo delivery) {
            this.delivery = delivery;
        }

        public static OrderResponseBuilder builder() {
            return new OrderResponseBuilder();
        }

        public static class OrderResponseBuilder {
            private Long id, pharmacyId;
            private String pharmacyName, deliveryAddress, status, paymentMethod, paymentStatus, specialInstructions;
            private List<OrderItemResponse> items;
            private BigDecimal totalAmount, discount;
            private LocalDateTime createdAt;
            private DeliveryInfo delivery;

            public OrderResponseBuilder id(Long id) {
                this.id = id;
                return this;
            }

            public OrderResponseBuilder pharmacyId(Long pharmacyId) {
                this.pharmacyId = pharmacyId;
                return this;
            }

            public OrderResponseBuilder pharmacyName(String pharmacyName) {
                this.pharmacyName = pharmacyName;
                return this;
            }

            public OrderResponseBuilder items(List<OrderItemResponse> items) {
                this.items = items;
                return this;
            }

            public OrderResponseBuilder totalAmount(BigDecimal totalAmount) {
                this.totalAmount = totalAmount;
                return this;
            }

            public OrderResponseBuilder discount(BigDecimal discount) {
                this.discount = discount;
                return this;
            }

            public OrderResponseBuilder deliveryAddress(String deliveryAddress) {
                this.deliveryAddress = deliveryAddress;
                return this;
            }

            public OrderResponseBuilder status(String status) {
                this.status = status;
                return this;
            }

            public OrderResponseBuilder paymentMethod(String paymentMethod) {
                this.paymentMethod = paymentMethod;
                return this;
            }

            public OrderResponseBuilder paymentStatus(String paymentStatus) {
                this.paymentStatus = paymentStatus;
                return this;
            }

            public OrderResponseBuilder specialInstructions(String specialInstructions) {
                this.specialInstructions = specialInstructions;
                return this;
            }

            public OrderResponseBuilder createdAt(LocalDateTime createdAt) {
                this.createdAt = createdAt;
                return this;
            }

            public OrderResponseBuilder delivery(DeliveryInfo delivery) {
                this.delivery = delivery;
                return this;
            }

            public OrderResponse build() {
                return new OrderResponse(id, pharmacyId, pharmacyName, items, totalAmount, discount,
                        deliveryAddress, status, paymentMethod, paymentStatus, specialInstructions, createdAt,
                        delivery);
            }
        }
    }

    public static class OrderItemResponse {
        private Long medicineId;
        private String medicineName;
        private String medicineImageUrl;
        private int quantity;
        private BigDecimal unitPrice;
        private BigDecimal totalPrice;

        public OrderItemResponse() {
        }

        public OrderItemResponse(Long medicineId, String medicineName, String medicineImageUrl,
                int quantity, BigDecimal unitPrice, BigDecimal totalPrice) {
            this.medicineId = medicineId;
            this.medicineName = medicineName;
            this.medicineImageUrl = medicineImageUrl;
            this.quantity = quantity;
            this.unitPrice = unitPrice;
            this.totalPrice = totalPrice;
        }

        public Long getMedicineId() {
            return medicineId;
        }

        public void setMedicineId(Long medicineId) {
            this.medicineId = medicineId;
        }

        public String getMedicineName() {
            return medicineName;
        }

        public void setMedicineName(String medicineName) {
            this.medicineName = medicineName;
        }

        public String getMedicineImageUrl() {
            return medicineImageUrl;
        }

        public void setMedicineImageUrl(String medicineImageUrl) {
            this.medicineImageUrl = medicineImageUrl;
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

        public static OrderItemResponseBuilder builder() {
            return new OrderItemResponseBuilder();
        }

        public static class OrderItemResponseBuilder {
            private Long medicineId;
            private String medicineName, medicineImageUrl;
            private int quantity;
            private BigDecimal unitPrice, totalPrice;

            public OrderItemResponseBuilder medicineId(Long medicineId) {
                this.medicineId = medicineId;
                return this;
            }

            public OrderItemResponseBuilder medicineName(String medicineName) {
                this.medicineName = medicineName;
                return this;
            }

            public OrderItemResponseBuilder medicineImageUrl(String medicineImageUrl) {
                this.medicineImageUrl = medicineImageUrl;
                return this;
            }

            public OrderItemResponseBuilder quantity(int quantity) {
                this.quantity = quantity;
                return this;
            }

            public OrderItemResponseBuilder unitPrice(BigDecimal unitPrice) {
                this.unitPrice = unitPrice;
                return this;
            }

            public OrderItemResponseBuilder totalPrice(BigDecimal totalPrice) {
                this.totalPrice = totalPrice;
                return this;
            }

            public OrderItemResponse build() {
                return new OrderItemResponse(medicineId, medicineName, medicineImageUrl, quantity, unitPrice,
                        totalPrice);
            }
        }
    }

    public static class DeliveryInfo {
        private String status;
        private String deliveryPartnerName;
        private String deliveryPartnerPhone;
        private LocalDateTime estimatedDeliveryTime;
        private Double currentLatitude;
        private Double currentLongitude;

        public DeliveryInfo() {
        }

        public DeliveryInfo(String status, String deliveryPartnerName, String deliveryPartnerPhone,
                LocalDateTime estimatedDeliveryTime, Double currentLatitude, Double currentLongitude) {
            this.status = status;
            this.deliveryPartnerName = deliveryPartnerName;
            this.deliveryPartnerPhone = deliveryPartnerPhone;
            this.estimatedDeliveryTime = estimatedDeliveryTime;
            this.currentLatitude = currentLatitude;
            this.currentLongitude = currentLongitude;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
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

        public static DeliveryInfoBuilder builder() {
            return new DeliveryInfoBuilder();
        }

        public static class DeliveryInfoBuilder {
            private String status, deliveryPartnerName, deliveryPartnerPhone;
            private LocalDateTime estimatedDeliveryTime;
            private Double currentLatitude, currentLongitude;

            public DeliveryInfoBuilder status(String status) {
                this.status = status;
                return this;
            }

            public DeliveryInfoBuilder deliveryPartnerName(String deliveryPartnerName) {
                this.deliveryPartnerName = deliveryPartnerName;
                return this;
            }

            public DeliveryInfoBuilder deliveryPartnerPhone(String deliveryPartnerPhone) {
                this.deliveryPartnerPhone = deliveryPartnerPhone;
                return this;
            }

            public DeliveryInfoBuilder estimatedDeliveryTime(LocalDateTime estimatedDeliveryTime) {
                this.estimatedDeliveryTime = estimatedDeliveryTime;
                return this;
            }

            public DeliveryInfoBuilder currentLatitude(Double currentLatitude) {
                this.currentLatitude = currentLatitude;
                return this;
            }

            public DeliveryInfoBuilder currentLongitude(Double currentLongitude) {
                this.currentLongitude = currentLongitude;
                return this;
            }

            public DeliveryInfo build() {
                return new DeliveryInfo(status, deliveryPartnerName, deliveryPartnerPhone, estimatedDeliveryTime,
                        currentLatitude, currentLongitude);
            }
        }
    }
}
