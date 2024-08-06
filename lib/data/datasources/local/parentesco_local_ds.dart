import '../../../core/constants.dart';
import '../../models/parentesco.dart';

abstract class ParentescoLocalDataSource {
  Future<List<ParentescoModel>> getParentescos();
  Future<int> saveParentesco(ParentescoModel parentesco);
}

class ParentescoLocalDataSourceImpl implements ParentescoLocalDataSource {
  @override
  Future<List<ParentescoModel>> getParentescos() async {
    final res = await supabase.from('Parentesco_GrupoFamiliar').select();
    final result =
        List<ParentescoModel>.from(res.map((m) => ParentescoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveParentesco(ParentescoModel parentesco) async {
    final res = await supabase
        .from('Parentesco_GrupoFamiliar')
        .insert(parentesco.toJson());

    return res;
  }
}
