import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/costumbre_practica.dart';

abstract class CostumbrePracticaRemoteDataSource {
  Future<List<CostumbrePracticaModel>> getCostumbresPractican(int dtoId);
}

class CostumbrePracticaRemoteDataSourceImpl
    implements CostumbrePracticaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  CostumbrePracticaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CostumbrePracticaModel>> getCostumbresPractican(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${AppConfig.apiPublica}/costumbrespracticanByDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = costumbresPracticanFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
