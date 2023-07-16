import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../models/estilo_vida_saludable_model.dart';

abstract class EstiloVidaSaludableRemoteDataSource {
  Future<EstiloVidaSaludableModel> uploadEstiloVidaSaludable();
}

class EstiloVidaSaludableRemoteDataSourceImpl
    implements EstiloVidaSaludableRemoteDataSource {
  final http.Client client;

  EstiloVidaSaludableRemoteDataSourceImpl({required this.client});

  @override
  Future<EstiloVidaSaludableModel> uploadEstiloVidaSaludable() async {
    try {
      final uri =
          Uri.parse('${Constants.ifasorisBaseUrl}/crearEstiloVidaSaludable');

      final resp = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        }, /*  body: estiloVidaSaludable.toJson() */
      );

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = estiloVidaSaludableFromJson(decodedResp);

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
