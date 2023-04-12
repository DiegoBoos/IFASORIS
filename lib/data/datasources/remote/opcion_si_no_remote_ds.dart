import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/opcion_si_no_model.dart';

abstract class OpcionSiNoRemoteDataSource {
  Future<List<OpcionSiNoModel>> getOpcionesSiNo();
}

class OpcionSiNoRemoteDataSourceImpl implements OpcionSiNoRemoteDataSource {
  final http.Client client;

  OpcionSiNoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<OpcionSiNoModel>> getOpcionesSiNo() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/opcionesSi_No');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await Constants.getToken()}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = opcionesSiNoModelFromJson(jsonEncode(decodedResp));
        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
