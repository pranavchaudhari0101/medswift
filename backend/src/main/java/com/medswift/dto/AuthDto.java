package com.medswift.dto;

import jakarta.validation.constraints.*;

public class AuthDto {

    public static class RegisterRequest {
        @NotBlank(message = "Name is required")
        private String name;

        @NotBlank(message = "Phone is required")
        @Pattern(regexp = "^[6-9]\\d{9}$", message = "Invalid Indian phone number")
        private String phone;

        @Email(message = "Invalid email")
        private String email;

        @NotBlank(message = "Password is required")
        @Size(min = 6, message = "Password must be at least 6 characters")
        private String password;

        public RegisterRequest() {
        }

        public RegisterRequest(String name, String phone, String email, String password) {
            this.name = name;
            this.phone = phone;
            this.email = email;
            this.password = password;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }

    public static class LoginRequest {
        @NotBlank(message = "Phone is required")
        private String phone;

        @NotBlank(message = "Password is required")
        private String password;

        public LoginRequest() {
        }

        public LoginRequest(String phone, String password) {
            this.phone = phone;
            this.password = password;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }

    public static class AuthResponse {
        private String token;
        private String tokenType;
        private Long userId;
        private String name;
        private String phone;
        private String role;

        public AuthResponse() {
        }

        public AuthResponse(String token, String tokenType, Long userId, String name, String phone, String role) {
            this.token = token;
            this.tokenType = tokenType;
            this.userId = userId;
            this.name = name;
            this.phone = phone;
            this.role = role;
        }

        public String getToken() {
            return token;
        }

        public void setToken(String token) {
            this.token = token;
        }

        public String getTokenType() {
            return tokenType;
        }

        public void setTokenType(String tokenType) {
            this.tokenType = tokenType;
        }

        public Long getUserId() {
            return userId;
        }

        public void setUserId(Long userId) {
            this.userId = userId;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }

        public static AuthResponseBuilder builder() {
            return new AuthResponseBuilder();
        }

        public static class AuthResponseBuilder {
            private String token, tokenType, name, phone, role;
            private Long userId;

            public AuthResponseBuilder token(String token) {
                this.token = token;
                return this;
            }

            public AuthResponseBuilder tokenType(String tokenType) {
                this.tokenType = tokenType;
                return this;
            }

            public AuthResponseBuilder userId(Long userId) {
                this.userId = userId;
                return this;
            }

            public AuthResponseBuilder name(String name) {
                this.name = name;
                return this;
            }

            public AuthResponseBuilder phone(String phone) {
                this.phone = phone;
                return this;
            }

            public AuthResponseBuilder role(String role) {
                this.role = role;
                return this;
            }

            public AuthResponse build() {
                return new AuthResponse(token, tokenType, userId, name, phone, role);
            }
        }
    }
}
