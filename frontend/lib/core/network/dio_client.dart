import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiEndpoints {
  static const String baseUrl = 'http://localhost:8080';
  static const String auth = '/api/auth';
  static const String register = '$auth/register';
  static const String login = '$auth/login';
  static const String users = '/api/users';
  static const String profile = '$users/me';
  static const String addresses = '$profile/addresses';
  static const String medicines = '/api/medicines';
  static const String pharmacies = '/api/pharmacies';
  static const String prescriptions = '/api/prescriptions';
  static const String orders = '/api/orders';
}

class DioClient {
  late final Dio _dio;
  String? _authToken;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _tokenKey = 'medswift_jwt';
  static const _userKey = 'medswift_user';

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_authToken != null) {
          options.headers['Authorization'] = 'Bearer $_authToken';
        }
        if (kDebugMode) {
          debugPrint('→ ${options.method} ${options.path}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          debugPrint(
              '← ${response.statusCode} ${response.requestOptions.path}');
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        if (kDebugMode) {
          debugPrint(
              '✖ ${error.response?.statusCode} ${error.requestOptions.path}: ${error.message}');
        }
        return handler.next(error);
      },
    ));
  }

  // --- Token persistence ---

  Future<void> setAuthToken(String token) async {
    _authToken = token;
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> clearAuthToken() async {
    _authToken = null;
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }

  Future<String?> loadToken() async {
    _authToken = await _storage.read(key: _tokenKey);
    return _authToken;
  }

  bool get hasToken => _authToken != null;
  String? get token => _authToken;

  Future<void> saveUserJson(String json) async {
    await _storage.write(key: _userKey, value: json);
  }

  Future<String?> loadUserJson() async {
    return await _storage.read(key: _userKey);
  }

  // --- HTTP helpers ---

  Dio get dio => _dio;

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) =>
      _dio.get(path, queryParameters: queryParams);

  Future<Response> post(String path, {dynamic data}) =>
      _dio.post(path, data: data);

  Future<Response> put(String path, {dynamic data}) =>
      _dio.put(path, data: data);

  Future<Response> delete(String path) => _dio.delete(path);
}

final dioClientProvider = Provider<DioClient>((ref) => DioClient());
