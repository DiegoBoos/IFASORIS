import '../../../core/constants.dart';
import '../../models/religion_profesa.dart';

abstract class ReligionProfesaLocalDataSource {
  Future<List<ReligionProfesaModel>> getReligionesProfesa();
  Future<int> saveReligionProfesa(ReligionProfesaModel religionProfesa);
}

class ReligionProfesaLocalDataSourceImpl
    implements ReligionProfesaLocalDataSource {
  @override
  Future<List<ReligionProfesaModel>> getReligionesProfesa() async {
    final res = await supabase
        .from('ReligionesProfesa_DimSocioCulturalPueblosIndigenas')
        .select();
    final result = List<ReligionProfesaModel>.from(
        res.map((m) => ReligionProfesaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveReligionProfesa(ReligionProfesaModel religionProfesa) async {
    final res = await supabase
        .from('ReligionesProfesa_DimSocioCulturalPueblosIndigenas')
        .insert(religionProfesa.toJson());

    return res;
  }
}
