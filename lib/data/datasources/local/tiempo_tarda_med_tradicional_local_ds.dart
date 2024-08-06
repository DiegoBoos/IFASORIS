import '../../../core/constants.dart';
import '../../models/tiempo_tarda_med_tradicional.dart';

abstract class TiempoTardaMedTradicionalLocalDataSource {
  Future<List<TiempoTardaMedTradicionalModel>> getTiemposTardaMedTradicional();
  Future<int> saveTiempoTardaMedTradicional(
      TiempoTardaMedTradicionalModel tiempoTardaMedTradicional);
}

class TiempoTardaMedTradicionalLocalDataSourceImpl
    implements TiempoTardaMedTradicionalLocalDataSource {
  @override
  Future<List<TiempoTardaMedTradicionalModel>>
      getTiemposTardaMedTradicional() async {
    final res =
        await supabase.from('TiemposTarda_AccesoMedTradicional').select();
    final result = List<TiempoTardaMedTradicionalModel>.from(
        res.map((m) => TiempoTardaMedTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTiempoTardaMedTradicional(
      TiempoTardaMedTradicionalModel tiempoTardaMedTradicional) async {
    final res = await supabase
        .from('TiemposTarda_AccesoMedTradicional')
        .insert(tiempoTardaMedTradicional.toJson());

    return res;
  }
}
