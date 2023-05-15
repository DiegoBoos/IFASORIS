import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/iluminacion_vivienda_model.dart';

abstract class IluminacionViviendaRemoteDataSource {
  Future<List<IluminacionViviendaModel>> getIluminacionesVivienda();
}

class IluminacionViviendaRemoteDataSourceImpl
    implements IluminacionViviendaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  IluminacionViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<IluminacionViviendaModel>> getIluminacionesVivienda() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/iluminacionvivienda');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = iluminacionesViviendaFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
