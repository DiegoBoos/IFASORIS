import '../../../core/constants.dart';
import '../../models/enfermedad_tratamiento.dart';

abstract class EnfermedadTratamientoLocalDataSource {
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento();
  Future<int> saveEnfermedadTratamiento(
      EnfermedadTratamientoModel enfermedadTratamiento);
}

class EnfermedadTratamientoLocalDataSourceImpl
    implements EnfermedadTratamientoLocalDataSource {
  @override
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento() async {
    final res =
        await supabase.from('EnfermedadesTratamientos_AtencionSalud').select();
    final result = List<EnfermedadTratamientoModel>.from(
        res.map((m) => EnfermedadTratamientoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEnfermedadTratamiento(
      EnfermedadTratamientoModel enfermedadTratamiento) async {
    final res = await supabase
        .from('EnfermedadesTratamientos_AtencionSalud')
        .insert(enfermedadTratamiento.toJson());

    return res;
  }
}
