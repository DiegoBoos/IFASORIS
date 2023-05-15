import '../../../domain/entities/tratamiento_agua_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tratamiento_agua_vivienda_model.dart';

abstract class TratamientoAguaViviendaByDptoLocalDataSource {
  Future<List<TratamientoAguaViviendaModel>>
      getTratamientosAguaViviendaByDpto();
  Future<int> saveTratamientoAguaViviendaByDpto(
      TratamientoAguaViviendaEntity tratamientoAguaViviendaByDpto);
}

class TratamientoAguaViviendaByDptoLocalDataSourceImpl
    implements TratamientoAguaViviendaByDptoLocalDataSource {
  @override
  Future<List<TratamientoAguaViviendaModel>>
      getTratamientosAguaViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TratamientoAguaVivienda_DatosVivienda');
    final result = List<TratamientoAguaViviendaModel>.from(
        res.map((m) => TratamientoAguaViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTratamientoAguaViviendaByDpto(
      TratamientoAguaViviendaEntity tratamientoAguaViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TratamientoAguaVivienda_DatosVivienda',
        tratamientoAguaViviendaByDpto.toJson());

    return res;
  }
}
