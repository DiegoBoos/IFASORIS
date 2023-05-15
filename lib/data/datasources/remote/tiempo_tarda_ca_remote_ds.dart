import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tiempo_tarda_ca_model.dart';

abstract class TiempoTardaCARemoteDataSource {
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA();
}

class TiempoTardaCARemoteDataSourceImpl
    implements TiempoTardaCARemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TiempoTardaCARemoteDataSourceImpl({required this.client});

  @override
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA() async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/tiempotardaCentroAtencion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tiemposTardaCAFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
