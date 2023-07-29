import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/dimension_sociocultural_pueblos_indigenas_model.dart';

abstract class DimensionSocioculturalPueblosIndigenasRemoteDataSource {
  Future<DimensionSocioculturalPueblosIndigenasModel>
      uploadDimensionSocioculturalPueblosIndigenas();
}

class DimensionSocioculturalPueblosIndigenasRemoteDataSourceImpl
    implements DimensionSocioculturalPueblosIndigenasRemoteDataSource {
  final http.Client client;

  DimensionSocioculturalPueblosIndigenasRemoteDataSourceImpl(
      {required this.client});

  @override
  Future<DimensionSocioculturalPueblosIndigenasModel>
      uploadDimensionSocioculturalPueblosIndigenas() async {
    try {
      final uri = Uri.parse(
          '${Constants.ifasorisBaseUrl}/crearDimensionSocioculturalPueblosIndigenas');

      final resp = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        }, /*  body: dimensionSocioculturalPueblosIndigenas.toJson() */
      );

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result =
            dimensionSocioculturalPueblosIndigenasFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
