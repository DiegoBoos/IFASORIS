import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/techo_vivienda.dart';

abstract class TechoViviendaRemoteDataSource {
  Future<List<TechoViviendaModel>> getTechosVivienda(int dtoId);
}

class TechoViviendaRemoteDataSourceImpl
    implements TechoViviendaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TechoViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TechoViviendaModel>> getTechosVivienda(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.apiPublica}/techoviviendabyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = techosViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
