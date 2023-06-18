import '../../../domain/entities/nombre_lengua_maneja_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/nombre_lengua_maneja_model.dart';

abstract class NombreLenguaManejaLocalDataSource {
  Future<List<NombreLenguaManejaModel>> getNombresLenguasManeja();
  Future<int> saveNombreLenguaManeja(
      NombreLenguaManejaEntity nombreLenguaManeja);
}

class NombreLenguaManejaLocalDataSourceImpl
    implements NombreLenguaManejaLocalDataSource {
  @override
  Future<List<NombreLenguaManejaModel>> getNombresLenguasManeja() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('NombresLenguasManeja_CentroAtencion');
    final result = List<NombreLenguaManejaModel>.from(
        res.map((m) => NombreLenguaManejaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNombreLenguaManeja(
      NombreLenguaManejaEntity nombreLenguaManeja) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'NombresLenguasManeja_CentroAtencion', nombreLenguaManeja.toJson());

    return res;
  }
}
