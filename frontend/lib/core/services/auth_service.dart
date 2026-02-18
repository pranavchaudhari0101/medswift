import '../network/dio_client.dart';
import '../models/auth_models.dart';

class AuthService {
  final DioClient _client;

  AuthService(this._client);

  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _client.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );
    final authResponse = AuthResponse.fromJson(response.data['data']);
    await _client.setAuthToken(authResponse.token);
    return authResponse;
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    final response = await _client.post(
      ApiEndpoints.register,
      data: request.toJson(),
    );
    final authResponse = AuthResponse.fromJson(response.data['data']);
    await _client.setAuthToken(authResponse.token);
    return authResponse;
  }

  Future<void> logout() async {
    await _client.clearAuthToken();
  }

  Future<bool> tryAutoLogin() async {
    final token = await _client.loadToken();
    return token != null;
  }
}
