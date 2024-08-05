import '../../../core/constants.dart';
import '../../models/conducta_seguir.dart';

abstract class ConductaSeguirLocalDataSource {
  Future<List<ConductaSeguirModel>> getConductasSeguir();
  Future<int> saveConductaSeguir(ConductaSeguirModel conductaSeguir);
}

class ConductaSeguirLocalDataSourceImpl
    implements ConductaSeguirLocalDataSource {
  @override
  Future<List<ConductaSeguirModel>> getConductasSeguir() async {
    final res =
        await supabase.from('ConductasSeguir_CuidadoSaludCondRiesgo').select();
    final result = List<ConductaSeguirModel>.from(
        res.map((m) => ConductaSeguirModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveConductaSeguir(ConductaSeguirModel conductaSeguir) async {
    final res = await supabase
        .from('ConductasSeguir_CuidadoSaludCondRiesgo')
        .insert(conductaSeguir.toJson());

    return res;
  }
}
