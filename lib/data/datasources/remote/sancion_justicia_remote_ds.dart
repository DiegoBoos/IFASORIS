import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/sancion_justicia.dart';

abstract class SancionJusticiaRemoteDataSource {
  Future<List<SancionJusticiaModel>> getSancionesJusticia();
}

class SancionJusticiaRemoteDataSourceImpl
    implements SancionJusticiaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  SancionJusticiaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SancionJusticiaModel>> getSancionesJusticia() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/sancionesjusticia');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = sancionesJusticiaFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
