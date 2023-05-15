import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/dim_ubicacion_model.dart';

abstract class DimUbicacionRemoteDataSource {
  Future<DimUbicacionModel> uploadDimUbicacion();
}

class DimUbicacionRemoteDataSourceImpl implements DimUbicacionRemoteDataSource {
  final http.Client client;

  DimUbicacionRemoteDataSourceImpl({required this.client});

  @override
  Future<DimUbicacionModel> uploadDimUbicacion() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/crearDimUbicacion');

      final resp = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        }, /*  body: dimUbicacion.toJson() */
      );

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = dimUbicacionFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
