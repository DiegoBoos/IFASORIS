import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tipo_calendario.dart';

abstract class TipoCalendarioRemoteDataSource {
  Future<List<TipoCalendarioModel>> getTiposCalendario();
}

class TipoCalendarioRemoteDataSourceImpl
    implements TipoCalendarioRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TipoCalendarioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoCalendarioModel>> getTiposCalendario() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/tiposcalendario');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tiposCalendarioFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
