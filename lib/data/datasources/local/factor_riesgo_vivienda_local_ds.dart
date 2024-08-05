import '../../../core/constants.dart';
import '../../models/factor_riesgo_vivienda.dart';

abstract class FactorRiesgoViviendaLocalDataSource {
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgo();
  Future<int> saveFactorRiesgoVivienda(
      FactorRiesgoViviendaModel factorRiesgoVivienda);

  Future<int> saveFactoresRiesgoVivienda(
      int datoViviendaId, List<LstFactorRiesgo> lstFactorRiesgo);

  Future<List<LstFactorRiesgo>> getFactoresRiesgoVivienda(int? datoViviendaId);
}

class FactorRiesgoViviendaLocalDataSourceImpl
    implements FactorRiesgoViviendaLocalDataSource {
  @override
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgo() async {
    final res =
        await supabase.from('FactoresRiesgoVivienda_DatosVivienda').select();
    final result = List<FactorRiesgoViviendaModel>.from(
        res.map((m) => FactorRiesgoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveFactorRiesgoVivienda(
      FactorRiesgoViviendaModel factorRiesgoVivienda) async {
    final res = await supabase
        .from('FactoresRiesgoVivienda_DatosVivienda')
        .insert(factorRiesgoVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveFactoresRiesgoVivienda(
      int datoViviendaId, List<LstFactorRiesgo> lstFactorRiesgo) async {
    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaFactoresRiesgo',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final factoresRiesgoVivienda = lstFactorRiesgo
        .map((item) => ViviendaFactoresRiesgo(
            factorRiesgoViviendaId: item.factorRiesgoViviendaId,
            datoViviendaId: datoViviendaId,
            otroFactorRiesgo: item.otroFactorRiesgo))
        .toList();

    for (final factorRiesgoVivienda in factoresRiesgoVivienda) {
      batch.insert(
          'Asp2_DatosViviendaFactoresRiesgo', factorRiesgoVivienda.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstFactorRiesgo>> getFactoresRiesgoVivienda(
      int? datoViviendaId) async {
    final res = await supabase
        .from('Asp2_DatosViviendaFactoresRiesgo')
        .select()
        .eq('DatoVivienda_id', datoViviendaId);
    final result =
        List<LstFactorRiesgo>.from(res.map((m) => LstFactorRiesgo.fromJson(m)))
            .toList();

    return result;
  }
}
