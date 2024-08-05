import '../../../core/constants.dart';
import '../../models/cuarto_vivienda.dart';

abstract class CuartoViviendaLocalDataSource {
  Future<List<CuartoViviendaModel>> getCuartosVivienda();
  Future<int> saveCuartoVivienda(CuartoViviendaModel cuartoVivienda);
}

class CuartoViviendaLocalDataSourceImpl
    implements CuartoViviendaLocalDataSource {
  @override
  Future<List<CuartoViviendaModel>> getCuartosVivienda() async {
    final res = await supabase.from('CuartosVivienda_DatosVivienda').select();
    final result = List<CuartoViviendaModel>.from(
        res.map((m) => CuartoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCuartoVivienda(CuartoViviendaModel cuartoVivienda) async {
    final res = await supabase
        .from('CuartosVivienda_DatosVivienda')
        .insert(cuartoVivienda.toJson());

    return res;
  }
}
