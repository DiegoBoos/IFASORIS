import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ifasoris/services/shared_preferences_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../domain/entities/usuario.dart';
import '../../models/usuario.dart';

abstract class AuthRemoteDataSource {
  Future<User> logIn(UsuarioEntity usuario);
  Future<User> register(UsuarioEntity usuario);
  Future<String> cambioDispositivo(String userName, String idEquipo);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final prefs = SharedPreferencesService();

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<User> logIn(UsuarioEntity usuario) async {
    try {
      final decodedResp = await loginResponse(usuario);

      prefs.token = decodedResp['Result']['Token'];

      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: usuario.email,
        password: usuario.password!,
      );

      return res.user!;
    } on AuthException catch (e) {
      throw ServerFailure([e.message]);
    } catch (e) {
      throw const ServerFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<User> register(UsuarioEntity usuario) async {
    try {
      final decodedResp = await loginResponse(usuario);
      final usuarioModel =
          UsuarioModel.fromJson(decodedResp['Result']['Usuario']);

      final AuthResponse res = await supabase.auth.signUp(
        email: usuario.email,
        password: usuario.password!,
        data: {
          'UserName': usuarioModel.userName,
          'Device_Id': usuarioModel.deviceId,
          'Municipio_id': usuarioModel.municipioId,
          'Departamento_id': usuarioModel.departamentoId,
        },
      );

      return res.user!;
    } on AuthException catch (e) {
      throw ServerFailure([e.message]);
    } catch (e) {
      throw const ServerFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<String> cambioDispositivo(String userName, String idEquipo) async {
    try {
      final formData = {"UserName": userName, "Device_Id": idEquipo};

      final uri = Uri.parse('${AppConfig.apiPublica}/users/cambiodispositivo');

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
    } catch (e) {
      throw const ServerFailure([unexpectedErrorMessage]);
    }
  }

  Future<Map<String, dynamic>> loginResponse(UsuarioEntity usuario) async {
    try {
      final formData = {
        'UserName': usuario.userName,
        'Password': usuario.password,
        'Device_Id': usuario.deviceId,
      };

      final uri = Uri.parse('${AppConfig.apiPublica}/usuarios/login');

      final resp = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(formData));

      if (resp.statusCode == 200) {
        final decodedResp = jsonDecode(resp.body);
        return decodedResp;
      } else {
        final decodedErrorResp = jsonDecode(resp.body);
        throw ServerFailure(decodedErrorResp['ErrorMessages']);
      }
    } catch (e) {
      throw const ServerFailure([unexpectedErrorMessage]);
    }
  }
}
