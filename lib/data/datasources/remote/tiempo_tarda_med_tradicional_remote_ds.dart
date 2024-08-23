import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tiempo_tarda_med_tradicional.dart';

abstract class TiempoTardaMedTradicionalRemoteDataSource {
  Future<List<TiempoTardaMedTradicionalModel>> getTiemposTardaMedTradicional();
}

class TiempoTardaMedTradicionalRemoteDataSourceImpl
    implements TiempoTardaMedTradicionalRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TiempoTardaMedTradicionalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TiempoTardaMedTradicionalModel>>
      getTiemposTardaMedTradicional() async {
    try {
      final uri =
          Uri.parse('${AppConfig.apiPublica}/tiempotardamedtradicional');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            tiemposTardaMedTradicionalFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
