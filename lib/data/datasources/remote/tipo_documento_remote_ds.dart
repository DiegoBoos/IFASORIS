import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/tipo_documento_model.dart';

abstract class TipoDocumentoRemoteDataSource {
  Future<List<TipoDocumentoModel>> getTiposDocumento();
}

class TipoDocumentoRemoteDataSourceImpl
    implements TipoDocumentoRemoteDataSource {
  final prefs = SharedPreferencesService();
  final http.Client client;

  TipoDocumentoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TipoDocumentoModel>> getTiposDocumento() async {
    try {
      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/tiposdocumento');

      final resp = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.token}',
      });

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final result = tiposDocumentoFromJson(jsonEncode(decodedResp));

        return result;
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
