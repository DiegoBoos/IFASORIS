import '../../../domain/entities/usuario_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/usuario_model.dart';

abstract class AuthLocalDataSource {
  Future<UsuarioModel?> logIn(UsuarioEntity usuario);
  Future<UsuarioModel?> checkToken();
  Future<int> logOut();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<UsuarioModel?> logIn(UsuarioEntity usuario) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.query('Usuario',
        where: 'userName = ? AND password = ?',
        whereArgs: [usuario.userName, usuario.password]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = UsuarioModel.fromJson(resultMap);
    return result;
  }

  @override
  Future<int> logOut() async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.delete('Usuario');
    return res;
  }

  @override
  Future<UsuarioModel?> checkToken() async {
    final db = await ConnectionSQLiteService.db;
    final res =
        await db.rawQuery('SELECT * from Usuario WHERE token IS NOT NULL');
    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = UsuarioModel.fromJson(resultMap);
    return result;
  }
}
