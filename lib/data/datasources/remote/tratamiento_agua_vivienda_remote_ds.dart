import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tratamiento_agua_vivienda.dart';

abstract class TratamientoAguaViviendaRemoteDataSource {
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAguaVivienda(
      int dtoId);
}

class TratamientoAguaViviendaRemoteDataSourceImpl
    implements TratamientoAguaViviendaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TratamientoAguaViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAguaVivienda(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${AppConfig.apiPublica}/tratamientoaguaviviendabyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            tratamientosAguaViviendaFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
