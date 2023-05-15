import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/dificultad_acceso_med_tradicional_model.dart';

abstract class DificultadAccesoMedTradicionalByDptoRemoteDataSource {
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicionalByDpto(int dtoId);
}

class DificultadAccesoMedTradicionalByDptoRemoteDataSourceImpl
    implements DificultadAccesoMedTradicionalByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  DificultadAccesoMedTradicionalByDptoRemoteDataSourceImpl(
      {required this.client});

  @override
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicionalByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/dificultadesaccesomedtradicionalbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            dificultadesAccesoMedTradicionalFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
