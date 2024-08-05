import '../../../core/constants.dart';
import '../../models/afiliado.dart';
import '../../models/ficha.dart';

abstract class AfiliadoLocalDataSource {
  Future<List<AfiliadoModel>> getAfiliados(String query);
  Future<FichaModel?> afiliadoTieneFicha(int afiliadoId);
  Future<String> afiliadoTieneFichaReportada(int afiliadoId);
}

class AfiliadoLocalDataSourceImpl implements AfiliadoLocalDataSource {
  @override
  Future<List<AfiliadoModel>> getAfiliados(String query) async {
    final res = await supabase
        .from('Afiliado')
        .select('documento')
        .eq('documento', query);
    final result =
        List<AfiliadoModel>.from(res.map((m) => AfiliadoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<FichaModel?> afiliadoTieneFicha(int afiliadoId) async {
    final res = await supabase.from('Familia').select('''
      SELECT Ficha.* , Familia.*   
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Familia.FK_Afiliado_id = $afiliadoId
      UNION ALL

      SELECT Ficha.*, Familia.* FROM Familia 
      JOIN Asp3_GrupoFamiliar ON Familia.Familia_id = Asp3_GrupoFamiliar.Familia_id
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Asp3_GrupoFamiliar.Afiliado_id  = $afiliadoId
      ';

    if (res.isEmpty) return null;

    final familia = FamiliaModel.fromJson(res);
    res['familia'] = familia.toJson();
    final result = FichaModel.fromJson(res);

    return result;
  }

  @override
  Future<String> afiliadoTieneFichaReportada(int afiliadoId) async {
    final res = await db.rawQuery('''
      SELECT Ficha.NumFicha FROM Familia 
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Familia.FK_Afiliado_id = $afiliadoId AND Ficha.NumFicha <> ''
      UNION ALL

      SELECT Ficha.NumFicha FROM Familia 
      JOIN Asp3_GrupoFamiliar ON Familia.Familia_id = Asp3_GrupoFamiliar.GrupoFamiliar_id
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Asp3_GrupoFamiliar.Afiliado_id  = $afiliadoId AND Ficha.NumFicha <> ''
           ';
    if (res.isEmpty) return '';

    final numFicha = res[0].entries.first.value as String;
    return numFicha;
  }
}
