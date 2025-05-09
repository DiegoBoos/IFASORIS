import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/via_acceso_model.dart';

abstract class ViaAccesoRemoteDataSource {
  Future<List<ViaAccesoModel>> getViasAcceso();
}

class ViaAccesoRemoteDataSourceImpl implements ViaAccesoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ViaAccesoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ViaAccesoModel>> getViasAcceso() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/viasacceso');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = viasAccesoFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
