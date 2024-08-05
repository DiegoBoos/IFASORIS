import '../../../core/constants.dart';
import '../../models/genero.dart';

abstract class GeneroLocalDataSource {
  Future<List<GeneroModel>> getGeneros();
  Future<int> saveGenero(GeneroModel genero);
}

class GeneroLocalDataSourceImpl implements GeneroLocalDataSource {
  @override
  Future<List<GeneroModel>> getGeneros() async {
    final res = await supabase.from('Genero_GrupoFamiliar').select();
    final result =
        List<GeneroModel>.from(res.map((m) => GeneroModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveGenero(GeneroModel genero) async {
    final res =
        await supabase.from('Genero_GrupoFamiliar').insert(genero.toJson());

    return res;
  }
}
