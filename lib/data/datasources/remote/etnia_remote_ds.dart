import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/etnia_model.dart';

abstract class EtniaRemoteDataSource {
  Future<List<EtniaModel>> getEtnias();
}

class EtniaRemoteDataSourceImpl implements EtniaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EtniaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EtniaModel>> getEtnias() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/etnias');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = etniasFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
