import '../../../core/constants.dart';
import '../../models/autoridad_indigena.dart';

abstract class AutoridadIndigenaLocalDataSource {
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas();
  Future<int> saveAutoridadIndigena(AutoridadIndigenaModel autoridadIndigena);
}

class AutoridadIndigenaLocalDataSourceImpl
    implements AutoridadIndigenaLocalDataSource {
  @override
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas() async {
    final res =
        await supabase.from('AutoridadesIndigenas_DatosVivienda').select();
    final result = List<AutoridadIndigenaModel>.from(
        res.map((m) => AutoridadIndigenaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveAutoridadIndigena(
      AutoridadIndigenaModel autoridadIndigena) async {
    final res = await supabase
        .from('AutoridadesIndigenas_DatosVivienda')
        .insert(autoridadIndigena.toJson());

    return res;
  }
}
