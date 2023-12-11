import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/evento_costumbre_participa_model.dart';

abstract class EventoCostumbreParticipaRemoteDataSource {
  Future<List<EventoCostumbreParticipaModel>> getEventosCostumbresParticipa(
      int dtoId);
}

class EventoCostumbreParticipaRemoteDataSourceImpl
    implements EventoCostumbreParticipaRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EventoCostumbreParticipaRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EventoCostumbreParticipaModel>> getEventosCostumbresParticipa(
      int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/eventoscostumbresparticipaByDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            eventosCostumbresParticipaFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
