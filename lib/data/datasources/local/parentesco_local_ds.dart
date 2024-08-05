import '../../models/parentesco.dart';

abstract class ParentescoLocalDataSource {
  Future<List<ParentescoModel>> getParentescos();
  Future<int> saveParentesco(ParentescoModel parentesco);
}

class ParentescoLocalDataSourceImpl implements ParentescoLocalDataSource {
  @override
  Future<List<ParentescoModel>> getParentescos() async {
    final res = await supabase.from(.select()'Parentesco_GrupoFamiliar');
    final result =
        List<ParentescoModel>.from(res.map((m) => ParentescoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveParentesco(ParentescoModel parentesco) async {
    final res = await supabase
        .from(
        .insert('Parentesco_GrupoFamiliar', parentesco.toJson());

    return res;
  }
}
