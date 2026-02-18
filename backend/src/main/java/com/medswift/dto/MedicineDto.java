package com.medswift.dto;

import java.math.BigDecimal;

public class MedicineDto {

    public static class MedicineResponse {
        private Long id;
        private String name;
        private String genericName;
        private String composition;
        private String manufacturer;
        private String category;
        private boolean requiresPrescription;
        private String description;
        private String sideEffects;
        private String dosage;
        private BigDecimal mrp;
        private String imageUrl;
        private String type;

        public MedicineResponse() {
        }

        public MedicineResponse(Long id, String name, String genericName, String composition, String manufacturer,
                String category, boolean requiresPrescription, String description, String sideEffects,
                String dosage, BigDecimal mrp, String imageUrl, String type) {
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

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public static MedicineResponseBuilder builder() {
            return new MedicineResponseBuilder();
        }

        public static class MedicineResponseBuilder {
            private Long id;
            private String name, genericName, composition, manufacturer, category, description, sideEffects, dosage,
                    imageUrl, type;
            private boolean requiresPrescription;
            private BigDecimal mrp;

            public MedicineResponseBuilder id(Long id) {
                this.id = id;
                return this;
            }

            public MedicineResponseBuilder name(String name) {
                this.name = name;
                return this;
            }

            public MedicineResponseBuilder genericName(String genericName) {
                this.genericName = genericName;
                return this;
            }

            public MedicineResponseBuilder composition(String composition) {
                this.composition = composition;
                return this;
            }

            public MedicineResponseBuilder manufacturer(String manufacturer) {
                this.manufacturer = manufacturer;
                return this;
            }

            public MedicineResponseBuilder category(String category) {
                this.category = category;
                return this;
            }

            public MedicineResponseBuilder requiresPrescription(boolean requiresPrescription) {
                this.requiresPrescription = requiresPrescription;
                return this;
            }

            public MedicineResponseBuilder description(String description) {
                this.description = description;
                return this;
            }

            public MedicineResponseBuilder sideEffects(String sideEffects) {
                this.sideEffects = sideEffects;
                return this;
            }

            public MedicineResponseBuilder dosage(String dosage) {
                this.dosage = dosage;
                return this;
            }

            public MedicineResponseBuilder mrp(BigDecimal mrp) {
                this.mrp = mrp;
                return this;
            }

            public MedicineResponseBuilder imageUrl(String imageUrl) {
                this.imageUrl = imageUrl;
                return this;
            }

            public MedicineResponseBuilder type(String type) {
                this.type = type;
                return this;
            }

            public MedicineResponse build() {
                return new MedicineResponse(id, name, genericName, composition, manufacturer, category,
                        requiresPrescription, description, sideEffects, dosage, mrp, imageUrl, type);
            }
        }
    }

    public static class PriceComparison {
        private Long pharmacyId;
        private String pharmacyName;
        private String pharmacyAddress;
        private Double pharmacyRating;
        private BigDecimal price;
        private boolean inStock;
        private String operatingHours;
        private Double distance;

        public PriceComparison() {
        }

        public PriceComparison(Long pharmacyId, String pharmacyName, String pharmacyAddress, Double pharmacyRating,
                BigDecimal price, boolean inStock, String operatingHours, Double distance) {
            this.pharmacyId = pharmacyId;
            this.pharmacyName = pharmacyName;
            this.pharmacyAddress = pharmacyAddress;
            this.pharmacyRating = pharmacyRating;
            this.price = price;
            this.inStock = inStock;
            this.operatingHours = operatingHours;
            this.distance = distance;
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

        public String getPharmacyAddress() {
            return pharmacyAddress;
        }

        public void setPharmacyAddress(String pharmacyAddress) {
            this.pharmacyAddress = pharmacyAddress;
        }

        public Double getPharmacyRating() {
            return pharmacyRating;
        }

        public void setPharmacyRating(Double pharmacyRating) {
            this.pharmacyRating = pharmacyRating;
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

        public String getOperatingHours() {
            return operatingHours;
        }

        public void setOperatingHours(String operatingHours) {
            this.operatingHours = operatingHours;
        }

        public Double getDistance() {
            return distance;
        }

        public void setDistance(Double distance) {
            this.distance = distance;
        }

        public static PriceComparisonBuilder builder() {
            return new PriceComparisonBuilder();
        }

        public static class PriceComparisonBuilder {
            private Long pharmacyId;
            private String pharmacyName, pharmacyAddress, operatingHours;
            private Double pharmacyRating, distance;
            private BigDecimal price;
            private boolean inStock;

            public PriceComparisonBuilder pharmacyId(Long pharmacyId) {
                this.pharmacyId = pharmacyId;
                return this;
            }

            public PriceComparisonBuilder pharmacyName(String pharmacyName) {
                this.pharmacyName = pharmacyName;
                return this;
            }

            public PriceComparisonBuilder pharmacyAddress(String pharmacyAddress) {
                this.pharmacyAddress = pharmacyAddress;
                return this;
            }

            public PriceComparisonBuilder pharmacyRating(Double pharmacyRating) {
                this.pharmacyRating = pharmacyRating;
                return this;
            }

            public PriceComparisonBuilder price(BigDecimal price) {
                this.price = price;
                return this;
            }

            public PriceComparisonBuilder inStock(boolean inStock) {
                this.inStock = inStock;
                return this;
            }

            public PriceComparisonBuilder operatingHours(String operatingHours) {
                this.operatingHours = operatingHours;
                return this;
            }

            public PriceComparisonBuilder distance(Double distance) {
                this.distance = distance;
                return this;
            }

            public PriceComparison build() {
                return new PriceComparison(pharmacyId, pharmacyName, pharmacyAddress, pharmacyRating, price, inStock,
                        operatingHours, distance);
            }
        }
    }
}
