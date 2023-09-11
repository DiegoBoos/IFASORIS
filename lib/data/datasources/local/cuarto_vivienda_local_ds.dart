import '../../../domain/entities/cuarto_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/cuarto_vivienda_model.dart';

abstract class NroCuartoViviendaLocalDataSource {
  Future<List<NroCuartoViviendaModel>> getNroCuartosVivienda();
  Future<int> saveNroCuartoVivienda(NroCuartoViviendaEntity nroCuartoVivienda);
}

class NroCuartoViviendaLocalDataSourceImpl
    implements NroCuartoViviendaLocalDataSource {
  @override
  Future<List<NroCuartoViviendaModel>> getNroCuartosVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('NroCuartosVivienda_DatosVivienda');
    final result = List<NroCuartoViviendaModel>.from(
        res.map((m) => NroCuartoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNroCuartoVivienda(
      NroCuartoViviendaEntity nroCuartoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'NroCuartosVivienda_DatosVivienda', nroCuartoVivienda.toJson());

    return res;
  }
}
