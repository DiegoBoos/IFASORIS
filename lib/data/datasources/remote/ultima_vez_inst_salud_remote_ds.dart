import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/ultima_vez_inst_salud_model.dart';

abstract class UltimaVezInstSaludRemoteDataSource {
  Future<List<UltimaVezInstSaludModel>> getUltimasVecesInstSalud();
}

class UltimaVezInstSaludRemoteDataSourceImpl
    implements UltimaVezInstSaludRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  UltimaVezInstSaludRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UltimaVezInstSaludModel>> getUltimasVecesInstSalud() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/ultimavezinstsalud');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = ultimasVecesInstSaludFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
