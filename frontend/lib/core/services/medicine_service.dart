import '../network/dio_client.dart';
import '../models/medicine_models.dart';

class MedicineService {
  final DioClient _client;

  MedicineService(this._client);

  Future<List<Medicine>> searchMedicines({
    String? query,
    int page = 0,
    int size = 20,
    String sortBy = 'name',
  }) async {
    final response = await _client.get(
      ApiEndpoints.medicines,
      queryParams: {
        if (query != null && query.isNotEmpty) 'query': query,
        'page': page,
        'size': size,
        'sortBy': sortBy,
      },
    );
    return Medicine.listFromJson(response.data['data']);
  }

  Future<Medicine> getMedicineById(int id) async {
    final response = await _client.get('${ApiEndpoints.medicines}/$id');
    return Medicine.fromJson(response.data['data']);
  }

  Future<List<Medicine>> getAlternatives(int id) async {
    final response = await _client.get(
      '${ApiEndpoints.medicines}/$id/alternatives',
    );
    return Medicine.listFromJson(response.data['data']);
  }

  Future<List<PriceComparison>> getPriceComparison(int id) async {
    final response = await _client.get(
      '${ApiEndpoints.medicines}/$id/pharmacies',
    );
    return PriceComparison.listFromJson(response.data['data']);
  }
}
