import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/dificultad_acceso_ca_model.dart';

abstract class DificultadAccesoCARemoteDataSource {
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA();
}

class DificultadAccesoCARemoteDataSourceImpl
    implements DificultadAccesoCARemoteDataSource {
  final http.Client client;

  DificultadAccesoCARemoteDataSourceImpl({required this.client});

  @override
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA() async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/dificultadesaccesoCentroAtencion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            dificultadesAccesoCAModelFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
