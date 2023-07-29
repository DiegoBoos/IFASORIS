import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/atencion_salud_model.dart';

abstract class AtencionSaludRemoteDataSource {
  Future<AtencionSaludModel> uploadAtencionSalud();
}

class AtencionSaludRemoteDataSourceImpl
    implements AtencionSaludRemoteDataSource {
  final http.Client client;

  AtencionSaludRemoteDataSourceImpl({required this.client});

  @override
  Future<AtencionSaludModel> uploadAtencionSalud() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/crearAtencionSalud');

      final resp = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        }, /*  body: atencionSalud.toJson() */
      );

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = atencionSaludFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
