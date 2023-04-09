import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/estado_via_model.dart';

abstract class EstadoViaRemoteDataSource {
  Future<List<EstadoViaModel>> getEstadosVias();
}

class EstadoViaRemoteDataSourceImpl implements EstadoViaRemoteDataSource {
  final http.Client client;

  EstadoViaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EstadoViaModel>> getEstadosVias() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/estadovias');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = estadosViasModelFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
