import 'medicine_models.dart';

/// Local cart item — not persisted on backend until order is placed.
class CartItem {
  final Medicine medicine;
  final int pharmacyId;
  final String pharmacyName;
  final double price;
  int quantity;

  CartItem({
    required this.medicine,
    required this.pharmacyId,
    required this.pharmacyName,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({int? quantity}) {
    return CartItem(
      medicine: medicine,
      pharmacyId: pharmacyId,
      pharmacyName: pharmacyName,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}
