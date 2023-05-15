import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tipo_vivienda_model.dart';

abstract class TipoViviendaByDptoRemoteDataSource {
  Future<List<TipoViviendaModel>> getTiposViviendaByDpto(int dtoId);
}

class TipoViviendaByDptoRemoteDataSourceImpl
    implements TipoViviendaByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TipoViviendaByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoViviendaModel>> getTiposViviendaByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/tiposviviendaByDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tiposViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
