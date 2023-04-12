import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/cereal_model.dart';

abstract class CerealByDptoRemoteDataSource {
  Future<List<CerealModel>> getCerealesByDpto(int dtoId);
}

class CerealByDptoRemoteDataSourceImpl implements CerealByDptoRemoteDataSource {
  final http.Client client;

  CerealByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CerealModel>> getCerealesByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/cerealesbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = cerealesModelFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
