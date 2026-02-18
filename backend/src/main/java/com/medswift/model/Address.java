package com.medswift.model;

import jakarta.persistence.*;

@Entity
@Table(name = "addresses")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false)
    private String label; // Home, Office, Other

    @Column(nullable = false)
    private String addressLine;

    private String landmark;

    @Column(nullable = false)
    private String city;

    @Column(nullable = false)
    private String state;

    @Column(nullable = false)
    private String pincode;

    private Double latitude;
    private Double longitude;

    private boolean isDefault = false;

    // Constructors
    public Address() {
    }

    public Address(Long id, User user, String label, String addressLine, String landmark, String city, String state,
            String pincode, Double latitude, Double longitude, boolean isDefault) {
        this.id = id;
        this.user = user;
        this.label = label;
        this.addressLine = addressLine;
        this.landmark = landmark;
        this.city = city;
        this.state = state;
        this.pincode = pincode;
        this.latitude = latitude;
        this.longitude = longitude;
        this.isDefault = isDefault;
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

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

    public String getLandmark() {
        return landmark;
    }

    public void setLandmark(String landmark) {
        this.landmark = landmark;
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

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }

    // Builder
    public static AddressBuilder builder() {
        return new AddressBuilder();
    }

    public static class AddressBuilder {
        private Long id;
        private User user;
        private String label;
        private String addressLine;
        private String landmark;
        private String city;
        private String state;
        private String pincode;
        private Double latitude;
        private Double longitude;
        private boolean isDefault = false;

        AddressBuilder() {
        }

        public AddressBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public AddressBuilder user(User user) {
            this.user = user;
            return this;
        }

        public AddressBuilder label(String label) {
            this.label = label;
            return this;
        }

        public AddressBuilder addressLine(String addressLine) {
            this.addressLine = addressLine;
            return this;
        }

        public AddressBuilder landmark(String landmark) {
            this.landmark = landmark;
            return this;
        }

        public AddressBuilder city(String city) {
            this.city = city;
            return this;
        }

        public AddressBuilder state(String state) {
            this.state = state;
            return this;
        }

        public AddressBuilder pincode(String pincode) {
            this.pincode = pincode;
            return this;
        }

        public AddressBuilder latitude(Double latitude) {
            this.latitude = latitude;
            return this;
        }

        public AddressBuilder longitude(Double longitude) {
            this.longitude = longitude;
            return this;
        }

        public AddressBuilder isDefault(boolean isDefault) {
            this.isDefault = isDefault;
            return this;
        }

        public Address build() {
            return new Address(id, user, label, addressLine, landmark, city, state, pincode, latitude, longitude,
                    isDefault);
        }
    }
}
