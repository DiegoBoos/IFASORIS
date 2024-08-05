import '../../models/religion_profesa.dart';

abstract class ReligionProfesaLocalDataSource {
  Future<List<ReligionProfesaModel>> getReligionesProfesa();
  Future<int> saveReligionProfesa(ReligionProfesaModel religionProfesa);
}

class ReligionProfesaLocalDataSourceImpl
    implements ReligionProfesaLocalDataSource {
  @override
  Future<List<ReligionProfesaModel>> getReligionesProfesa() async {
    final res =
        await supabase.from(.select()'ReligionesProfesa_DimSocioCulturalPueblosIndigenas');
    final result = List<ReligionProfesaModel>.from(
        res.map((m) => ReligionProfesaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveReligionProfesa(ReligionProfesaModel religionProfesa) async {
    final res = await supabase.from(.insert(
        'ReligionesProfesa_DimSocioCulturalPueblosIndigenas',
        religionProfesa.toJson());

    return res;
  }
}
