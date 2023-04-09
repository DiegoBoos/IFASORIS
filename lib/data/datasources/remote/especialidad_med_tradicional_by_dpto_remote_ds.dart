import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/especialidad_med_tradicional_by_dpto_model.dart';

abstract class EspecialidadMedTradicionalByDptoRemoteDataSource {
  Future<List<EspecialidadMedTradicionalByDptoModel>>
      getEspecialidadesMedTradicionalByDpto(int dtoId);
}

class EspecialidadMedTradicionalByDptoRemoteDataSourceImpl
    implements EspecialidadMedTradicionalByDptoRemoteDataSource {
  final http.Client client;

  EspecialidadMedTradicionalByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EspecialidadMedTradicionalByDptoModel>>
      getEspecialidadesMedTradicionalByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/especialidadesmedtradicionalbyDpto/$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            especialidadesMedTradicionalByDptoFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
