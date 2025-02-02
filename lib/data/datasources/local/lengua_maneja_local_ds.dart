import '../../../services/connection_sqlite_service.dart';
import '../../models/lengua_maneja.dart';

abstract class LenguaManejaLocalDataSource {
  Future<List<LenguaManejaModel>> getLenguasManeja();
  Future<int> saveLenguaManeja(LenguaManejaModel lenguaManeja);
}

class LenguaManejaLocalDataSourceImpl implements LenguaManejaLocalDataSource {
  @override
  Future<List<LenguaManejaModel>> getLenguasManeja() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('LenguaManeja_GrupoFamiliar');
    final result = List<LenguaManejaModel>.from(
        res.map((m) => LenguaManejaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLenguaManeja(LenguaManejaModel lenguaManeja) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('LenguaManeja_GrupoFamiliar', lenguaManeja.toJson());

    return res;
  }
}
