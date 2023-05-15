import '../../../domain/entities/iluminacion_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/iluminacion_vivienda_model.dart';

abstract class IluminacionViviendaLocalDataSource {
  Future<List<IluminacionViviendaModel>> getIluminacionesVivienda();
  Future<int> saveIluminacionVivienda(
      IluminacionViviendaEntity iluminacionVivienda);
}

class IluminacionViviendaLocalDataSourceImpl
    implements IluminacionViviendaLocalDataSource {
  @override
  Future<List<IluminacionViviendaModel>> getIluminacionesVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('IluminacionVivienda_DatosVivienda');
    final result = List<IluminacionViviendaModel>.from(
        res.map((m) => IluminacionViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveIluminacionVivienda(
      IluminacionViviendaEntity iluminacionVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'IluminacionVivienda_DatosVivienda', iluminacionVivienda.toJson());

    return res;
  }
}
