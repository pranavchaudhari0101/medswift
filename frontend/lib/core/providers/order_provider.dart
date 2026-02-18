import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_models.dart';
import '../network/dio_client.dart';
import '../services/order_service.dart';

final orderServiceProvider = Provider<OrderService>((ref) {
  return OrderService(ref.watch(dioClientProvider));
});

/// All user orders.
final ordersProvider = FutureProvider<List<OrderResponse>>((ref) async {
  final service = ref.watch(orderServiceProvider);
  return service.getOrders();
});

/// Single order by ID.
final orderDetailProvider =
    FutureProvider.family<OrderResponse, int>((ref, id) async {
  final service = ref.watch(orderServiceProvider);
  return service.getOrderById(id);
});
