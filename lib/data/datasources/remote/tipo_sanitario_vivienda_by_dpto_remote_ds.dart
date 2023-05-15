import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tipo_sanitario_vivienda_model.dart';

abstract class TipoSanitarioViviendaByDptoRemoteDataSource {
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitarioViviendaByDpto(
      int dtoId);
}

class TipoSanitarioViviendaByDptoRemoteDataSourceImpl
    implements TipoSanitarioViviendaByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TipoSanitarioViviendaByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitarioViviendaByDpto(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/tiposanitarioviviendabyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tiposSanitarioViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
