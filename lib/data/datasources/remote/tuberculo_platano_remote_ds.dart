import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tuberculo_platano.dart';

abstract class TuberculoPlatanoRemoteDataSource {
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos(int dtoId);
}

class TuberculoPlatanoRemoteDataSourceImpl
    implements TuberculoPlatanoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TuberculoPlatanoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.apiPublica}/tuberculosplatanosbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tuberculosPlatanosFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
