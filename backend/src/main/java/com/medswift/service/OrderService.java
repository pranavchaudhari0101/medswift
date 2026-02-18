package com.medswift.service;

import com.medswift.dto.OrderDto;
import com.medswift.exception.BadRequestException;
import com.medswift.exception.ResourceNotFoundException;
import com.medswift.model.*;
import com.medswift.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final PharmacyRepository pharmacyRepository;
    private final MedicineRepository medicineRepository;
    private final PharmacyInventoryRepository inventoryRepository;
    private final DeliveryRepository deliveryRepository;
    private final PrescriptionRepository prescriptionRepository;

    public OrderService(OrderRepository orderRepository, UserRepository userRepository,
            PharmacyRepository pharmacyRepository, MedicineRepository medicineRepository,
            PharmacyInventoryRepository inventoryRepository, DeliveryRepository deliveryRepository,
            PrescriptionRepository prescriptionRepository) {
        this.orderRepository = orderRepository;
        this.userRepository = userRepository;
        this.pharmacyRepository = pharmacyRepository;
        this.medicineRepository = medicineRepository;
        this.inventoryRepository = inventoryRepository;
        this.deliveryRepository = deliveryRepository;
        this.prescriptionRepository = prescriptionRepository;
    }

    @Transactional
    public OrderDto.OrderResponse createOrder(Long userId, OrderDto.CreateOrderRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        Pharmacy pharmacy = pharmacyRepository.findById(request.getPharmacyId())
                .orElseThrow(() -> new ResourceNotFoundException("Pharmacy not found"));

        Order order = Order.builder()
                .user(user)
                .pharmacy(pharmacy)
                .deliveryAddress(request.getDeliveryAddress())
                .specialInstructions(request.getSpecialInstructions())
                .totalAmount(BigDecimal.ZERO)
                .build();

        if (request.getPaymentMethod() != null) {
            order.setPaymentMethod(Order.PaymentMethod.valueOf(request.getPaymentMethod().toUpperCase()));
        }

        if (request.getPrescriptionId() != null) {
            Prescription prescription = prescriptionRepository.findById(request.getPrescriptionId())
                    .orElseThrow(() -> new ResourceNotFoundException("Prescription not found"));
            order.setPrescription(prescription);
        }

        BigDecimal total = BigDecimal.ZERO;
        for (OrderDto.OrderItemRequest itemReq : request.getItems()) {
            Medicine medicine = medicineRepository.findById(itemReq.getMedicineId())
                    .orElseThrow(() -> new ResourceNotFoundException("Medicine not found: " + itemReq.getMedicineId()));

            PharmacyInventory inventory = inventoryRepository
                    .findByPharmacyIdAndMedicineId(pharmacy.getId(), medicine.getId())
                    .orElseThrow(() -> new BadRequestException(
                            "Medicine not available at this pharmacy: " + medicine.getName()));

            if (!inventory.isInStock()) {
                throw new BadRequestException("Medicine out of stock: " + medicine.getName());
            }

            BigDecimal unitPrice = inventory.getPrice();
            BigDecimal itemTotal = unitPrice.multiply(BigDecimal.valueOf(itemReq.getQuantity()));

            OrderItem item = OrderItem.builder()
                    .order(order)
                    .medicine(medicine)
                    .quantity(itemReq.getQuantity())
                    .unitPrice(unitPrice)
                    .totalPrice(itemTotal)
                    .build();

            order.getItems().add(item);
            total = total.add(itemTotal);
        }

        order.setTotalAmount(total);
        order = orderRepository.save(order);

        Delivery delivery = Delivery.builder()
                .order(order)
                .estimatedDeliveryTime(LocalDateTime.now().plusMinutes(45))
                .deliveryPartnerName("Ravi Kumar")
                .deliveryPartnerPhone("9876543210")
                .build();
        deliveryRepository.save(delivery);

        return mapToResponse(order, delivery);
    }

    public List<OrderDto.OrderResponse> getUserOrders(Long userId) {
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId)
                .stream()
                .map(order -> {
                    Delivery delivery = deliveryRepository.findByOrderId(order.getId()).orElse(null);
                    return mapToResponse(order, delivery);
                })
                .collect(Collectors.toList());
    }

    public OrderDto.OrderResponse getOrderById(Long orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found"));

        if (!order.getUser().getId().equals(userId)) {
            throw new BadRequestException("Order does not belong to this user");
        }

        Delivery delivery = deliveryRepository.findByOrderId(orderId).orElse(null);
        return mapToResponse(order, delivery);
    }

    @Transactional
    public OrderDto.OrderResponse cancelOrder(Long orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found"));

        if (!order.getUser().getId().equals(userId)) {
            throw new BadRequestException("Order does not belong to this user");
        }

        if (order.getStatus() == Order.OrderStatus.DELIVERED || order.getStatus() == Order.OrderStatus.CANCELLED) {
            throw new BadRequestException("Cannot cancel order in " + order.getStatus() + " status");
        }

        order.setStatus(Order.OrderStatus.CANCELLED);
        order = orderRepository.save(order);

        Delivery delivery = deliveryRepository.findByOrderId(orderId).orElse(null);
        return mapToResponse(order, delivery);
    }

    private OrderDto.OrderResponse mapToResponse(Order order, Delivery delivery) {
        List<OrderDto.OrderItemResponse> items = order.getItems().stream()
                .map(item -> OrderDto.OrderItemResponse.builder()
                        .medicineId(item.getMedicine().getId())
                        .medicineName(item.getMedicine().getName())
                        .medicineImageUrl(item.getMedicine().getImageUrl())
                        .quantity(item.getQuantity())
                        .unitPrice(item.getUnitPrice())
                        .totalPrice(item.getTotalPrice())
                        .build())
                .collect(Collectors.toList());

        OrderDto.DeliveryInfo deliveryInfo = null;
        if (delivery != null) {
            deliveryInfo = OrderDto.DeliveryInfo.builder()
                    .status(delivery.getStatus().name())
                    .deliveryPartnerName(delivery.getDeliveryPartnerName())
                    .deliveryPartnerPhone(delivery.getDeliveryPartnerPhone())
                    .estimatedDeliveryTime(delivery.getEstimatedDeliveryTime())
                    .currentLatitude(delivery.getCurrentLatitude())
                    .currentLongitude(delivery.getCurrentLongitude())
                    .build();
        }

        return OrderDto.OrderResponse.builder()
                .id(order.getId())
                .pharmacyId(order.getPharmacy().getId())
                .pharmacyName(order.getPharmacy().getName())
                .items(items)
                .totalAmount(order.getTotalAmount())
                .discount(order.getDiscount())
                .deliveryAddress(order.getDeliveryAddress())
                .status(order.getStatus().name())
                .paymentMethod(order.getPaymentMethod().name())
                .paymentStatus(order.getPaymentStatus().name())
                .specialInstructions(order.getSpecialInstructions())
                .createdAt(order.getCreatedAt())
                .delivery(deliveryInfo)
                .build();
    }
}
