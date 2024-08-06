import '../../../core/constants.dart';
import '../../models/tiempo_tarda_ca.dart';

abstract class TiempoTardaCALocalDataSource {
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA();
  Future<int> saveTiempoTardaCA(TiempoTardaCAModel tiempoTardaCA);
}

class TiempoTardaCALocalDataSourceImpl implements TiempoTardaCALocalDataSource {
  @override
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA() async {
    final res = await supabase.from('TiemposTarda_CentroAtencion').select();
    final result = List<TiempoTardaCAModel>.from(
        res.map((m) => TiempoTardaCAModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTiempoTardaCA(TiempoTardaCAModel tiempoTardaCA) async {
    final res = await supabase
        .from('TiemposTarda_CentroAtencion')
        .insert(tiempoTardaCA.toJson());

    return res;
  }
}
