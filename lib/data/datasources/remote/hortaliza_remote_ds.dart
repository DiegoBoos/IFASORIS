import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/hortaliza.dart';

abstract class HortalizaRemoteDataSource {
  Future<List<HortalizaModel>> getHortalizas(int dtoId);
}

class HortalizaRemoteDataSourceImpl implements HortalizaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  HortalizaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<HortalizaModel>> getHortalizas(int dtoId) async {
    try {
      final uri =
          Uri.parse('${AppConfig.apiPublica}/hortalizasbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = hortalizasFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
