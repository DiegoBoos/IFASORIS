import '../../../domain/entities/usuario_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/usuario_model.dart';

abstract class AuthLocalDataSource {
  Future<UsuarioModel?> logIn(UsuarioEntity usuario);
  Future<int> logOut();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<UsuarioModel?> logIn(UsuarioEntity usuario) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.query('Usuario',
        where: 'UserName = ? AND Password = ?',
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

  static Future<int> saveUsuario(UsuarioEntity usuarioEntity) async {
    final db = await ConnectionSQLiteService.db;

    await db.delete('Usuario');

    final res = await db.insert('Usuario', usuarioEntity.toJson());
    return res;
  }
}
