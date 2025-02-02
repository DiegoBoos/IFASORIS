import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/planta_medicinal.dart';

abstract class PlantaMedicinalRemoteDataSource {
  Future<List<PlantaMedicinalModel>> getPlantasMedicinales(int dtoId);
}

class PlantaMedicinalRemoteDataSourceImpl
    implements PlantaMedicinalRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  PlantaMedicinalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PlantaMedicinalModel>> getPlantasMedicinales(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.apiPublica}/plantasmedicinalesbyDpto?IdeDpto=$dtoId');

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
