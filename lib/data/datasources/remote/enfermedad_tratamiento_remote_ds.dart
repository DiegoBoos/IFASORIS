import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/enfermedad_tratamiento.dart';

abstract class EnfermedadTratamientoRemoteDataSource {
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento();
}

class EnfermedadTratamientoRemoteDataSourceImpl
    implements EnfermedadTratamientoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EnfermedadTratamientoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/enfermedadestratamientos');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = enfermedadesTratamientoFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
