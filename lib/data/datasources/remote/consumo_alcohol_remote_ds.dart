import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/consumo_alcohol.dart';

abstract class ConsumoAlcoholRemoteDataSource {
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol();
}

class ConsumoAlcoholRemoteDataSourceImpl
    implements ConsumoAlcoholRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ConsumoAlcoholRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol() async {
    try {
      final uri = Uri.parse('${AppConfig.apiPublica}/consumoalcohol');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = consumosAlcoholFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
