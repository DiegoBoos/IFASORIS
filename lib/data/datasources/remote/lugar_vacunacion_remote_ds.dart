import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/lugar_vacunacion.dart';

abstract class LugarVacunacionRemoteDataSource {
  Future<List<LugarVacunacionModel>> getLugaresVacunacion();
}

class LugarVacunacionRemoteDataSourceImpl
    implements LugarVacunacionRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  LugarVacunacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LugarVacunacionModel>> getLugaresVacunacion() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/lugarvacunacion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = lugaresVacunacionFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
