import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/planta_medicinal_model.dart';

abstract class PlantaMedicinalRemoteDataSource {
  Future<List<PlantaMedicinalModel>> getPlantasMedicinales();
}

class PlantaMedicinalRemoteDataSourceImpl
    implements PlantaMedicinalRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  PlantaMedicinalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PlantaMedicinalModel>> getPlantasMedicinales() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/plantasmedicinales');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = plantasMedicinalesFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
