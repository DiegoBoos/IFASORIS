import '../../../core/constants.dart';
import '../../models/alimentacion.dart';

abstract class AlimentacionLocalDataSource {
  Future<List<AlimentacionModel>> getAlimentaciones();
  Future<int> saveAlimentacion(AlimentacionModel alimentacion);
}

class AlimentacionLocalDataSourceImpl implements AlimentacionLocalDataSource {
  @override
  Future<List<AlimentacionModel>> getAlimentaciones() async {
    final res = await supabase.from('Alimentacion_EstilosVidaSaludable');
    final result = List<AlimentacionModel>.from(
        res.map((m) => AlimentacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveAlimentacion(AlimentacionModel alimentacion) async {
    final res = await supabase
        .from('Alimentacion_EstilosVidaSaludable')
        .insert(alimentacion.toJson());

    return res;
  }
}
