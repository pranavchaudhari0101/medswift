package com.medswift.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "medicines")
public class Medicine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String genericName;

    @Column(length = 500)
    private String composition;

    private String manufacturer;

    @Column(nullable = false)
    private String category;

    private boolean requiresPrescription = false;

    @Column(length = 2000)
    private String description;

    @Column(length = 1000)
    private String sideEffects;

    private String dosage;

    private BigDecimal mrp;

    private String imageUrl;

    @Enumerated(EnumType.STRING)
    private MedicineType type = MedicineType.ALLOPATHY;

    public enum MedicineType {
        ALLOPATHY, AYURVEDIC, HOMEOPATHY, OTC
    }

    // Constructors
    public Medicine() {
    }

    public Medicine(Long id, String name, String genericName, String composition, String manufacturer, String category,
            boolean requiresPrescription, String description, String sideEffects, String dosage, BigDecimal mrp,
            String imageUrl, MedicineType type) {
        this.id = id;
        this.name = name;
        this.genericName = genericName;
        this.composition = composition;
        this.manufacturer = manufacturer;
        this.category = category;
        this.requiresPrescription = requiresPrescription;
        this.description = description;
        this.sideEffects = sideEffects;
        this.dosage = dosage;
        this.mrp = mrp;
        this.imageUrl = imageUrl;
        this.type = type;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGenericName() {
        return genericName;
    }

    public void setGenericName(String genericName) {
        this.genericName = genericName;
    }

    public String getComposition() {
        return composition;
    }

    public void setComposition(String composition) {
        this.composition = composition;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean isRequiresPrescription() {
        return requiresPrescription;
    }

    public void setRequiresPrescription(boolean requiresPrescription) {
        this.requiresPrescription = requiresPrescription;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSideEffects() {
        return sideEffects;
    }

    public void setSideEffects(String sideEffects) {
        this.sideEffects = sideEffects;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public BigDecimal getMrp() {
        return mrp;
    }

    public void setMrp(BigDecimal mrp) {
        this.mrp = mrp;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public MedicineType getType() {
        return type;
    }

    public void setType(MedicineType type) {
        this.type = type;
    }

    // Builder
    public static MedicineBuilder builder() {
        return new MedicineBuilder();
    }

    public static class MedicineBuilder {
        private Long id;
        private String name;
        private String genericName;
        private String composition;
        private String manufacturer;
        private String category;
        private boolean requiresPrescription = false;
        private String description;
        private String sideEffects;
        private String dosage;
        private BigDecimal mrp;
        private String imageUrl;
        private MedicineType type = MedicineType.ALLOPATHY;

        MedicineBuilder() {
        }

        public MedicineBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public MedicineBuilder name(String name) {
            this.name = name;
            return this;
        }

        public MedicineBuilder genericName(String genericName) {
            this.genericName = genericName;
            return this;
        }

        public MedicineBuilder composition(String composition) {
            this.composition = composition;
            return this;
        }

        public MedicineBuilder manufacturer(String manufacturer) {
            this.manufacturer = manufacturer;
            return this;
        }

        public MedicineBuilder category(String category) {
            this.category = category;
            return this;
        }

        public MedicineBuilder requiresPrescription(boolean requiresPrescription) {
            this.requiresPrescription = requiresPrescription;
            return this;
        }

        public MedicineBuilder description(String description) {
            this.description = description;
            return this;
        }

        public MedicineBuilder sideEffects(String sideEffects) {
            this.sideEffects = sideEffects;
            return this;
        }

        public MedicineBuilder dosage(String dosage) {
            this.dosage = dosage;
            return this;
        }

        public MedicineBuilder mrp(BigDecimal mrp) {
            this.mrp = mrp;
            return this;
        }

        public MedicineBuilder imageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
            return this;
        }

        public MedicineBuilder type(MedicineType type) {
            this.type = type;
            return this;
        }

        public Medicine build() {
            return new Medicine(id, name, genericName, composition, manufacturer, category, requiresPrescription,
                    description, sideEffects, dosage, mrp, imageUrl, type);
        }
    }
}
