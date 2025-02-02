import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/regimen.dart';

abstract class RegimenRemoteDataSource {
  Future<List<RegimenModel>> getRegimenes();
}

class RegimenRemoteDataSourceImpl implements RegimenRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  RegimenRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RegimenModel>> getRegimenes() async {
    try {
      final uri = Uri.parse('${Constants.apiPublica}/regimen');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = regimenesFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
