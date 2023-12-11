import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/nombre_lengua_materna_model.dart';

abstract class NombreLenguaMaternaRemoteDataSource {
  Future<List<NombreLenguaMaternaModel>> getNombresLenguasMaterna(int dtoId);
}

class NombreLenguaMaternaRemoteDataSourceImpl
    implements NombreLenguaMaternaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  NombreLenguaMaternaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NombreLenguaMaternaModel>> getNombresLenguasMaterna(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/nombrelenguamanejaByDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = nombresLenguasMaternaFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
