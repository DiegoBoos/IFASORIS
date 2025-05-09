import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/ventilacion_vivienda_model.dart';

abstract class VentilacionViviendaRemoteDataSource {
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda();
}

class VentilacionViviendaRemoteDataSourceImpl
    implements VentilacionViviendaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  VentilacionViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/ventilacionvivienda');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = ventilacionesViviendaFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
