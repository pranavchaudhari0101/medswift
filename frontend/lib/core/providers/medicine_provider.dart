import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medicine_models.dart';
import '../network/dio_client.dart';
import '../services/medicine_service.dart';

final medicineServiceProvider = Provider<MedicineService>((ref) {
  return MedicineService(ref.watch(dioClientProvider));
});

/// Search medicines with optional query.
final medicineSearchProvider =
    FutureProvider.family<List<Medicine>, String?>((ref, query) async {
  final service = ref.watch(medicineServiceProvider);
  return service.searchMedicines(query: query);
});

/// Get a single medicine by ID.
final medicineDetailProvider =
    FutureProvider.family<Medicine, int>((ref, id) async {
  final service = ref.watch(medicineServiceProvider);
  return service.getMedicineById(id);
});

/// Get alternatives for a medicine.
final medicineAlternativesProvider =
    FutureProvider.family<List<Medicine>, int>((ref, id) async {
  final service = ref.watch(medicineServiceProvider);
  return service.getAlternatives(id);
});

/// Get price comparison for a medicine.
final medicinePricesProvider =
    FutureProvider.family<List<PriceComparison>, int>((ref, id) async {
  final service = ref.watch(medicineServiceProvider);
  return service.getPriceComparison(id);
});
