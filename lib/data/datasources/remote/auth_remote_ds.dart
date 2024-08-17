import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ifasoris/domain/usecases/auth/auth_exports.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../core/app_config.dart';
import '../../models/usuario.dart';

abstract class AuthRemoteDataSource {
  Future<UsuarioModel> logIn(UsuarioEntity usuario);
  Future<Map<String, dynamic>> register(UsuarioEntity usuario);
  Future<String> cambioDispositivo(String userName, String idEquipo);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final prefs = SharedPreferencesService();

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UsuarioModel> logIn(UsuarioEntity usuario) async {
    try {
      await supabase.auth.signInWithPassword(
        email: usuario.email,
        password: usuario.password!,
      );

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
        final resultMap = decodedResp['Result']['Usuario'];

        final result = UsuarioModel.fromJson(resultMap);
        return result;
      } else {
        final decodedErrorResp = jsonDecode(resp.body);
        throw ServerFailure(decodedErrorResp['ErrorMessages']);
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> register(UsuarioEntity usuario) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: usuario.email,
        password: usuario.password!,
        data: {
          'UserName': usuario.userName,
          'Device_Id': usuario.deviceId,
        },
      );

      final Session? session = res.session;
      final User? user = res.user;

      return {
        'session': session,
        'user': user,
      };
    } catch (e) {
      throw const ServerFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<String> cambioDispositivo(String userName, String idEquipo) async {
    try {
      final formData = {"UserName": userName, "Device_Id": idEquipo};

      final uri =
          Uri.parse('${AppConfig.apiPublica}/usuarios/cambiodispositivo');

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
