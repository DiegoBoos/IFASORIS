import '../../../domain/entities/condicion_nutricional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/condicion_nutricional_model.dart';

abstract class CondicionNutricionalLocalDataSource {
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales();
  Future<int> saveCondicionNutricional(
      CondicionNutricionalEntity condicionNutricional);
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
      CondicionNutricionalEntity condicionNutricional) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'CondicionesNutricionales_CuidadoSaludCondRiesgo',
        condicionNutricional.toJson());

    return res;
  }
}
