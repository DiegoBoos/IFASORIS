import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/tuberculo_platano_model.dart';

abstract class TuberculoPlatanoByDptoRemoteDataSource {
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanosByDpto(int dtoId);
}

class TuberculoPlatanoByDptoRemoteDataSourceImpl
    implements TuberculoPlatanoByDptoRemoteDataSource {
  final http.Client client;

  TuberculoPlatanoByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanosByDpto(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/tuberculosplatanosbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tuberculosPlatanosModelFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
