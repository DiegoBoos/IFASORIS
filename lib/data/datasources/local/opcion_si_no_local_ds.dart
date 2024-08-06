import '../../../core/constants.dart';
import '../../models/opcion_si_no.dart';

abstract class OpcionSiNoLocalDataSource {
  Future<List<OpcionSiNoModel>> getOpcionesSiNo();
  Future<int> saveOpcionSiNo(OpcionSiNoModel opcionSiNo);
}

class OpcionSiNoLocalDataSourceImpl implements OpcionSiNoLocalDataSource {
  @override
  Future<List<OpcionSiNoModel>> getOpcionesSiNo() async {
    final res = await supabase.from('OpcionesSi_No').select();
    final result =
        List<OpcionSiNoModel>.from(res.map((m) => OpcionSiNoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveOpcionSiNo(OpcionSiNoModel opcionSiNo) async {
    final res =
        await supabase.from('OpcionesSi_No').insert(opcionSiNo.toJson());

    return res;
  }
}
