import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/enfermedad_acude.dart';

abstract class EnfermedadAcudeRemoteDataSource {
  Future<List<EnfermedadAcudeModel>> getEnfermedadesAcude();
}

class EnfermedadAcudeRemoteDataSourceImpl
    implements EnfermedadAcudeRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EnfermedadAcudeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EnfermedadAcudeModel>> getEnfermedadesAcude() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/enfermedadesacude');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = enfermedadesAcudeFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
