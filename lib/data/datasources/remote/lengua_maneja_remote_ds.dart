import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/lengua_maneja_model.dart';

abstract class LenguaManejaRemoteDataSource {
  Future<List<LenguaManejaModel>> getLenguasManeja();
}

class LenguaManejaRemoteDataSourceImpl implements LenguaManejaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  LenguaManejaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<LenguaManejaModel>> getLenguasManeja() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/lenguamaneja');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = lenguasManejaFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
