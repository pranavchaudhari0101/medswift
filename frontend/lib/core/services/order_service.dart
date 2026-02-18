import '../network/dio_client.dart';
import '../models/order_models.dart';

class OrderService {
  final DioClient _client;

  OrderService(this._client);

  Future<List<OrderResponse>> getOrders() async {
    final response = await _client.get(ApiEndpoints.orders);
    return OrderResponse.listFromJson(response.data['data']);
  }

  Future<OrderResponse> getOrderById(int id) async {
    final response = await _client.get('${ApiEndpoints.orders}/$id');
    return OrderResponse.fromJson(response.data['data']);
  }

  Future<OrderResponse> createOrder(CreateOrderRequest request) async {
    final response = await _client.post(
      ApiEndpoints.orders,
      data: request.toJson(),
    );
    return OrderResponse.fromJson(response.data['data']);
  }

  Future<OrderResponse> cancelOrder(int id) async {
    final response = await _client.put('${ApiEndpoints.orders}/$id/cancel');
    return OrderResponse.fromJson(response.data['data']);
  }
}
