package com.medswift.controller;

import com.medswift.dto.ApiResponse;
import com.medswift.dto.UserDto;
import com.medswift.model.User;
import com.medswift.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@Tag(name = "Users", description = "User profile management")
public class UserController {

        private final UserService userService;

        public UserController(UserService userService) {
                this.userService = userService;
        }

        @GetMapping("/me")
        @Operation(summary = "Get current user's profile")
        public ResponseEntity<ApiResponse.Success<UserDto.UserResponse>> getProfile(
                        @AuthenticationPrincipal User user) {
                return ResponseEntity.ok(ApiResponse.Success.<UserDto.UserResponse>builder()
                                .data(userService.getProfile(user.getId()))
                                .build());
        }

        @PutMapping("/me")
        @Operation(summary = "Update user profile")
        public ResponseEntity<ApiResponse.Success<UserDto.UserResponse>> updateProfile(
                        @AuthenticationPrincipal User user,
                        @Valid @RequestBody UserDto.UpdateProfileRequest request) {
                return ResponseEntity.ok(ApiResponse.Success.<UserDto.UserResponse>builder()
                                .message("Profile updated")
                                .data(userService.updateProfile(user.getId(), request))
                                .build());
        }

        @GetMapping("/me/addresses")
        @Operation(summary = "Get user's saved addresses")
        public ResponseEntity<ApiResponse.Success<List<UserDto.AddressResponse>>> getAddresses(
                        @AuthenticationPrincipal User user) {
                return ResponseEntity.ok(ApiResponse.Success.<List<UserDto.AddressResponse>>builder()
                                .data(userService.getAddresses(user.getId()))
                                .build());
        }

        @PostMapping("/me/addresses")
        @Operation(summary = "Add a new address")
        public ResponseEntity<ApiResponse.Success<UserDto.AddressResponse>> addAddress(
                        @AuthenticationPrincipal User user,
                        @Valid @RequestBody UserDto.AddAddressRequest request) {
                return ResponseEntity.status(HttpStatus.CREATED)
                                .body(ApiResponse.Success.<UserDto.AddressResponse>builder()
                                                .message("Address added")
                                                .data(userService.addAddress(user.getId(), request))
                                                .build());
        }
}
