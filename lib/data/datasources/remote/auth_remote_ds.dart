import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../models/usuario_model.dart';
import '../local/auth_local_ds.dart';

abstract class AuthRemoteDataSource {
  Future<UsuarioModel> logIn(UsuarioEntity usuario);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UsuarioModel> logIn(UsuarioEntity usuario) async {
    try {
      final formData = {
        "UserName": usuario.userName,
        "Password": usuario.password
      };

      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/usuarios/login');

      final resp = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(formData));

      final decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final token = decodedResp['Result']['Token'];
        final resultMap = decodedResp['Result']['Usuario'];
        resultMap['Password'] = usuario.password;
        resultMap['Token'] = token;

        final result = UsuarioModel.fromJson(resultMap);
        final res = await AuthLocalDataSourceImpl.saveUsuario(result);

        if (res == 1) {
          return result;
        } else {
          throw const ServerFailure(['Error de autenticación']);
        }
      } else {
        throw const ServerFailure(['Usuario/contraseña no son correctos']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
