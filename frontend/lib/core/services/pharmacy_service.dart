import '../network/dio_client.dart';
import '../models/pharmacy_models.dart';

class PharmacyService {
  final DioClient _client;

  PharmacyService(this._client);

  Future<List<Pharmacy>> getPharmacies({
    String? city,
    double? lat,
    double? lng,
  }) async {
    final response = await _client.get(
      ApiEndpoints.pharmacies,
      queryParams: {
        if (city != null) 'city': city,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      },
    );
    return Pharmacy.listFromJson(response.data['data']);
  }

  Future<Pharmacy> getPharmacyById(int id) async {
    final response = await _client.get('${ApiEndpoints.pharmacies}/$id');
    return Pharmacy.fromJson(response.data['data']);
  }
}
