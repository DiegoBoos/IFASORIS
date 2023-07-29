import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/cuidado_salud_cond_riesgo_model.dart';

abstract class CuidadoSaludCondRiesgoRemoteDataSource {
  Future<CuidadoSaludCondRiesgoModel> uploadCuidadoSaludCondRiesgo();
}

class CuidadoSaludCondRiesgoRemoteDataSourceImpl
    implements CuidadoSaludCondRiesgoRemoteDataSource {
  final http.Client client;

  CuidadoSaludCondRiesgoRemoteDataSourceImpl({required this.client});

  @override
  Future<CuidadoSaludCondRiesgoModel> uploadCuidadoSaludCondRiesgo() async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/crearCuidadoSaludCondRiesgo');

      final resp = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        }, /*  body: cuidadoSaludCondRiesgo.toJson() */
      );

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = cuidadoSaludCondRiesgoFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
