import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/nombre_enfermedad.dart';

abstract class NombreEnfermedadRemoteDataSource {
  Future<List<NombreEnfermedadModel>> getNombresEnfermedades();
}

class NombreEnfermedadRemoteDataSourceImpl
    implements NombreEnfermedadRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  NombreEnfermedadRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NombreEnfermedadModel>> getNombresEnfermedades() async {
    try {
      final uri = Uri.parse('${Constants.apiPublica}/nombresenfermedad');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = nombresEnfermedadesFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
