import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/medio_comunicacion_model.dart';

abstract class MedioComunicacionRemoteDataSource {
  Future<List<MedioComunicacionModel>> getMediosComunicacion();
}

class MedioComunicacionRemoteDataSourceImpl
    implements MedioComunicacionRemoteDataSource {
  final http.Client client;

  MedioComunicacionRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MedioComunicacionModel>> getMediosComunicacion() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/medioscomunicacion');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      if (resp.statusCode == 200) {
        final decodedResp = jsonDecode(resp.body);
        final result = mediosComunicacionModelFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        final decodedResp = jsonDecode(resp.body);

        throw ServerFailure(decodedResp['errorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
