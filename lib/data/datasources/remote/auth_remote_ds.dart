import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ifasoris/services/shared_preferences_service.dart';

import '../../../core/error/failure.dart';

import '../../../core/constants.dart';
import '../../models/usuario.dart';
import '../local/auth_local_ds.dart';

abstract class AuthRemoteDataSource {
  Future<UsuarioModel> logIn(UsuarioModel usuario);

  Future<String> cambioDispositivo(String userName, String idEquipo);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final prefs = SharedPreferencesService();

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UsuarioModel> logIn(UsuarioModel usuario) async {
    try {
      final formData = {
        "UserName": usuario.userName,
        "Password": usuario.password,
        "Device_Id": usuario.deviceId
      };

      final uri = Uri.parse('${Constants.apiPublica}/usuarios/login');

      final resp = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(formData));

      if (resp.statusCode == 200) {
        final decodedResp = jsonDecode(resp.body);
        final token = decodedResp['Result']['Token'];
        final resultMap = decodedResp['Result']['Usuario'];
        resultMap['Password'] = usuario.password;

        final result = UsuarioModel.fromJson(resultMap);
        final res = await AuthLocalDataSourceImpl.saveUsuario(result);

        if (res == 1) {
          prefs.token = token;
          return result;
        } else {
          throw const ServerFailure(['Error de autenticación']);
        }
      } else {
        if (resp.body != '') {
          final decodedErrorResp = jsonDecode(resp.body);
          throw ServerFailure(decodedErrorResp['ErrorMessages']);
        } else {
          throw const ServerFailure(['Excepción no controlada']);
        }
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<String> cambioDispositivo(String userName, String idEquipo) async {
    try {
      final formData = {"UserName": userName, "Device_Id": idEquipo};

      final uri =
          Uri.parse('${Constants.apiPublica}/usuarios/cambiodispositivo');

      final resp = await client.put(uri,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.token}',
          },
          body: jsonEncode(formData));

      final decodedResp = jsonDecode(resp.body);
      if (decodedResp['StatusCode'] == 200) {
        return decodedResp['ErrorMessages'][0];
      } else {
        throw const ServerFailure(['Excepción no controlada']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }
}
