package com.medswift.dto;

public class PharmacyDto {

    public static class PharmacyResponse {
        private Long id;
        private String name;
        private String licenseNumber;
        private String address;
        private String city;
        private Double latitude;
        private Double longitude;
        private Double rating;
        private int totalRatings;
        private boolean isVerified;
        private String operatingHours;
        private boolean is24Hours;
        private String phoneNumber;
        private String imageUrl;
        private Double distance;

        public PharmacyResponse() {
        }

        public PharmacyResponse(Long id, String name, String licenseNumber, String address, String city,
                Double latitude, Double longitude, Double rating, int totalRatings, boolean isVerified,
                String operatingHours, boolean is24Hours, String phoneNumber, String imageUrl, Double distance) {
            this.id = id;
            this.name = name;
            this.licenseNumber = licenseNumber;
            this.address = address;
            this.city = city;
            this.latitude = latitude;
            this.longitude = longitude;
            this.rating = rating;
            this.totalRatings = totalRatings;
            this.isVerified = isVerified;
            this.operatingHours = operatingHours;
            this.is24Hours = is24Hours;
            this.phoneNumber = phoneNumber;
            this.imageUrl = imageUrl;
            this.distance = distance;
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

        public void setVerified(boolean isVerified) {
            this.isVerified = isVerified;
        }

        public String getOperatingHours() {
            return operatingHours;
        }

        public void setOperatingHours(String operatingHours) {
            this.operatingHours = operatingHours;
        }

        public boolean is24Hours() {
            return is24Hours;
        }

        public void set24Hours(boolean is24Hours) {
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

        public Double getDistance() {
            return distance;
        }

        public void setDistance(Double distance) {
            this.distance = distance;
        }

        public static PharmacyResponseBuilder builder() {
            return new PharmacyResponseBuilder();
        }

        public static class PharmacyResponseBuilder {
            private Long id;
            private String name, licenseNumber, address, city, operatingHours, phoneNumber, imageUrl;
            private Double latitude, longitude, rating, distance;
            private int totalRatings;
            private boolean isVerified, is24Hours;

            public PharmacyResponseBuilder id(Long id) {
                this.id = id;
                return this;
            }

            public PharmacyResponseBuilder name(String name) {
                this.name = name;
                return this;
            }

            public PharmacyResponseBuilder licenseNumber(String licenseNumber) {
                this.licenseNumber = licenseNumber;
                return this;
            }

            public PharmacyResponseBuilder address(String address) {
                this.address = address;
                return this;
            }

            public PharmacyResponseBuilder city(String city) {
                this.city = city;
                return this;
            }

            public PharmacyResponseBuilder latitude(Double latitude) {
                this.latitude = latitude;
                return this;
            }

            public PharmacyResponseBuilder longitude(Double longitude) {
                this.longitude = longitude;
                return this;
            }

            public PharmacyResponseBuilder rating(Double rating) {
                this.rating = rating;
                return this;
            }

            public PharmacyResponseBuilder totalRatings(int totalRatings) {
                this.totalRatings = totalRatings;
                return this;
            }

            public PharmacyResponseBuilder isVerified(boolean isVerified) {
                this.isVerified = isVerified;
                return this;
            }

            public PharmacyResponseBuilder operatingHours(String operatingHours) {
                this.operatingHours = operatingHours;
                return this;
            }

            public PharmacyResponseBuilder is24Hours(boolean is24Hours) {
                this.is24Hours = is24Hours;
                return this;
            }

            public PharmacyResponseBuilder phoneNumber(String phoneNumber) {
                this.phoneNumber = phoneNumber;
                return this;
            }

            public PharmacyResponseBuilder imageUrl(String imageUrl) {
                this.imageUrl = imageUrl;
                return this;
            }

            public PharmacyResponseBuilder distance(Double distance) {
                this.distance = distance;
                return this;
            }

            public PharmacyResponse build() {
                return new PharmacyResponse(id, name, licenseNumber, address, city, latitude, longitude, rating,
                        totalRatings, isVerified, operatingHours, is24Hours, phoneNumber, imageUrl, distance);
            }
        }
    }
}
