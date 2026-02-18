import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pharmacy_models.dart';
import '../network/dio_client.dart';
import '../services/pharmacy_service.dart';

final pharmacyServiceProvider = Provider<PharmacyService>((ref) {
  return PharmacyService(ref.watch(dioClientProvider));
});

/// List pharmacies, optionally filtered by city.
final pharmacyListProvider =
    FutureProvider.family<List<Pharmacy>, String?>((ref, city) async {
  final service = ref.watch(pharmacyServiceProvider);
  return service.getPharmacies(city: city);
});

/// Get a single pharmacy by ID.
final pharmacyDetailProvider =
    FutureProvider.family<Pharmacy, int>((ref, id) async {
  final service = ref.watch(pharmacyServiceProvider);
  return service.getPharmacyById(id);
});
