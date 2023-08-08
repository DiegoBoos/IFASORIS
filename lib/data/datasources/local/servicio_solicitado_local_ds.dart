import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/servicio_solicitado_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/servicio_solicitado_model.dart';

abstract class ServicioSolicitadoLocalDataSource {
  Future<List<ServicioSolicitadoModel>> getServiciosSolicitados();
  Future<int> saveServicioSolicitado(
      ServicioSolicitadoEntity servicioSolicitado);

  Future<List<LstServicioSolicitado>> getLstServiciosSolicitados(
      int? cuidadoSaludCondRiesgoId);

  Future<int> saveServiciosSolicitados(int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados);
}

class ServicioSolicitadoLocalDataSourceImpl
    implements ServicioSolicitadoLocalDataSource {
  @override
  Future<List<ServicioSolicitadoModel>> getServiciosSolicitados() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('ServiciosSolicitados_CuidadoSaludCondRiesgo');
    final result = List<ServicioSolicitadoModel>.from(
        res.map((m) => ServicioSolicitadoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveServicioSolicitado(
      ServicioSolicitadoEntity servicioSolicitado) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('ServiciosSolicitados_CuidadoSaludCondRiesgo',
        servicioSolicitado.toJson());

    return res;
  }

  @override
  Future<List<LstServicioSolicitado>> getLstServiciosSolicitados(
      int? cuidadoSaludCondRiesgoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp5_CuidadoSaludCondRiesgoServiciosSolicita',
        where: 'CuidadoSaludCondRiesgo_id = ?',
        whereArgs: [cuidadoSaludCondRiesgoId]);
    final result = List<LstServicioSolicitado>.from(
        res.map((m) => LstServicioSolicitado.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveServiciosSolicitados(int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp5_CuidadoSaludCondRiesgoServiciosSolicita',
        where: 'CuidadoSaludCondRiesgo_id = ?',
        whereArgs: [cuidadoSaludCondRiesgoId]);

    final cuidadoSaludCondRiesgoServiciosSolicitados = lstServiciosSolicitados
        .map((item) => CuidadoSaludCondRiesgoServiciosSolicitados(
            servicioSolicitadoId: item.servicioSolicitadoId,
            cuidadoSaludCondRiesgoId: cuidadoSaludCondRiesgoId))
        .toList();

    for (final cuidadoSaludCondRiesgoServicioSolicitado
        in cuidadoSaludCondRiesgoServiciosSolicitados) {
      batch.insert('Asp5_CuidadoSaludCondRiesgoServiciosSolicita',
          cuidadoSaludCondRiesgoServicioSolicitado.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
