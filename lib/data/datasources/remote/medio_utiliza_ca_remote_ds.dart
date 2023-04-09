import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/medio_utiliza_ca_model.dart';

abstract class MedioUtilizaCARemoteDataSource {
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA();
}

class MedioUtilizaCARemoteDataSourceImpl
    implements MedioUtilizaCARemoteDataSource {
  final http.Client client;

  MedioUtilizaCARemoteDataSourceImpl({required this.client});

  @override
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA() async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/mediosutilizaCentroAtencion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = mediosUtilizaCAModelFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
