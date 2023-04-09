import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../core/error/failure.dart';
import '../../../../domain/entities/usuario_entity.dart';
import '../../../constants.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/usuario_model.dart';

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
        "userName": usuario.userName,
        "password": usuario.password
      };

      final uri = Uri.parse('${Constants.ifasorisBaseUrl}/usuarios/login');

      final resp = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(formData));

      final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
      if (resp.statusCode == 200) {
        final token = decodedResp['result']['token'];
        final resultMap = decodedResp['result']['usuario'];
        resultMap['password'] = usuario.password;
        resultMap['token'] = token;

        final result = UsuarioModel.fromJson(resultMap);
        final res = await saveUsuario(result);

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

  Future<int> saveUsuario(UsuarioEntity usuarioEntity) async {
    final db = await ConnectionSQLiteService.db;

    await db.delete('Usuario', where: 'id = ?', whereArgs: [usuarioEntity.id]);

    final res = await db.insert('Usuario', usuarioEntity.toJson());
    return res;
  }
}
