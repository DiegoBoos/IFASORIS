import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/grupo_familiar_model.dart';

abstract class GrupoFamiliarRemoteDataSource {
  Future<GrupoFamiliarModel> uploadGrupoFamiliar();
}

class GrupoFamiliarRemoteDataSourceImpl
    implements GrupoFamiliarRemoteDataSource {
  final http.Client client;

  GrupoFamiliarRemoteDataSourceImpl({required this.client});

  @override
  Future<GrupoFamiliarModel> uploadGrupoFamiliar() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/crearGrupoFamiliar');

      final resp = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        }, /*  body: grupoFamiliar.toJson() */
      );

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = grupoFamiliarFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
