import '../../../core/constants.dart';
import '../../models/ventilacion_vivienda.dart';

abstract class VentilacionViviendaLocalDataSource {
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda();
  Future<int> saveVentilacionVivienda(
      VentilacionViviendaModel ventilacionVivienda);
}

class VentilacionViviendaLocalDataSourceImpl
    implements VentilacionViviendaLocalDataSource {
  @override
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda() async {
    final res =
        await supabase.from('VentilacionVivienda_DatosVivienda').select();
    final result = List<VentilacionViviendaModel>.from(
        res.map((m) => VentilacionViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveVentilacionVivienda(
      VentilacionViviendaModel ventilacionVivienda) async {
    final res = await supabase
        .from('VentilacionVivienda_DatosVivienda')
        .insert(ventilacionVivienda.toJson());

    return res;
  }
}
