import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/especie_animal.dart';

abstract class EspecieAnimalRemoteDataSource {
  Future<List<EspecieAnimalModel>> getEspeciesAnimales(int dtoId);
}

class EspecieAnimalRemoteDataSourceImpl
    implements EspecieAnimalRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  EspecieAnimalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EspecieAnimalModel>> getEspeciesAnimales(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${AppConfig.apiPublica}/especieanimalesbyDpto?IdeDpto=$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = especiesAnimalesFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
