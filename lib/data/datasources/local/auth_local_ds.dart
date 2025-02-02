import '../../../services/connection_sqlite_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../models/usuario.dart';

abstract class AuthLocalDataSource {
  Future<UsuarioModel?> logIn(UsuarioModel usuario);
  Future<int> logOut();
  Future<UsuarioModel?> getUsuario();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<UsuarioModel?> logIn(UsuarioModel usuario) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.query('Usuario',
        where: 'UserName = ? AND Password = ? AND Device_Id = ?',
        whereArgs: [usuario.userName, usuario.password, usuario.deviceId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = UsuarioModel.fromJson(resultMap);
    return result;
  }

  @override
  Future<int> logOut() async {
    final db = await ConnectionSQLiteService.db;
    final prefs = SharedPreferencesService();
    final clearStorage = await prefs.clearStorage();

    final res = await db.delete('Usuario');

    if (clearStorage && res == 1) {
      return res;
    } else {
      return 0;
    }
  }

  static Future<int> saveUsuario(UsuarioModel usuario) async {
    final db = await ConnectionSQLiteService.db;

    await db.delete('Usuario');

    final res = await db.insert('Usuario', usuario.toJson());
    return res;
  }

  @override
  Future<UsuarioModel?> getUsuario() async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.query('Usuario');

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = UsuarioModel.fromJson(resultMap);
    return result;
  }
}
