import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/metodo_planificacion.dart';

abstract class MetodoPlanificacionRemoteDataSource {
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion();
}

class MetodoPlanificacionRemoteDataSourceImpl
    implements MetodoPlanificacionRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  MetodoPlanificacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/metodosplanificacion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = metodosPlanificacionFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
