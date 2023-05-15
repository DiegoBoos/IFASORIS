import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/autoridad_indigena_model.dart';

abstract class AutoridadIndigenaRemoteDataSource {
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas();
}

class AutoridadIndigenaRemoteDataSourceImpl
    implements AutoridadIndigenaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  AutoridadIndigenaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/AutoridadIndigena');

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
