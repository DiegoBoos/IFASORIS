import '../../../services/connection_sqlite_service.dart';
import '../../models/condicion_nutricional.dart';

abstract class CondicionNutricionalLocalDataSource {
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales();
  Future<int> saveCondicionNutricional(
      CondicionNutricionalModel condicionNutricional);
}

class CondicionNutricionalLocalDataSourceImpl
    implements CondicionNutricionalLocalDataSource {
  @override
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales() async {
    final db = await ConnectionSQLiteService.db;
    final res =
        await db.query('CondicionesNutricionales_CuidadoSaludCondRiesgo');
    final result = List<CondicionNutricionalModel>.from(
        res.map((m) => CondicionNutricionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCondicionNutricional(
      CondicionNutricionalModel condicionNutricional) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'CondicionesNutricionales_CuidadoSaludCondRiesgo',
        condicionNutricional.toJson());

    return res;
  }
}
