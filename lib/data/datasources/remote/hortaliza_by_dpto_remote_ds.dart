import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/hortaliza_model.dart';

abstract class HortalizaByDptoRemoteDataSource {
  Future<List<HortalizaModel>> getHortalizasByDpto(int dtoId);
}

class HortalizaByDptoRemoteDataSourceImpl
    implements HortalizaByDptoRemoteDataSource {
  final http.Client client;

  HortalizaByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<HortalizaModel>> getHortalizasByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/hortalizasbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = hortalizasModelFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
