import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/tiempo_tarda_med_tradicional_model.dart';

abstract class TiempoTardaMedTradicionalRemoteDataSource {
  Future<List<TiempoTardaMedTradicionalModel>> getTiemposTardaMedTradicional();
}

class TiempoTardaMedTradicionalRemoteDataSourceImpl
    implements TiempoTardaMedTradicionalRemoteDataSource {
  final http.Client client;

  TiempoTardaMedTradicionalRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TiempoTardaMedTradicionalModel>>
      getTiemposTardaMedTradicional() async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/tiempotardaCentroAtencion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            tiemposTardaMedTradicionalModelFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
