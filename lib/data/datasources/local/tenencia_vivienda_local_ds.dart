import '../../../core/constants.dart';
import '../../models/tenencia_vivienda.dart';

abstract class TenenciaViviendaLocalDataSource {
  Future<List<TenenciaViviendaModel>> getTenenciasVivienda();
  Future<int> saveTenenciaVivienda(TenenciaViviendaModel tenenciaVivienda);
}

class TenenciaViviendaLocalDataSourceImpl
    implements TenenciaViviendaLocalDataSource {
  @override
  Future<List<TenenciaViviendaModel>> getTenenciasVivienda() async {
    final res = await supabase.from('TenenciasVivienda_DatosVivienda').select();
    final result = List<TenenciaViviendaModel>.from(
        res.map((m) => TenenciaViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTenenciaVivienda(
      TenenciaViviendaModel tenenciaVivienda) async {
    final res = await supabase
        .from('TenenciasVivienda_DatosVivienda')
        .insert(tenenciaVivienda.toJson());

    return res;
  }
}
