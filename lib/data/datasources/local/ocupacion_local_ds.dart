import '../../../core/constants.dart';
import '../../models/ocupacion.dart';

abstract class OcupacionLocalDataSource {
  Future<List<OcupacionModel>> getOcupaciones();
  Future<int> saveOcupacion(OcupacionModel ocupacion);
}

class OcupacionLocalDataSourceImpl implements OcupacionLocalDataSource {
  @override
  Future<List<OcupacionModel>> getOcupaciones() async {
    final res = await supabase.from('Ocupacion_GrupoFamiliar').select();
    final result =
        List<OcupacionModel>.from(res.map((m) => OcupacionModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveOcupacion(OcupacionModel ocupacion) async {
    final res = await supabase
        .from('Ocupacion_GrupoFamiliar')
        .insert(ocupacion.toJson());

    return res;
  }
}
