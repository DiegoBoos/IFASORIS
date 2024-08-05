import '../../../core/constants.dart';
import '../../models/costo_desplazamiento.dart';

abstract class CostoDesplazamientoLocalDataSource {
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento();
  Future<int> saveCostoDesplazamiento(
      CostoDesplazamientoModel costoDesplazamiento);
}

class CostoDesplazamientoLocalDataSourceImpl
    implements CostoDesplazamientoLocalDataSource {
  @override
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento() async {
    final res =
        await supabase.from('CostosDesplazamiento_CentroAtencion').select();
    final result = List<CostoDesplazamientoModel>.from(
        res.map((m) => CostoDesplazamientoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCostoDesplazamiento(
      CostoDesplazamientoModel costoDesplazamiento) async {
    final res = await supabase
        .from('CostosDesplazamiento_CentroAtencion')
        .insert(costoDesplazamiento.toJson());

    return res;
  }
}
