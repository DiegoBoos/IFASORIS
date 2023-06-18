import '../../../domain/entities/lengua_maneja_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/lengua_maneja_model.dart';

abstract class LenguaManejaLocalDataSource {
  Future<List<LenguaManejaModel>> getLenguasManeja();
  Future<int> saveLenguaManeja(LenguaManejaEntity lenguaManeja);
}

class LenguaManejaLocalDataSourceImpl implements LenguaManejaLocalDataSource {
  @override
  Future<List<LenguaManejaModel>> getLenguasManeja() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('LenguasManeja_CentroAtencion');
    final result = List<LenguaManejaModel>.from(
        res.map((m) => LenguaManejaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLenguaManeja(LenguaManejaEntity lenguaManeja) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('LenguasManeja_CentroAtencion', lenguaManeja.toJson());

    return res;
  }
}
