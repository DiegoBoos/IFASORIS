import '../../models/metodo_planificacion.dart';

abstract class MetodoPlanificacionLocalDataSource {
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion();
  Future<int> saveMetodoPlanificacion(
      MetodoPlanificacionModel metodoPlanificacion);
}

class MetodoPlanificacionLocalDataSourceImpl
    implements MetodoPlanificacionLocalDataSource {
  @override
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion() async {
    final res = await supabase.from(.select()'MetodosPlanificacion_CuidadoSaludCondRiesgo');
    final result = List<MetodoPlanificacionModel>.from(
        res.map((m) => MetodoPlanificacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveMetodoPlanificacion(
      MetodoPlanificacionModel metodoPlanificacion) async {
    final res = await supabase.from(.insert(
        'MetodosPlanificacion_CuidadoSaludCondRiesgo',
        metodoPlanificacion.toJson());

    return res;
  }
}
