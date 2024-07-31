import '../../../services/connection_sqlite_service.dart';
import '../../models/sancion_justicia.dart';

abstract class SancionJusticiaLocalDataSource {
  Future<List<SancionJusticiaModel>> getSancionesJusticia();
  Future<int> saveSancionJusticia(SancionJusticiaModel sancionJusticia);
}

class SancionJusticiaLocalDataSourceImpl
    implements SancionJusticiaLocalDataSource {
  @override
  Future<List<SancionJusticiaModel>> getSancionesJusticia() async {
    final db = await ConnectionSQLiteService.db;
    final res =
        await db.query('SancionesJusticia_DimSocioCulturalPueblosIndigenas');
    final result = List<SancionJusticiaModel>.from(
        res.map((m) => SancionJusticiaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveSancionJusticia(SancionJusticiaModel sancionJusticia) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'SancionesJusticia_DimSocioCulturalPueblosIndigenas',
        sancionJusticia.toJson());

    return res;
  }
}
