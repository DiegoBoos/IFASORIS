import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/medio_utiliza_med_tradicional_by_dpto_model.dart';

abstract class MedioUtilizaMedTradicionalByDptoRemoteDataSource {
  Future<List<MedioUtilizaMedTradicionalByDptoModel>>
      getMediosUtilizaMedTradicionalByDpto(int dtoId);
}

class MedioUtilizaMedTradicionalByDptoRemoteDataSourceImpl
    implements MedioUtilizaMedTradicionalByDptoRemoteDataSource {
  final http.Client client;

  MedioUtilizaMedTradicionalByDptoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MedioUtilizaMedTradicionalByDptoModel>>
      getMediosUtilizaMedTradicionalByDpto(int dtoId) async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/mediosutilizamedtradicionalbyDpto/$dtoId');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            mediosUtilizaMedTradicionalByDptoFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
