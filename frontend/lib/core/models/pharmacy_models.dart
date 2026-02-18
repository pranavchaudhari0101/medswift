class Pharmacy {
  final int id;
  final String name;
  final String? licenseNumber;
  final String? address;
  final String? city;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final int? totalRatings;
  final bool isVerified;
  final String? operatingHours;
  final bool is24Hours;
  final String? phoneNumber;
  final String? imageUrl;

  Pharmacy({
    required this.id,
    required this.name,
    this.licenseNumber,
    this.address,
    this.city,
    this.latitude,
    this.longitude,
    this.rating,
    this.totalRatings,
    this.isVerified = false,
    this.operatingHours,
    this.is24Hours = false,
    this.phoneNumber,
    this.imageUrl,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'] as int,
      name: json['name'] as String,
      licenseNumber: json['licenseNumber'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      totalRatings: json['totalRatings'] as int?,
      isVerified: json['isVerified'] as bool? ?? false,
      operatingHours: json['operatingHours'] as String?,
      is24Hours: json['is24Hours'] as bool? ?? false,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  static List<Pharmacy> listFromJson(dynamic json) {
    return (json as List).map((e) => Pharmacy.fromJson(e)).toList();
  }
}
