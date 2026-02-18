package com.medswift.controller;

import com.medswift.dto.ApiResponse;
import com.medswift.dto.OrderDto;
import com.medswift.model.User;
import com.medswift.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/orders")
@Tag(name = "Orders", description = "Order management")
public class OrderController {

        private final OrderService orderService;

        public OrderController(OrderService orderService) {
                this.orderService = orderService;
        }

        @PostMapping
        @Operation(summary = "Create a new order")
        public ResponseEntity<ApiResponse.Success<OrderDto.OrderResponse>> createOrder(
                        @AuthenticationPrincipal User user,
                        @Valid @RequestBody OrderDto.CreateOrderRequest request) {
                OrderDto.OrderResponse response = orderService.createOrder(user.getId(), request);
                return ResponseEntity.status(HttpStatus.CREATED)
                                .body(ApiResponse.Success.<OrderDto.OrderResponse>builder()
                                                .message("Order placed successfully")
                                                .data(response)
                                                .build());
        }

        @GetMapping
        @Operation(summary = "Get user's order history")
        public ResponseEntity<ApiResponse.Success<List<OrderDto.OrderResponse>>> getOrders(
                        @AuthenticationPrincipal User user) {
                return ResponseEntity.ok(ApiResponse.Success.<List<OrderDto.OrderResponse>>builder()
                                .data(orderService.getUserOrders(user.getId()))
                                .build());
        }

        @GetMapping("/{id}")
        @Operation(summary = "Get order details")
        public ResponseEntity<ApiResponse.Success<OrderDto.OrderResponse>> getOrder(
                        @AuthenticationPrincipal User user,
                        @PathVariable Long id) {
                return ResponseEntity.ok(ApiResponse.Success.<OrderDto.OrderResponse>builder()
                                .data(orderService.getOrderById(id, user.getId()))
                                .build());
        }

        @PutMapping("/{id}/cancel")
        @Operation(summary = "Cancel an order")
        public ResponseEntity<ApiResponse.Success<OrderDto.OrderResponse>> cancelOrder(
                        @AuthenticationPrincipal User user,
                        @PathVariable Long id) {
                return ResponseEntity.ok(ApiResponse.Success.<OrderDto.OrderResponse>builder()
                                .message("Order cancelled successfully")
                                .data(orderService.cancelOrder(id, user.getId()))
                                .build());
        }
}
