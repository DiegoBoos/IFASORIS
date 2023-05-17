import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tipo_combustible_vivienda_model.dart';

abstract class TipoCombustibleViviendaByDptoRemoteDataSource {
  Future<List<TipoCombustibleViviendaModel>> getTiposCombustibleViviendaByDpto(
      int dtoId);
}

class TipoCombustibleViviendaByDptoRemoteDataSourceImpl
    implements TipoCombustibleViviendaByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TipoCombustibleViviendaByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoCombustibleViviendaModel>> getTiposCombustibleViviendaByDpto(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/tiposcombustibleviviendabyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            tiposCombustibleViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
