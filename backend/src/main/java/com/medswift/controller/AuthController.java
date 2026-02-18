package com.medswift.controller;

import com.medswift.dto.ApiResponse;
import com.medswift.dto.AuthDto;
import com.medswift.service.AuthService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@Tag(name = "Authentication", description = "Registration and login")
public class AuthController {

        private final AuthService authService;

        public AuthController(AuthService authService) {
                this.authService = authService;
        }

        @PostMapping("/register")
        @Operation(summary = "Register a new user")
        public ResponseEntity<ApiResponse.Success<AuthDto.AuthResponse>> register(
                        @Valid @RequestBody AuthDto.RegisterRequest request) {
                AuthDto.AuthResponse response = authService.register(request);
                return ResponseEntity.status(HttpStatus.CREATED)
                                .body(ApiResponse.Success.<AuthDto.AuthResponse>builder()
                                                .message("Registration successful")
                                                .data(response)
                                                .build());
        }

        @PostMapping("/login")
        @Operation(summary = "Login with phone and password")
        public ResponseEntity<ApiResponse.Success<AuthDto.AuthResponse>> login(
                        @Valid @RequestBody AuthDto.LoginRequest request) {
                AuthDto.AuthResponse response = authService.login(request);
                return ResponseEntity.ok(ApiResponse.Success.<AuthDto.AuthResponse>builder()
                                .message("Login successful")
                                .data(response)
                                .build());
        }
}
