import '../../../core/constants.dart';
import '../../models/pueblo_indigena.dart';

abstract class PuebloIndigenaLocalDataSource {
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas();
  Future<int> savePuebloIndigena(PuebloIndigenaModel puebloIndigena);
}

class PuebloIndigenaLocalDataSourceImpl
    implements PuebloIndigenaLocalDataSource {
  @override
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas() async {
    final res = await supabase.from('PueblosIndigenas_GrupoFamiliar').select();
    final result = List<PuebloIndigenaModel>.from(
        res.map((m) => PuebloIndigenaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePuebloIndigena(PuebloIndigenaModel puebloIndigena) async {
    final res = await supabase
        .from('PueblosIndigenas_GrupoFamiliar')
        .insert(puebloIndigena.toJson());

    return res;
  }
}
