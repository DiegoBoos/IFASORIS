import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/conducta_seguir.dart';

abstract class ConductaSeguirRemoteDataSource {
  Future<List<ConductaSeguirModel>> getConductasSeguir();
}

class ConductaSeguirRemoteDataSourceImpl
    implements ConductaSeguirRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ConductaSeguirRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ConductaSeguirModel>> getConductasSeguir() async {
    try {
      final uri = Uri.parse('${Constants.apiPublica}/conductaseguir');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = conductasSeguirFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
