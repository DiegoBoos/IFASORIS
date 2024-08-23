import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/nro_cuarto_vivienda.dart';

abstract class NroCuartoViviendaRemoteDataSource {
  Future<List<NroCuartoViviendaModel>> getNroCuartosVivienda();
}

class NroCuartoViviendaRemoteDataSourceImpl
    implements NroCuartoViviendaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  NroCuartoViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NroCuartoViviendaModel>> getNroCuartosVivienda() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/nrocuartosvivienda');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = nroCuartosViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
