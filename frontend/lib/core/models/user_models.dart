class UserProfile {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String? dateOfBirth;
  final String? gender;
  final String? profileImageUrl;
  final String role;

  UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.profileImageUrl,
    this.role = 'USER',
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      role: json['role'] as String? ?? 'USER',
    );
  }
}

class UpdateProfileRequest {
  final String? name;
  final String? email;
  final String? dateOfBirth;
  final String? gender;

  UpdateProfileRequest({this.name, this.email, this.dateOfBirth, this.gender});

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (email != null) 'email': email,
        if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
        if (gender != null) 'gender': gender,
      };
}

class UserAddress {
  final int id;
  final String label;
  final String fullAddress;
  final String? city;
  final String? state;
  final String? pincode;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  UserAddress({
    required this.id,
    required this.label,
    required this.fullAddress,
    this.city,
    this.state,
    this.pincode,
    this.latitude,
    this.longitude,
    this.isDefault = false,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'] as int,
      label: json['label'] as String? ?? 'Home',
      fullAddress:
          json['fullAddress'] as String? ?? json['address'] as String? ?? '',
      city: json['city'] as String?,
      state: json['state'] as String?,
      pincode: json['pincode'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  static List<UserAddress> listFromJson(dynamic json) {
    return (json as List).map((e) => UserAddress.fromJson(e)).toList();
  }
}

class AddAddressRequest {
  final String label;
  final String fullAddress;
  final String city;
  final String state;
  final String pincode;
  final double? latitude;
  final double? longitude;
  final bool isDefault;

  AddAddressRequest({
    required this.label,
    required this.fullAddress,
    required this.city,
    required this.state,
    required this.pincode,
    this.latitude,
    this.longitude,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'fullAddress': fullAddress,
        'city': city,
        'state': state,
        'pincode': pincode,
        if (latitude != null) 'latitude': latitude,
        if (longitude != null) 'longitude': longitude,
        'isDefault': isDefault,
      };
}
