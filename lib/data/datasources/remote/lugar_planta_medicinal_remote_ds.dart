import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/lugar_planta_medicinal_model.dart';

abstract class LugarPlantaMedicinalRemoteDataSource {
  Future<List<LugarPlantaMedicinalModel>> getLugaresPlantasMedicinales();
}

class LugarPlantaMedicinalRemoteDataSourceImpl
    implements LugarPlantaMedicinalRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  LugarPlantaMedicinalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LugarPlantaMedicinalModel>> getLugaresPlantasMedicinales() async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/lugaresplantasmedicinales');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            lugaresPlantasMedicinalesFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
