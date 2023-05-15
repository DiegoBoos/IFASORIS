import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tratamiento_agua_vivienda_model.dart';

abstract class TratamientoAguaViviendaByDptoRemoteDataSource {
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAguaViviendaByDpto(
      int dtoId);
}

class TratamientoAguaViviendaByDptoRemoteDataSourceImpl
    implements TratamientoAguaViviendaByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TratamientoAguaViviendaByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAguaViviendaByDpto(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/tratamientoaguaviviendabyDpto?IdeDpto=$dtoId');

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
