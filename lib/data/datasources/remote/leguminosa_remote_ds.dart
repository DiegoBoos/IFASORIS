import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/leguminosa.dart';

abstract class LeguminosaRemoteDataSource {
  Future<List<LeguminosaModel>> getLeguminosas(int dtoId);
}

class LeguminosaRemoteDataSourceImpl implements LeguminosaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  LeguminosaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LeguminosaModel>> getLeguminosas(int dtoId) async {
    try {
      final uri =
          Uri.parse('${AppConfig.apiPublica}/leguminosasbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = leguminosasFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
