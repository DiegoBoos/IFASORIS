import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/presencia_animal_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/presencia_animal_vivienda_model.dart';

abstract class PresenciaAnimalViviendaByDptoLocalDataSource {
  Future<List<PresenciaAnimalViviendaModel>>
      getPresenciaAnimalesViviendaByDpto();
  Future<int> savePresenciaAnimalViviendaByDpto(
      PresenciaAnimalViviendaEntity presenciaAnimalViviendaByDpto);

  Future<List<LstPresenciaAnimal>> getPresenciasAnimalesVivienda(
      int? datoViviendaId);

  Future<int> savePresenciaAnimalesVivienda(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimales);
}

class PresenciaAnimalViviendaByDptoLocalDataSourceImpl
    implements PresenciaAnimalViviendaByDptoLocalDataSource {
  @override
  Future<List<PresenciaAnimalViviendaModel>>
      getPresenciaAnimalesViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('PresenciaAnimalesVivienda_DatosVivienda');
    final result = List<PresenciaAnimalViviendaModel>.from(
        res.map((m) => PresenciaAnimalViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePresenciaAnimalViviendaByDpto(
      PresenciaAnimalViviendaEntity presenciaAnimalViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('PresenciaAnimalesVivienda_DatosVivienda',
        presenciaAnimalViviendaByDpto.toJson());

    return res;
  }

  @override
  Future<int> savePresenciaAnimalesVivienda(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimales) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaPresenciaAnimales');

    final viviendaPresenciaAnimales = lstPresenciaAnimales
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
        where: 'DatoVivienda_id', whereArgs: [datoViviendaId]);
    final result = List<LstPresenciaAnimal>.from(
        res.map((m) => LstPresenciaAnimal.fromJson(m))).toList();

    return result;
  }
}
