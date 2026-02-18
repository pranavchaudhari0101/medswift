class LoginRequest {
  final String phone;
  final String password;

  LoginRequest({required this.phone, required this.password});

  Map<String, dynamic> toJson() => {'phone': phone, 'password': password};
}

class RegisterRequest {
  final String name;
  final String phone;
  final String? email;
  final String password;

  RegisterRequest({
    required this.name,
    required this.phone,
    this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        if (email != null) 'email': email,
        'password': password,
      };
}

class AuthResponse {
  final String token;
  final String tokenType;
  final int userId;
  final String name;
  final String phone;
  final String role;

  AuthResponse({
    required this.token,
    required this.tokenType,
    required this.userId,
    required this.name,
    required this.phone,
    required this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      tokenType: json['tokenType'] as String? ?? 'Bearer',
      userId: json['userId'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String? ?? 'USER',
    );
  }
}
