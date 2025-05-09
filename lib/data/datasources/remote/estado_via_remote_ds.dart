import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/estado_via_model.dart';

abstract class EstadoViaRemoteDataSource {
  Future<List<EstadoViaModel>> getEstadoVias();
}

class EstadoViaRemoteDataSourceImpl implements EstadoViaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EstadoViaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EstadoViaModel>> getEstadoVias() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/estadovias');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = estadosViasFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
