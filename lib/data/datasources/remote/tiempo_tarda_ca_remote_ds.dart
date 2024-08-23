import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tiempo_tarda_ca.dart';

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
          Uri.parse('${AppConfig.apiPublica}/tiempotardaCentroAtencion');

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
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
