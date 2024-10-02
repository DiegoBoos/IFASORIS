import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ifasoris/services/shared_preferences_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../../domain/entities/usuario.dart';

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
      final AuthResponse res = await supabase.auth.signUp(
        email: usuario.email,
        password: usuario.password!,
        data: {
          'UserName': usuario.userName,
          'Device_Id': usuario.deviceId,
          'Municipio_id': usuario.municipioId,
          'Departamento_id': usuario.departamentoId,
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
        throw const ServerFailure([unexpectedErrorMessage]);
      }
    } catch (e) {
      throw const ServerFailure([unexpectedErrorMessage]);
    }
  }
}
