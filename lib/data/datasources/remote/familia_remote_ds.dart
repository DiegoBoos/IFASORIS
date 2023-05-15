import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../../domain/entities/familia_entity.dart';
import '../../../constants.dart';
import '../../models/familia_model.dart';

abstract class FamiliaRemoteDataSource {
  Future<FamiliaModel> createFamilia(FamiliaEntity familia);
}

class FamiliaRemoteDataSourceImpl implements FamiliaRemoteDataSource {
  final http.Client client;

  FamiliaRemoteDataSourceImpl({required this.client});

  @override
  Future<FamiliaModel> createFamilia(FamiliaEntity familia) async {
    try {
      final formData = {"ApellidosFlia": familia.apellidosFlia};

      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/createfamilia');

      final resp = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(formData));

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = familiaFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Familia/contraseña no son correctos']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
