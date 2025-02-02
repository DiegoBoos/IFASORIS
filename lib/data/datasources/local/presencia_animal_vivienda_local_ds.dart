import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/presencia_animal_vivienda.dart';

abstract class PresenciaAnimalViviendaLocalDataSource {
  Future<List<PresenciaAnimalViviendaModel>> getPresenciaAnimales();
  Future<int> savePresenciaAnimalVivienda(
      PresenciaAnimalViviendaModel presenciaAnimalVivienda);

  Future<List<LstPresenciaAnimal>> getPresenciasAnimalesVivienda(
      int? datoViviendaId);

  Future<int> savePresenciaAnimalesVivienda(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimal);
}

class PresenciaAnimalViviendaLocalDataSourceImpl
    implements PresenciaAnimalViviendaLocalDataSource {
  @override
  Future<List<PresenciaAnimalViviendaModel>> getPresenciaAnimales() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('PresenciaAnimalesVivienda_DatosVivienda');
    final result = List<PresenciaAnimalViviendaModel>.from(
        res.map((m) => PresenciaAnimalViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePresenciaAnimalVivienda(
      PresenciaAnimalViviendaModel presenciaAnimalVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('PresenciaAnimalesVivienda_DatosVivienda',
        presenciaAnimalVivienda.toJson());

    return res;
  }

  @override
  Future<int> savePresenciaAnimalesVivienda(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimal) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaPresenciaAnimales',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaPresenciaAnimales = lstPresenciaAnimal
        .map((item) => ViviendaPresenciaAnimales(
            presenciaAnimalViviendaId: item.presenciaAnimalViviendaId,
            datoViviendaId: datoViviendaId,
            otroPresenciaAnimal: item.otroPresenciaAnimal))
        .toList();

    for (final viviendaServicioPublico in viviendaPresenciaAnimales) {
      batch.insert('Asp2_DatosViviendaPresenciaAnimales',
          viviendaServicioPublico.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstPresenciaAnimal>> getPresenciasAnimalesVivienda(
      int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaPresenciaAnimales',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result = List<LstPresenciaAnimal>.from(
        res.map((m) => LstPresenciaAnimal.fromJson(m))).toList();

    return result;
  }
}
