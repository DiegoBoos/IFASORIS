import '../../../domain/entities/opcion_si_no_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/opcion_si_no_model.dart';

abstract class OpcionSiNoLocalDataSource {
  Future<List<OpcionSiNoModel>> getOpcionesSiNo();
  Future<int> saveOpcionSiNo(OpcionSiNoEntity opcionSiNo);
}

class OpcionSiNoLocalDataSourceImpl implements OpcionSiNoLocalDataSource {
  @override
  Future<List<OpcionSiNoModel>> getOpcionesSiNo() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('OpcionSiNo');
    final opcionesSiNoDB =
        List<OpcionSiNoModel>.from(res.map((m) => OpcionSiNoModel.fromJson(m)))
            .toList();

    return opcionesSiNoDB;
  }

  @override
  Future<int> saveOpcionSiNo(OpcionSiNoEntity opcionSiNo) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('OpcionSiNo', opcionSiNo.toJson());

    return res;
  }
}
