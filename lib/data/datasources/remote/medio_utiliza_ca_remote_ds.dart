import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/medio_utiliza_ca.dart';

abstract class MedioUtilizaCARemoteDataSource {
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA(int ideDpto);
}

class MedioUtilizaCARemoteDataSourceImpl
    implements MedioUtilizaCARemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  MedioUtilizaCARemoteDataSourceImpl({required this.client});

  @override
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA(int ideDpto) async {
    try {
      final uri = Uri.parse(
          '${AppConfig.apiPublica}/mediosutilizaCentroAtencionbyDpto?IdeDpto=$ideDpto');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = mediosUtilizaCAFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
