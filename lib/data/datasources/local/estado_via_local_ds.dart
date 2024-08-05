import '../../../core/constants.dart';
import '../../models/estado_via.dart';

abstract class EstadoViaLocalDataSource {
  Future<List<EstadoViaModel>> getEstadosVias();
  Future<int> saveEstadoVia(EstadoViaModel estadoVia);
}

class EstadoViaLocalDataSourceImpl implements EstadoViaLocalDataSource {
  @override
  Future<List<EstadoViaModel>> getEstadosVias() async {
    final res = await supabase.from('EstadoVias').select();
    final result =
        List<EstadoViaModel>.from(res.map((m) => EstadoViaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveEstadoVia(EstadoViaModel estadoVia) async {
    final res = await supabase.from('EstadoVias').insert(estadoVia.toJson());
    return res;
  }
}
