import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/verdura.dart';

abstract class VerduraRemoteDataSource {
  Future<List<VerduraModel>> getVerduras(int dtoId);
}

class VerduraRemoteDataSourceImpl implements VerduraRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  VerduraRemoteDataSourceImpl({required this.client});

  @override
  Future<List<VerduraModel>> getVerduras(int dtoId) async {
    try {
      final uri =
          Uri.parse('${AppConfig.apiPublica}/verdurasbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = verdurasFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
