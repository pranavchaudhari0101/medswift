package com.medswift.dto;

import jakarta.validation.constraints.*;

public class UserDto {

    public static class UserResponse {
        private Long id;
        private String name;
        private String email;
        private String phone;
        private String dob;
        private String gender;
        private String profileImageUrl;

        public UserResponse() {
        }

        public UserResponse(Long id, String name, String email, String phone, String dob, String gender,
                String profileImageUrl) {
            this.id = id;
            this.name = name;
            this.email = email;
            this.phone = phone;
            this.dob = dob;
            this.gender = gender;
            this.profileImageUrl = profileImageUrl;
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

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getDob() {
            return dob;
        }

        public void setDob(String dob) {
            this.dob = dob;
        }

        public String getGender() {
            return gender;
        }

        public void setGender(String gender) {
            this.gender = gender;
        }

        public String getProfileImageUrl() {
            return profileImageUrl;
        }

        public void setProfileImageUrl(String profileImageUrl) {
            this.profileImageUrl = profileImageUrl;
        }

        public static UserResponseBuilder builder() {
            return new UserResponseBuilder();
        }

        public static class UserResponseBuilder {
            private Long id;
            private String name, email, phone, dob, gender, profileImageUrl;

            public UserResponseBuilder id(Long id) {
                this.id = id;
                return this;
            }

            public UserResponseBuilder name(String name) {
                this.name = name;
                return this;
            }

            public UserResponseBuilder email(String email) {
                this.email = email;
                return this;
            }

            public UserResponseBuilder phone(String phone) {
                this.phone = phone;
                return this;
            }

            public UserResponseBuilder dob(String dob) {
                this.dob = dob;
                return this;
            }

            public UserResponseBuilder gender(String gender) {
                this.gender = gender;
                return this;
            }

            public UserResponseBuilder profileImageUrl(String profileImageUrl) {
                this.profileImageUrl = profileImageUrl;
                return this;
            }

            public UserResponse build() {
                return new UserResponse(id, name, email, phone, dob, gender, profileImageUrl);
            }
        }
    }

    public static class UpdateProfileRequest {
        private String name;
        @Email
        private String email;
        private String dob;
        private String gender;

        public UpdateProfileRequest() {
        }

        public UpdateProfileRequest(String name, String email, String dob, String gender) {
            this.name = name;
            this.email = email;
            this.dob = dob;
            this.gender = gender;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getDob() {
            return dob;
        }

        public void setDob(String dob) {
            this.dob = dob;
        }

        public String getGender() {
            return gender;
        }

        public void setGender(String gender) {
            this.gender = gender;
        }
    }

    public static class AddAddressRequest {
        @NotBlank
        private String label;
        @NotBlank
        private String addressLine;
        private String landmark;
        @NotBlank
        private String city;
        @NotBlank
        private String state;
        @NotBlank
        private String pincode;
        private Double latitude;
        private Double longitude;
        private boolean isDefault;

        public AddAddressRequest() {
        }

        public AddAddressRequest(String label, String addressLine, String landmark, String city, String state,
                String pincode, Double latitude, Double longitude, boolean isDefault) {
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
    }

    public static class AddressResponse {
        private Long id;
        private String label;
        private String addressLine;
        private String landmark;
        private String city;
        private String state;
        private String pincode;
        private Double latitude;
        private Double longitude;
        private boolean isDefault;

        public AddressResponse() {
        }

        public AddressResponse(Long id, String label, String addressLine, String landmark, String city, String state,
                String pincode, Double latitude, Double longitude, boolean isDefault) {
            this.id = id;
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

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
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

        public static AddressResponseBuilder builder() {
            return new AddressResponseBuilder();
        }

        public static class AddressResponseBuilder {
            private Long id;
            private String label, addressLine, landmark, city, state, pincode;
            private Double latitude, longitude;
            private boolean isDefault;

            public AddressResponseBuilder id(Long id) {
                this.id = id;
                return this;
            }

            public AddressResponseBuilder label(String label) {
                this.label = label;
                return this;
            }

            public AddressResponseBuilder addressLine(String addressLine) {
                this.addressLine = addressLine;
                return this;
            }

            public AddressResponseBuilder landmark(String landmark) {
                this.landmark = landmark;
                return this;
            }

            public AddressResponseBuilder city(String city) {
                this.city = city;
                return this;
            }

            public AddressResponseBuilder state(String state) {
                this.state = state;
                return this;
            }

            public AddressResponseBuilder pincode(String pincode) {
                this.pincode = pincode;
                return this;
            }

            public AddressResponseBuilder latitude(Double latitude) {
                this.latitude = latitude;
                return this;
            }

            public AddressResponseBuilder longitude(Double longitude) {
                this.longitude = longitude;
                return this;
            }

            public AddressResponseBuilder isDefault(boolean isDefault) {
                this.isDefault = isDefault;
                return this;
            }

            public AddressResponse build() {
                return new AddressResponse(id, label, addressLine, landmark, city, state, pincode, latitude, longitude,
                        isDefault);
            }
        }
    }
}
