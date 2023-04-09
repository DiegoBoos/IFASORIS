import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/afiliado_response_model.dart';

abstract class AfiliadoRemoteDataSource {
  Future<AfiliadoResponseModel> getAfiliados(
      int dtoId, int pagina, int registrosPorPagina);
}

class AfiliadoRemoteDataSourceImpl implements AfiliadoRemoteDataSource {
  final http.Client client;

  AfiliadoRemoteDataSourceImpl({required this.client});

  @override
  Future<AfiliadoResponseModel> getAfiliados(
      int dtoId, int pagina, int registrosPorPagina) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/afiliados/$dtoId?pagina=$pagina&_RegistrosPorPagina=$registrosPorPagina');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = afiliadoResponseModelFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
