import '../../../services/connection_sqlite_service.dart';
import '../../models/religion_profesa.dart';

abstract class ReligionProfesaLocalDataSource {
  Future<List<ReligionProfesaModel>> getReligionesProfesa();
  Future<int> saveReligionProfesa(ReligionProfesaModel religionProfesa);
}

class ReligionProfesaLocalDataSourceImpl
    implements ReligionProfesaLocalDataSource {
  @override
  Future<List<ReligionProfesaModel>> getReligionesProfesa() async {
    final db = await ConnectionSQLiteService.db;
    final res =
        await db.query('ReligionesProfesa_DimSocioCulturalPueblosIndigenas');
    final result = List<ReligionProfesaModel>.from(
        res.map((m) => ReligionProfesaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveReligionProfesa(ReligionProfesaModel religionProfesa) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'ReligionesProfesa_DimSocioCulturalPueblosIndigenas',
        religionProfesa.toJson());

    return res;
  }
}
