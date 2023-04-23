import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/especie_animal_model.dart';

abstract class EspecieAnimalByDptoRemoteDataSource {
  Future<List<EspecieAnimalModel>> getEspeciesAnimalesByDpto(int dtoId);
}

class EspecieAnimalByDptoRemoteDataSourceImpl
    implements EspecieAnimalByDptoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EspecieAnimalByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EspecieAnimalModel>> getEspeciesAnimalesByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/especieanimalesbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await prefs.get('token')}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = especiesAnimalesModelFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
