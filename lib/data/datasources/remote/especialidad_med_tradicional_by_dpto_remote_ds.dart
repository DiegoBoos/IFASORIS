import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/especialidad_med_tradicional_model.dart';

abstract class EspecialidadMedTradicionalByDptoRemoteDataSource {
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicionalByDpto(int dtoId);
}

class EspecialidadMedTradicionalByDptoRemoteDataSourceImpl
    implements EspecialidadMedTradicionalByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EspecialidadMedTradicionalByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicionalByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/especialidadesmedtradicionalbyDpto?IdeDpto=$dtoId');

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
