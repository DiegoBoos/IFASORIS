import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/leguminosa_model.dart';

abstract class LeguminosaByDptoRemoteDataSource {
  Future<List<LeguminosaModel>> getLeguminosasByDpto(int dtoId);
}

class LeguminosaByDptoRemoteDataSourceImpl
    implements LeguminosaByDptoRemoteDataSource {
  final http.Client client;

  LeguminosaByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LeguminosaModel>> getLeguminosasByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/leguminosasbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = leguminosasModelFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
