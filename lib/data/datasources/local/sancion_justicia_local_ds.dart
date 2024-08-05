import '../../models/sancion_justicia.dart';

abstract class SancionJusticiaLocalDataSource {
  Future<List<SancionJusticiaModel>> getSancionesJusticia();
  Future<int> saveSancionJusticia(SancionJusticiaModel sancionJusticia);
}

class SancionJusticiaLocalDataSourceImpl
    implements SancionJusticiaLocalDataSource {
  @override
  Future<List<SancionJusticiaModel>> getSancionesJusticia() async {
    final res =
        await supabase.from(.select()'SancionesJusticia_DimSocioCulturalPueblosIndigenas');
    final result = List<SancionJusticiaModel>.from(
        res.map((m) => SancionJusticiaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveSancionJusticia(SancionJusticiaModel sancionJusticia) async {
    final res = await supabase.from(.insert(
        'SancionesJusticia_DimSocioCulturalPueblosIndigenas',
        sancionJusticia.toJson());

    return res;
  }
}
