import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/resguardo_model.dart';

abstract class ResguardoByDptoRemoteDataSource {
  Future<List<ResguardoModel>> getResguardosByDpto(int dtoId);
}

class ResguardoByDptoRemoteDataSourceImpl
    implements ResguardoByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  ResguardoByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ResguardoModel>> getResguardosByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/resguardosByDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = resguardosFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
