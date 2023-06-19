import '../../../domain/entities/nombre_lengua_materna_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/nombre_lengua_materna_model.dart';

abstract class NombreLenguaMaternaLocalDataSource {
  Future<List<NombreLenguaMaternaModel>> getNombresLenguasMaterna();
  Future<int> saveNombreLenguaMaterna(
      NombreLenguaMaternaEntity nombreLenguaMaterna);
}

class NombreLenguaMaternaLocalDataSourceImpl
    implements NombreLenguaMaternaLocalDataSource {
  @override
  Future<List<NombreLenguaMaternaModel>> getNombresLenguasMaterna() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('NombreLenguaMaterna_GrupoFamiliar');
    final result = List<NombreLenguaMaternaModel>.from(
        res.map((m) => NombreLenguaMaternaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNombreLenguaMaterna(
      NombreLenguaMaternaEntity nombreLenguaMaterna) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'NombreLenguaMaterna_GrupoFamiliar', nombreLenguaMaterna.toJson());

    return res;
  }
}
