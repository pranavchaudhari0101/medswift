class Medicine {
  final int id;
  final String name;
  final String? genericName;
  final String? composition;
  final String? manufacturer;
  final String? category;
  final bool requiresPrescription;
  final String? description;
  final String? sideEffects;
  final String? dosage;
  final double? mrp;
  final String? imageUrl;
  final String? type;

  Medicine({
    required this.id,
    required this.name,
    this.genericName,
    this.composition,
    this.manufacturer,
    this.category,
    this.requiresPrescription = false,
    this.description,
    this.sideEffects,
    this.dosage,
    this.mrp,
    this.imageUrl,
    this.type,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] as int,
      name: json['name'] as String,
      genericName: json['genericName'] as String?,
      composition: json['composition'] as String?,
      manufacturer: json['manufacturer'] as String?,
      category: json['category'] as String?,
      requiresPrescription: json['requiresPrescription'] as bool? ?? false,
      description: json['description'] as String?,
      sideEffects: json['sideEffects'] as String?,
      dosage: json['dosage'] as String?,
      mrp: (json['mrp'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      type: json['type'] as String?,
    );
  }

  static List<Medicine> listFromJson(dynamic json) {
    return (json as List).map((e) => Medicine.fromJson(e)).toList();
  }
}

class PriceComparison {
  final int pharmacyId;
  final String pharmacyName;
  final String? pharmacyAddress;
  final double? pharmacyRating;
  final double price;
  final bool inStock;
  final String? operatingHours;
  final double? distance;

  PriceComparison({
    required this.pharmacyId,
    required this.pharmacyName,
    this.pharmacyAddress,
    this.pharmacyRating,
    required this.price,
    this.inStock = true,
    this.operatingHours,
    this.distance,
  });

  factory PriceComparison.fromJson(Map<String, dynamic> json) {
    return PriceComparison(
      pharmacyId: json['pharmacyId'] as int,
      pharmacyName: json['pharmacyName'] as String,
      pharmacyAddress: json['pharmacyAddress'] as String?,
      pharmacyRating: (json['pharmacyRating'] as num?)?.toDouble(),
      price: (json['price'] as num).toDouble(),
      inStock: json['inStock'] as bool? ?? true,
      operatingHours: json['operatingHours'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );
  }

  static List<PriceComparison> listFromJson(dynamic json) {
    return (json as List).map((e) => PriceComparison.fromJson(e)).toList();
  }
}
