import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tipo_regimen.dart';

abstract class TipoRegimenRemoteDataSource {
  Future<List<TipoRegimenModel>> getTipoRegimenes();
}

class TipoRegimenRemoteDataSourceImpl implements TipoRegimenRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TipoRegimenRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoRegimenModel>> getTipoRegimenes() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/regimen');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tiporegimenesFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
