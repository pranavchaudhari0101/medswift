package com.medswift.model;

import jakarta.persistence.*;

@Entity
@Table(name = "pharmacies")
public class Pharmacy {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
    private String licenseNumber;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String city;

    private String state;
    private String pincode;

    private Double latitude;
    private Double longitude;

    private Double rating = 0.0;

    private int totalRatings = 0;

    private boolean isVerified = false;

    private String operatingHours; // e.g. "08:00-22:00"

    private boolean is24Hours = false;

    private String phoneNumber;
    private String imageUrl;

    private boolean isActive = true;

    // Constructors
    public Pharmacy() {
    }

    public Pharmacy(Long id, String name, String licenseNumber, String address, String city, String state,
            String pincode, Double latitude, Double longitude, Double rating, int totalRatings, boolean isVerified,
            String operatingHours, boolean is24Hours, String phoneNumber, String imageUrl, boolean isActive) {
        this.id = id;
        this.name = name;
        this.licenseNumber = licenseNumber;
        this.address = address;
        this.city = city;
        this.state = state;
        this.pincode = pincode;
        this.latitude = latitude;
        this.longitude = longitude;
        this.rating = rating;
        this.totalRatings = totalRatings;
        this.isVerified = isVerified;
        this.operatingHours = operatingHours;
        this.is24Hours = is24Hours;
        this.phoneNumber = phoneNumber;
        this.imageUrl = imageUrl;
        this.isActive = isActive;
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

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPincode() {
        return pincode;
    }

    public void setPincode(String pincode) {
        this.pincode = pincode;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public int getTotalRatings() {
        return totalRatings;
    }

    public void setTotalRatings(int totalRatings) {
        this.totalRatings = totalRatings;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    public String getOperatingHours() {
        return operatingHours;
    }

    public void setOperatingHours(String operatingHours) {
        this.operatingHours = operatingHours;
    }

    public boolean isIs24Hours() {
        return is24Hours;
    }

    public void setIs24Hours(boolean is24Hours) {
        this.is24Hours = is24Hours;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    // Builder
    public static PharmacyBuilder builder() {
        return new PharmacyBuilder();
    }

    public static class PharmacyBuilder {
        private Long id;
        private String name;
        private String licenseNumber;
        private String address;
        private String city;
        private String state;
        private String pincode;
        private Double latitude;
        private Double longitude;
        private Double rating = 0.0;
        private int totalRatings = 0;
        private boolean isVerified = false;
        private String operatingHours;
        private boolean is24Hours = false;
        private String phoneNumber;
        private String imageUrl;
        private boolean isActive = true;

        PharmacyBuilder() {
        }

        public PharmacyBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public PharmacyBuilder name(String name) {
            this.name = name;
            return this;
        }

        public PharmacyBuilder licenseNumber(String licenseNumber) {
            this.licenseNumber = licenseNumber;
            return this;
        }

        public PharmacyBuilder address(String address) {
            this.address = address;
            return this;
        }

        public PharmacyBuilder city(String city) {
            this.city = city;
            return this;
        }

        public PharmacyBuilder state(String state) {
            this.state = state;
            return this;
        }

        public PharmacyBuilder pincode(String pincode) {
            this.pincode = pincode;
            return this;
        }

        public PharmacyBuilder latitude(Double latitude) {
            this.latitude = latitude;
            return this;
        }

        public PharmacyBuilder longitude(Double longitude) {
            this.longitude = longitude;
            return this;
        }

        public PharmacyBuilder rating(Double rating) {
            this.rating = rating;
            return this;
        }

        public PharmacyBuilder totalRatings(int totalRatings) {
            this.totalRatings = totalRatings;
            return this;
        }

        public PharmacyBuilder isVerified(boolean isVerified) {
            this.isVerified = isVerified;
            return this;
        }

        public PharmacyBuilder operatingHours(String operatingHours) {
            this.operatingHours = operatingHours;
            return this;
        }

        public PharmacyBuilder is24Hours(boolean is24Hours) {
            this.is24Hours = is24Hours;
            return this;
        }

        public PharmacyBuilder phoneNumber(String phoneNumber) {
            this.phoneNumber = phoneNumber;
            return this;
        }

        public PharmacyBuilder imageUrl(String imageUrl) {
            this.imageUrl = imageUrl;
            return this;
        }

        public PharmacyBuilder isActive(boolean isActive) {
            this.isActive = isActive;
            return this;
        }

        public Pharmacy build() {
            return new Pharmacy(id, name, licenseNumber, address, city, state, pincode, latitude, longitude, rating,
                    totalRatings, isVerified, operatingHours, is24Hours, phoneNumber, imageUrl, isActive);
        }
    }
}
