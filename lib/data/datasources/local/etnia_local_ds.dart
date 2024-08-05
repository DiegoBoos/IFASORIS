import '../../../core/constants.dart';
import '../../models/etnia.dart';

abstract class EtniaLocalDataSource {
  Future<List<EtniaModel>> getEtnias();
  Future<int> saveEtnia(EtniaModel etnia);
}

class EtniaLocalDataSourceImpl implements EtniaLocalDataSource {
  @override
  Future<List<EtniaModel>> getEtnias() async {
    final res = await supabase.from('Etnia_GrupoFamiliar').select();
    final result =
        List<EtniaModel>.from(res.map((m) => EtniaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEtnia(EtniaModel etnia) async {
    final res =
        await supabase.from('Etnia_GrupoFamiliar').insert(etnia.toJson());

    return res;
  }
}
