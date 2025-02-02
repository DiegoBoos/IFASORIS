import '../../../services/connection_sqlite_service.dart';
import '../../models/enfermedad_acude.dart';

abstract class EnfermedadAcudeLocalDataSource {
  Future<List<EnfermedadAcudeModel>> getEnfermedadesAcude();
  Future<int> saveEnfermedadAcude(EnfermedadAcudeModel enfermedadAcude);
}

class EnfermedadAcudeLocalDataSourceImpl
    implements EnfermedadAcudeLocalDataSource {
  @override
  Future<List<EnfermedadAcudeModel>> getEnfermedadesAcude() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EnfermedadesAcude_AtencionSalud');
    final result = List<EnfermedadAcudeModel>.from(
        res.map((m) => EnfermedadAcudeModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEnfermedadAcude(EnfermedadAcudeModel enfermedadAcude) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'EnfermedadesAcude_AtencionSalud', enfermedadAcude.toJson());

    return res;
  }
}
