import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/especialidad_med_tradicional.dart';

abstract class EspecialidadMedTradicionalRemoteDataSource {
  Future<List<EspecialidadMedTradicionalModel>> getEspecialidadesMedTradicional(
      int dtoId);
}

class EspecialidadMedTradicionalRemoteDataSourceImpl
    implements EspecialidadMedTradicionalRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EspecialidadMedTradicionalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EspecialidadMedTradicionalModel>> getEspecialidadesMedTradicional(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.apiPublica}/especialidadesmedtradicionalbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            especialidadesMedTradicionalFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
