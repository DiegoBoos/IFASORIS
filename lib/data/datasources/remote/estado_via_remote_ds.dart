import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/estado_via.dart';

abstract class EstadoViaRemoteDataSource {
  Future<List<EstadoViaModel>> getEstadoVias();
}

class EstadoViaRemoteDataSourceImpl implements EstadoViaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EstadoViaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EstadoViaModel>> getEstadoVias() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/estadovias');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = estadosViasFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
