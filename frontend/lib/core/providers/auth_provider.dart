import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_models.dart';
import '../network/dio_client.dart';
import '../services/auth_service.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final AuthResponse? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
  });

  AuthState copyWith({AuthStatus? status, AuthResponse? user, String? error}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  final DioClient _dioClient;

  AuthNotifier(this._authService, this._dioClient) : super(const AuthState());

  Future<void> tryAutoLogin() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final hasToken = await _authService.tryAutoLogin();
      if (hasToken) {
        final userJson = await _dioClient.loadUserJson();
        AuthResponse? user;
        if (userJson != null) {
          user = AuthResponse.fromJson(jsonDecode(userJson));
        }
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        );
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login(String phone, String password) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    try {
      final request = LoginRequest(phone: phone, password: password);
      final user = await _authService.login(request);
      await _dioClient.saveUserJson(jsonEncode({
        'token': user.token,
        'tokenType': user.tokenType,
        'userId': user.userId,
        'name': user.name,
        'phone': user.phone,
        'role': user.role,
      }));
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      String msg = 'Login failed';
      if (e.toString().contains('401')) msg = 'Invalid phone or password';
      if (e.toString().contains('SocketException')) msg = 'Cannot reach server';
      state = state.copyWith(status: AuthStatus.error, error: msg);
    }
  }

  Future<void> register(
      String name, String phone, String? email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    try {
      final request = RegisterRequest(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
      final user = await _authService.register(request);
      await _dioClient.saveUserJson(jsonEncode({
        'token': user.token,
        'tokenType': user.tokenType,
        'userId': user.userId,
        'name': user.name,
        'phone': user.phone,
        'role': user.role,
      }));
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      String msg = 'Registration failed';
      if (e.toString().contains('409')) msg = 'Phone already registered';
      if (e.toString().contains('SocketException')) msg = 'Cannot reach server';
      state = state.copyWith(status: AuthStatus.error, error: msg);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthService(dioClient);
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final dioClient = ref.watch(dioClientProvider);
  return AuthNotifier(authService, dioClient);
});
