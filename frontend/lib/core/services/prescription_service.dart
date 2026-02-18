import '../network/dio_client.dart';

class PrescriptionService {
  final DioClient _client;

  PrescriptionService(this._client);

  Future<Map<String, dynamic>> uploadPrescription({
    String? doctorName,
    String? hospitalName,
  }) async {
    final response = await _client.post(
      ApiEndpoints.prescriptions,
      data: {
        if (doctorName != null) 'doctorName': doctorName,
        if (hospitalName != null) 'hospitalName': hospitalName,
      },
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> getPrescriptions() async {
    final response = await _client.get(ApiEndpoints.prescriptions);
    return (response.data['data'] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }

  Future<Map<String, dynamic>> getPrescriptionById(int id) async {
    final response = await _client.get(
      '${ApiEndpoints.prescriptions}/$id',
    );
    return response.data['data'] as Map<String, dynamic>;
  }
}
