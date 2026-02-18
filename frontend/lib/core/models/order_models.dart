class CreateOrderRequest {
  final int pharmacyId;
  final int? prescriptionId;
  final List<OrderItemRequest> items;
  final String deliveryAddress;
  final String? paymentMethod;
  final String? specialInstructions;

  CreateOrderRequest({
    required this.pharmacyId,
    this.prescriptionId,
    required this.items,
    required this.deliveryAddress,
    this.paymentMethod,
    this.specialInstructions,
  });

  Map<String, dynamic> toJson() => {
        'pharmacyId': pharmacyId,
        if (prescriptionId != null) 'prescriptionId': prescriptionId,
        'items': items.map((e) => e.toJson()).toList(),
        'deliveryAddress': deliveryAddress,
        if (paymentMethod != null) 'paymentMethod': paymentMethod,
        if (specialInstructions != null)
          'specialInstructions': specialInstructions,
      };
}

class OrderItemRequest {
  final int medicineId;
  final int quantity;

  OrderItemRequest({required this.medicineId, required this.quantity});

  Map<String, dynamic> toJson() => {
        'medicineId': medicineId,
        'quantity': quantity,
      };
}

class OrderResponse {
  final int id;
  final int pharmacyId;
  final String? pharmacyName;
  final List<OrderItemResponse> items;
  final double totalAmount;
  final double? discount;
  final double? deliveryFee;
  final double? finalAmount;
  final String status;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? specialInstructions;
  final String? createdAt;
  final DeliveryInfo? delivery;

  OrderResponse({
    required this.id,
    required this.pharmacyId,
    this.pharmacyName,
    required this.items,
    required this.totalAmount,
    this.discount,
    this.deliveryFee,
    this.finalAmount,
    required this.status,
    this.paymentMethod,
    this.paymentStatus,
    this.specialInstructions,
    this.createdAt,
    this.delivery,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'] as int,
      pharmacyId: json['pharmacyId'] as int,
      pharmacyName: json['pharmacyName'] as String?,
      items: (json['items'] as List?)
              ?.map((e) => OrderItemResponse.fromJson(e))
              .toList() ??
          [],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble(),
      finalAmount: (json['finalAmount'] as num?)?.toDouble(),
      status: json['status'] as String,
      paymentMethod: json['paymentMethod'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      specialInstructions: json['specialInstructions'] as String?,
      createdAt: json['createdAt'] as String?,
      delivery: json['delivery'] != null
          ? DeliveryInfo.fromJson(json['delivery'])
          : null,
    );
  }

  static List<OrderResponse> listFromJson(dynamic json) {
    return (json as List).map((e) => OrderResponse.fromJson(e)).toList();
  }
}

class OrderItemResponse {
  final int medicineId;
  final String? medicineName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  OrderItemResponse({
    required this.medicineId,
    this.medicineName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) {
    return OrderItemResponse(
      medicineId: json['medicineId'] as int,
      medicineName: json['medicineName'] as String?,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}

class DeliveryInfo {
  final String? deliveryPartnerName;
  final String? deliveryPartnerPhone;
  final String? estimatedDeliveryTime;
  final double? currentLatitude;
  final double? currentLongitude;

  DeliveryInfo({
    this.deliveryPartnerName,
    this.deliveryPartnerPhone,
    this.estimatedDeliveryTime,
    this.currentLatitude,
    this.currentLongitude,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      deliveryPartnerName: json['deliveryPartnerName'] as String?,
      deliveryPartnerPhone: json['deliveryPartnerPhone'] as String?,
      estimatedDeliveryTime: json['estimatedDeliveryTime'] as String?,
      currentLatitude: (json['currentLatitude'] as num?)?.toDouble(),
      currentLongitude: (json['currentLongitude'] as num?)?.toDouble(),
    );
  }
}
