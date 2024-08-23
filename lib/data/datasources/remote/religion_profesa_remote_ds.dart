import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/religion_profesa.dart';

abstract class ReligionProfesaRemoteDataSource {
  Future<List<ReligionProfesaModel>> getReligionesProfesa();
}

class ReligionProfesaRemoteDataSourceImpl
    implements ReligionProfesaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ReligionProfesaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ReligionProfesaModel>> getReligionesProfesa() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/religionesprofesa');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = religionesProfesaFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
