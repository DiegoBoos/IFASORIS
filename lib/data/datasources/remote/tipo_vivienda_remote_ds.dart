import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tipo_vivienda.dart';

abstract class TipoViviendaRemoteDataSource {
  Future<List<TipoViviendaModel>> getTiposVivienda(int dtoId);
}

class TipoViviendaRemoteDataSourceImpl implements TipoViviendaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TipoViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoViviendaModel>> getTiposVivienda(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${AppConfig.apiPublica}/tioposviviendabyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tiposViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
