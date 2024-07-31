import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/actividad_fisica.dart';

abstract class ActividadFisicaRemoteDataSource {
  Future<List<ActividadFisicaModel>> getActividadesFisicas();
}

class ActividadFisicaRemoteDataSourceImpl
    implements ActividadFisicaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ActividadFisicaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ActividadFisicaModel>> getActividadesFisicas() async {
    try {
      final uri = Uri.parse('${Constants.apiPublica}/actividadesfisicas');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = actividadesFisicasFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
