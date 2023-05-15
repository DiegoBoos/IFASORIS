import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/servicio_publico_vivienda_model.dart';

abstract class ServicioPublicoViviendaByDptoRemoteDataSource {
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicosViviendaByDpto(
      int dtoId);
}

class ServicioPublicoViviendaByDptoRemoteDataSourceImpl
    implements ServicioPublicoViviendaByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ServicioPublicoViviendaByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicosViviendaByDpto(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/serviciospublicosviviendaByDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            serviciosPublicosViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
