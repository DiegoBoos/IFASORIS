import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/dim_vivienda_model.dart';

abstract class DimViviendaRemoteDataSource {
  Future<DimViviendaModel> uploadDimVivienda();
}

class DimViviendaRemoteDataSourceImpl implements DimViviendaRemoteDataSource {
  final http.Client client;

  DimViviendaRemoteDataSourceImpl({required this.client});

  @override
  Future<DimViviendaModel> uploadDimVivienda() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/crearDimVivienda');

      final resp = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        }, /*  body: dimVivienda.toJson() */
      );

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = dimViviendaFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
