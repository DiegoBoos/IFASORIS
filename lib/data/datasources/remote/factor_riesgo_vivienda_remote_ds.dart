import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/factor_riesgo_vivienda.dart';

abstract class FactorRiesgoViviendaRemoteDataSource {
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgoVivienda(int dtoId);
}

class FactorRiesgoViviendaRemoteDataSourceImpl
    implements FactorRiesgoViviendaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  FactorRiesgoViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgoVivienda(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.apiPublica}/factoresriesgoviviendabyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = factoresRiesgoViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
