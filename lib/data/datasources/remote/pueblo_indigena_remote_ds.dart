import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/pueblo_indigena.dart';

abstract class PuebloIndigenaRemoteDataSource {
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas(int dtoId);
}

class PuebloIndigenaRemoteDataSourceImpl
    implements PuebloIndigenaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  PuebloIndigenaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${AppConfig.apiPublica}/pueblosindigenasbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = pueblosIndigenasFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
