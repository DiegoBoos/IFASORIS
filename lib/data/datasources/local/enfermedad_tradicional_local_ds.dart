import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/enfermedad_tradicional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/enfermedad_tradicional_model.dart';

abstract class EnfermedadTradicionalLocalDataSource {
  Future<List<EnfermedadTradicionalModel>> getEnfermedadesTradicionales();
  Future<int> saveEnfermedadTradicional(
      EnfermedadTradicionalEntity enfermedadTradicional);

  Future<List<LstEnfermedadTradicional>>
      getEnfermedadesTradicionalesAtencionSalud(int? atencionSaludId);

  Future<int> saveEnfermedadesTradicionalesAtencionSalud(int atencionSaludId,
      List<LstEnfermedadTradicional> lstEnfermedadTradicional);
}

class EnfermedadTradicionalLocalDataSourceImpl
    implements EnfermedadTradicionalLocalDataSource {
  @override
  Future<List<EnfermedadTradicionalModel>>
      getEnfermedadesTradicionales() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EnfermedadesTradicionales_AtencionSalud');
    final result = List<EnfermedadTradicionalModel>.from(
        res.map((m) => EnfermedadTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEnfermedadTradicional(
      EnfermedadTradicionalEntity enfermedadTradicional) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EnfermedadesTradicionales_AtencionSalud',
        enfermedadTradicional.toJson());

    return res;
  }

  @override
  Future<List<LstEnfermedadTradicional>>
      getEnfermedadesTradicionalesAtencionSalud(int? atencionSaludId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp7_EnfermedadesTradicionales_AtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);
    final result = List<LstEnfermedadTradicional>.from(
        res.map((m) => LstEnfermedadTradicional.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEnfermedadesTradicionalesAtencionSalud(int atencionSaludId,
      List<LstEnfermedadTradicional> lstEnfermedadTradicional) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp7_EnfermedadesTradicionales_AtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);

    final enfermedadesTradicionalesAtencionSalud = lstEnfermedadTradicional
        .map((item) => EnfermedadTradicionalAtencionSalud(
            enfermedadTradicionalId: item.enfermedadTradicionalId,
            atencionSaludId: atencionSaludId))
        .toList();

    for (final enfermedadTradicionalAtencionSalud
        in enfermedadesTradicionalesAtencionSalud) {
      batch.insert('Asp7_EnfermedadesTradicionales_AtencionSalud',
          enfermedadTradicionalAtencionSalud.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
