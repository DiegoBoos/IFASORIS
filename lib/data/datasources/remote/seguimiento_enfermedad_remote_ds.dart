import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/seguimiento_enfermedad_model.dart';

abstract class SeguimientoEnfermedadRemoteDataSource {
  Future<List<SeguimientoEnfermedadModel>> getSeguimientoEnfermedades();
}

class SeguimientoEnfermedadRemoteDataSourceImpl
    implements SeguimientoEnfermedadRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  SeguimientoEnfermedadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SeguimientoEnfermedadModel>> getSeguimientoEnfermedades() async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/seguimientoenfermedad');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = seguimientoEnfermedadesFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
