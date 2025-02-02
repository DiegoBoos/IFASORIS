import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/dificultad_acceso_ca.dart';

abstract class DificultadAccesoCARemoteDataSource {
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA();
}

class DificultadAccesoCARemoteDataSourceImpl
    implements DificultadAccesoCARemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  DificultadAccesoCARemoteDataSourceImpl({required this.client});

  @override
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA() async {
    try {
      final uri =
          Uri.parse('${Constants.apiPublica}/dificultadesaccesoCentroAtencion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = dificultadesAccesoCAFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
