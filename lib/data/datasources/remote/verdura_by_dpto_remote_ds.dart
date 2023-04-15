import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/verdura_model.dart';

abstract class VerduraByDptoRemoteDataSource {
  Future<List<VerduraModel>> getVerdurasByDpto(int dtoId);
}

class VerduraByDptoRemoteDataSourceImpl
    implements VerduraByDptoRemoteDataSource {
  final http.Client client;

  VerduraByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<VerduraModel>> getVerdurasByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/verdurasbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = verdurasModelFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
