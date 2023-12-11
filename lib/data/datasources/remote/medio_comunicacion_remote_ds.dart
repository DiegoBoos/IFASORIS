import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/medio_comunicacion_model.dart';

abstract class MedioComunicacionRemoteDataSource {
  Future<List<MedioComunicacionModel>> getMediosComunicacion(int dtoId);
}

class MedioComunicacionRemoteDataSourceImpl
    implements MedioComunicacionRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  MedioComunicacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MedioComunicacionModel>> getMediosComunicacion(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/medioscomunicacionByDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = mediosComunicacionFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
