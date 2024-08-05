import '../../../core/constants.dart';
import '../../models/actividad_fisica.dart';

abstract class ActividadFisicaLocalDataSource {
  Future<List<ActividadFisicaModel>> getActividadesFisicas();
  Future<int> saveActividadFisica(ActividadFisicaModel actividadFisica);
}

class ActividadFisicaLocalDataSourceImpl
    implements ActividadFisicaLocalDataSource {
  @override
  Future<List<ActividadFisicaModel>> getActividadesFisicas() async {
    final res =
        await supabase.from('ActividadesFisicas_EstilosVidaSaludable').select();
    final result = List<ActividadFisicaModel>.from(
        res.map((m) => ActividadFisicaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveActividadFisica(ActividadFisicaModel actividadFisica) async {
    final res = await supabase
        .from('ActividadesFisicas_EstilosVidaSaludable')
        .insert(actividadFisica.toJson());

    return res;
  }
}
