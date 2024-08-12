import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/usuario.dart';

abstract class AuthLocalDataSource {
  Future<UsuarioModel?> logIn(UsuarioModel usuario);
  Future<int> logOut();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<UsuarioModel?> logIn(UsuarioModel usuario) async {
    try {
      final res = await supabase
          .from('usuario')
          .select()
          .eq('username', usuario.userName)
          .eq('password', usuario.password)
          .eq('device_id', usuario.deviceId);

      if (res.isEmpty) return null;

      final result = UsuarioModel.fromJson(res.data[0]);
      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> logOut() async {
    try {
      final prefs = SharedPreferencesService();
      final clearStorage = await prefs.clearStorage();

      final res = await supabase
          .from('usuario')
          .delete()
          .eq('your_condition_column', 'your_condition_value');

      if (clearStorage && res.data != null) {
        return 1; // or the appropriate success code
      } else {
        return 0;
      }
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
