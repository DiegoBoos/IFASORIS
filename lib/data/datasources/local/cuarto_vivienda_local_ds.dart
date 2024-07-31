import '../../../services/connection_sqlite_service.dart';
import '../../models/cuarto_vivienda.dart';

abstract class CuartoViviendaLocalDataSource {
  Future<List<CuartoViviendaModel>> getCuartosVivienda();
  Future<int> saveCuartoVivienda(CuartoViviendaModel cuartoVivienda);
}

class CuartoViviendaLocalDataSourceImpl
    implements CuartoViviendaLocalDataSource {
  @override
  Future<List<CuartoViviendaModel>> getCuartosVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('CuartosVivienda_DatosVivienda');
    final result = List<CuartoViviendaModel>.from(
        res.map((m) => CuartoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCuartoVivienda(CuartoViviendaModel cuartoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'CuartosVivienda_DatosVivienda', cuartoVivienda.toJson());

    return res;
  }
}
