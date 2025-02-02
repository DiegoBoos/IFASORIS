import '../../../services/connection_sqlite_service.dart';
import '../../models/cigarrillo_dia.dart';

abstract class CigarrilloDiaLocalDataSource {
  Future<List<CigarrilloDiaModel>> getCigarrillosDia();
  Future<int> saveCigarrilloDia(CigarrilloDiaModel cigarrilloDia);
}

class CigarrilloDiaLocalDataSourceImpl implements CigarrilloDiaLocalDataSource {
  @override
  Future<List<CigarrilloDiaModel>> getCigarrillosDia() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('NumeroCigarrilosDia_EstilosVidaSaludable');
    final result = List<CigarrilloDiaModel>.from(
        res.map((m) => CigarrilloDiaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCigarrilloDia(CigarrilloDiaModel cigarrilloDia) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'NumeroCigarrilosDia_EstilosVidaSaludable', cigarrilloDia.toJson());

    return res;
  }
}
