import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/medicine_models.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(
      Medicine medicine, int pharmacyId, String pharmacyName, double price) {
    final idx = state.indexWhere((e) => e.medicine.id == medicine.id);
    if (idx >= 0) {
      final updated = [...state];
      updated[idx] = updated[idx].copyWith(quantity: updated[idx].quantity + 1);
      state = updated;
    } else {
      state = [
        ...state,
        CartItem(
          medicine: medicine,
          pharmacyId: pharmacyId,
          pharmacyName: pharmacyName,
          price: price,
        ),
      ];
    }
  }

  void removeItem(int medicineId) {
    state = state.where((e) => e.medicine.id != medicineId).toList();
  }

  void updateQuantity(int medicineId, int qty) {
    if (qty <= 0) {
      removeItem(medicineId);
      return;
    }
    final updated = state.map((e) {
      if (e.medicine.id == medicineId) return e.copyWith(quantity: qty);
      return e;
    }).toList();
    state = updated;
  }

  void clear() => state = [];

  double get subtotal => state.fold(0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => state.isEmpty ? 0 : 25.0;

  double get total => subtotal + deliveryFee;

  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);

  /// The pharmacy ID from the first item (all items should be from same pharmacy).
  int? get pharmacyId => state.isNotEmpty ? state.first.pharmacyId : null;

  String? get pharmacyName =>
      state.isNotEmpty ? state.first.pharmacyName : null;
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});
