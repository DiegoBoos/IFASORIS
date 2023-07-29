import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/servicio_solicitado_model.dart';

abstract class ServicioSolicitadoRemoteDataSource {
  Future<List<ServicioSolicitadoModel>> getServiciosSolicitados();
}

class ServicioSolicitadoRemoteDataSourceImpl
    implements ServicioSolicitadoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ServicioSolicitadoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ServicioSolicitadoModel>> getServiciosSolicitados() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/serviciossolicita');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = serviciosSolicitadosFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
