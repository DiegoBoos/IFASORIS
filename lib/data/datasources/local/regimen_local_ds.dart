import '../../../core/constants.dart';
import '../../models/regimen.dart';

abstract class RegimenLocalDataSource {
  Future<List<RegimenModel>> getRegimenes();
  Future<int> saveRegimen(RegimenModel regimen);
}

class RegimenLocalDataSourceImpl implements RegimenLocalDataSource {
  @override
  Future<List<RegimenModel>> getRegimenes() async {
    final res = await supabase.from('Regimenes_GrupoFamiliar').select();
    final result =
        List<RegimenModel>.from(res.map((m) => RegimenModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveRegimen(RegimenModel regimen) async {
    final res =
        await supabase.from('Regimenes_GrupoFamiliar').insert(regimen.toJson());

    return res;
  }
}
