import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/condicion_nutricional.dart';

abstract class CondicionNutricionalRemoteDataSource {
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales();
}

class CondicionNutricionalRemoteDataSourceImpl
    implements CondicionNutricionalRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  CondicionNutricionalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales() async {
    try {
      final uri = Uri.parse('${Constants.apiPublica}/condicionesnutricionales');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            condicionesNutricionalesFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
