import '../../../core/constants.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/usuario.dart';

abstract class AuthLocalDataSource {
  Future<UsuarioModel?> logIn(UsuarioModel usuario);
  Future<int> logOut();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<UsuarioModel?> logIn(UsuarioModel usuario) async {
    final res = await supabase.from('usuario').select().eq(
        'username, password, device_id',
        [usuario.userName, usuario.password, usuario.deviceId]);

    if (res.isEmpty) return null;

    final result = UsuarioModel.fromJson(res);
    return result;
  }

  @override
  Future<int> logOut() async {
    final prefs = SharedPreferencesService();
    final clearStorage = await prefs.clearStorage();

    final res = await supabase.from('usuario').delete();

    if (clearStorage && res == 1) {
      return res;
    } else {
      return 0;
    }
  }

  static Future<int> saveUsuario(UsuarioModel usuario) async {
    await supabase.from('usuario').delete();

    final res = await supabase.from('usuario').insert(usuario.toJson());
    return res;
  }
}
