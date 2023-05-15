import '../../../domain/entities/presencia_animal_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/presencia_animal_vivienda_model.dart';

abstract class PresenciaAnimalViviendaByDptoLocalDataSource {
  Future<List<PresenciaAnimalViviendaModel>>
      getPresenciaAnimalesViviendaByDpto();
  Future<int> savePresenciaAnimalViviendaByDpto(
      PresenciaAnimalViviendaEntity presenciaAnimalViviendaByDpto);
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
}
