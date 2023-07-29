import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/esquema_vacunacion_model.dart';

abstract class EsquemaVacunacionRemoteDataSource {
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion();
}

class EsquemaVacunacionRemoteDataSourceImpl
    implements EsquemaVacunacionRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EsquemaVacunacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/esquemasvacunacion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = esquemasVacunacionFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
