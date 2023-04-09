import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/resguardo_by_dpto_model.dart';

abstract class ResguardoByDptoRemoteDataSource {
  Future<List<ResguardoByDptoModel>> getResguardosByDpto(int dtoId);
}

class ResguardoByDptoRemoteDataSourceImpl
    implements ResguardoByDptoRemoteDataSource {
  final http.Client client;

  ResguardoByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ResguardoByDptoModel>> getResguardosByDpto(int dtoId) async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/resguardosByDpto/$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = resguardosByDptoModelFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
