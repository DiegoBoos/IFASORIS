import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/medio_utiliza_med_tradicional_model.dart';

abstract class MedioUtilizaMedTradicionalRemoteDataSource {
  Future<List<MedioUtilizaMedTradicionalModel>> getMediosUtilizaMedTradicional(
      int dtoId);
}

class MedioUtilizaMedTradicionalRemoteDataSourceImpl
    implements MedioUtilizaMedTradicionalRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  MedioUtilizaMedTradicionalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MedioUtilizaMedTradicionalModel>> getMediosUtilizaMedTradicional(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/mediosutilizamedtradicionalbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            mediosUtilizaMedTradicionalFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
