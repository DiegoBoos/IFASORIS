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
    final res = await db.query('OpcionesSi_No');
    final result =
        List<OpcionSiNoModel>.from(res.map((m) => OpcionSiNoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveOpcionSiNo(OpcionSiNoEntity opcionSiNo) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('OpcionesSi_No', opcionSiNo.toJson());

    return res;
  }
}
