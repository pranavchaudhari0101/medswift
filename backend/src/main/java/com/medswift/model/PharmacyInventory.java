package com.medswift.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "pharmacy_inventory")
public class PharmacyInventory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "pharmacy_id", nullable = false)
    private Pharmacy pharmacy;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medicine_id", nullable = false)
    private Medicine medicine;

    @Column(nullable = false)
    private BigDecimal price;

    private boolean inStock = true;

    private int quantity = 0;

    // Constructors
    public PharmacyInventory() {
    }

    public PharmacyInventory(Long id, Pharmacy pharmacy, Medicine medicine, BigDecimal price, boolean inStock,
            int quantity) {
        this.id = id;
        this.pharmacy = pharmacy;
        this.medicine = medicine;
        this.price = price;
        this.inStock = inStock;
        this.quantity = quantity;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Pharmacy getPharmacy() {
        return pharmacy;
    }

    public void setPharmacy(Pharmacy pharmacy) {
        this.pharmacy = pharmacy;
    }

    public Medicine getMedicine() {
        return medicine;
    }

    public void setMedicine(Medicine medicine) {
        this.medicine = medicine;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public boolean isInStock() {
        return inStock;
    }

    public void setInStock(boolean inStock) {
        this.inStock = inStock;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Builder
    public static PharmacyInventoryBuilder builder() {
        return new PharmacyInventoryBuilder();
    }

    public static class PharmacyInventoryBuilder {
        private Long id;
        private Pharmacy pharmacy;
        private Medicine medicine;
        private BigDecimal price;
        private boolean inStock = true;
        private int quantity = 0;

        PharmacyInventoryBuilder() {
        }

        public PharmacyInventoryBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public PharmacyInventoryBuilder pharmacy(Pharmacy pharmacy) {
            this.pharmacy = pharmacy;
            return this;
        }

        public PharmacyInventoryBuilder medicine(Medicine medicine) {
            this.medicine = medicine;
            return this;
        }

        public PharmacyInventoryBuilder price(BigDecimal price) {
            this.price = price;
            return this;
        }

        public PharmacyInventoryBuilder inStock(boolean inStock) {
            this.inStock = inStock;
            return this;
        }

        public PharmacyInventoryBuilder quantity(int quantity) {
            this.quantity = quantity;
            return this;
        }

        public PharmacyInventory build() {
            return new PharmacyInventory(id, pharmacy, medicine, price, inStock, quantity);
        }
    }
}
