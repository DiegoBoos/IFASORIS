import '../../../domain/entities/medio_comunicacion_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/medio_comunicacion_model.dart';

abstract class MedioComunicacionLocalDataSource {
  Future<List<MedioComunicacionModel>> getMediosComunicacion();
  Future<int> saveMedioComunicacion(MedioComunicacionEntity medioComunicacion);
}

class MedioComunicacionLocalDataSourceImpl
    implements MedioComunicacionLocalDataSource {
  @override
  Future<List<MedioComunicacionModel>> getMediosComunicacion() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('MediosComunicacion');
    final mediosComunicacionDB = List<MedioComunicacionModel>.from(
        res.map((m) => MedioComunicacionModel.fromJson(m))).toList();

    return mediosComunicacionDB;
  }

  @override
  Future<int> saveMedioComunicacion(
      MedioComunicacionEntity medioComunicacion) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('MediosComunicacion', medioComunicacion.toJson());

    return res;
  }
}
