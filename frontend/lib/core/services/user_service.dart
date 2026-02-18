import '../network/dio_client.dart';
import '../models/user_models.dart';

class UserService {
  final DioClient _client;

  UserService(this._client);

  Future<UserProfile> getProfile() async {
    final response = await _client.get(ApiEndpoints.profile);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<UserProfile> updateProfile(UpdateProfileRequest request) async {
    final response = await _client.put(
      ApiEndpoints.profile,
      data: request.toJson(),
    );
    return UserProfile.fromJson(response.data['data']);
  }

  Future<List<UserAddress>> getAddresses() async {
    final response = await _client.get(ApiEndpoints.addresses);
    return UserAddress.listFromJson(response.data['data']);
  }

  Future<UserAddress> addAddress(AddAddressRequest request) async {
    final response = await _client.post(
      ApiEndpoints.addresses,
      data: request.toJson(),
    );
    return UserAddress.fromJson(response.data['data']);
  }
}
