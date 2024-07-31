import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/servicio_publico_vivienda.dart';

abstract class ServicioPublicoViviendaRemoteDataSource {
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicosVivienda(
      int dtoId);
}

class ServicioPublicoViviendaRemoteDataSourceImpl
    implements ServicioPublicoViviendaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ServicioPublicoViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicosVivienda(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.apiPublica}/serviciospublicosviviendabyDpto?IdeDpto=$dtoId');

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
