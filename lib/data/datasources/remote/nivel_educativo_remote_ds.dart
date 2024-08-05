import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/nivel_educativo.dart';

abstract class NivelEducativoRemoteDataSource {
  Future<List<NivelEducativoModel>> getNivelesEducativos();
}

class NivelEducativoRemoteDataSourceImpl
    implements NivelEducativoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  NivelEducativoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NivelEducativoModel>> getNivelesEducativos() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/niveleducativo');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = nivelesEducativosFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
