import '../../models/via_acceso.dart';

abstract class ViaAccesoLocalDataSource {
  Future<List<ViaAccesoModel>> getViasAcceso();
  Future<int> saveViaAcceso(ViaAccesoModel viaAcceso);
}

class ViaAccesoLocalDataSourceImpl implements ViaAccesoLocalDataSource {
  @override
  Future<List<ViaAccesoModel>> getViasAcceso() async {
    final res = await supabase.from(.select()'ViasAcceso');
    final result =
        List<ViaAccesoModel>.from(res.map((m) => ViaAccesoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveViaAcceso(ViaAccesoModel viaAcceso) async {
    final res =
        await supabase.from(.insert('ViasAcceso', viaAcceso.toJson());

    return res;
  }
}
