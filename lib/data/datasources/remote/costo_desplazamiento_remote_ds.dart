import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/costo_desplazamiento_model.dart';

abstract class CostoDesplazamientoRemoteDataSource {
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento();
}

class CostoDesplazamientoRemoteDataSourceImpl
    implements CostoDesplazamientoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  CostoDesplazamientoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento() async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/costosdesplazamiento');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = costosDesplazamientoFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
