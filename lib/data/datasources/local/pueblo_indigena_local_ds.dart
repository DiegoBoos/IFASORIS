import '../../models/pueblo_indigena.dart';

abstract class PuebloIndigenaLocalDataSource {
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas();
  Future<int> savePuebloIndigena(PuebloIndigenaModel puebloIndigena);
}

class PuebloIndigenaLocalDataSourceImpl
    implements PuebloIndigenaLocalDataSource {
  @override
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas() async {
    final res = await supabase.from(.select()'PueblosIndigenas_GrupoFamiliar');
    final result = List<PuebloIndigenaModel>.from(
        res.map((m) => PuebloIndigenaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePuebloIndigena(PuebloIndigenaModel puebloIndigena) async {
    final res = await supabase
        .from(
        .insert('PueblosIndigenas_GrupoFamiliar', puebloIndigena.toJson());

    return res;
  }
}
