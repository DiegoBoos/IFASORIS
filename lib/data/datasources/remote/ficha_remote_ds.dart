import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../../domain/entities/ficha_entity.dart';
import '../../../constants.dart';
import '../../models/ficha_model.dart';

abstract class FichaRemoteDataSource {
  Future<FichaModel> createFicha(FichaEntity ficha);
}

class FichaRemoteDataSourceImpl implements FichaRemoteDataSource {
  final http.Client client;

  FichaRemoteDataSourceImpl({required this.client});

  @override
  Future<FichaModel> createFicha(FichaEntity ficha) async {
    try {
      final formData = {"UserName": ficha.userName};

      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/creatficha');

      final resp = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(formData));

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = fichaFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Ficha/contraseña no son correctos']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
