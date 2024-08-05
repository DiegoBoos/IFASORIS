import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/autoridad_indigena.dart';

abstract class AutoridadIndigenaRemoteDataSource {
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas(int dtoId);
}

class AutoridadIndigenaRemoteDataSourceImpl
    implements AutoridadIndigenaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  AutoridadIndigenaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${AppConfig.apiPublica}/AutoridadIndigenaByDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = autoridadesIndigenasFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
