import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../constants.dart';
import '../../models/dim_ubicacion_model.dart';

abstract class DimUbicacionRemoteDataSource {
  Future<DimUbicacionModel> createDimUbicacion(DimUbicacionEntity dimUbicacion);
}

class DimUbicacionRemoteDataSourceImpl implements DimUbicacionRemoteDataSource {
  final http.Client client;

  DimUbicacionRemoteDataSourceImpl({required this.client});

  @override
  Future<DimUbicacionModel> createDimUbicacion(
      DimUbicacionEntity dimUbicacion) async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/creatDimUbicacion');

      final resp = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: dimUbicacion.toJson());

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = dimUbicacionModelFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['DimUbicacion/contraseña no son correctos']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
