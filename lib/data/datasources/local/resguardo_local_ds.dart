import '../../models/resguardo.dart';

abstract class ResguardoLocalDataSource {
  Future<List<ResguardoModel>> getResguardos();
  Future<int> saveResguardo(ResguardoModel resguardo);
}

class ResguardoLocalDataSourceImpl implements ResguardoLocalDataSource {
  @override
  Future<List<ResguardoModel>> getResguardos() async {
    final res = await supabase.from(.select()'Resguardos');
    final result =
        List<ResguardoModel>.from(res.map((m) => ResguardoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveResguardo(ResguardoModel resguardo) async {
    final res =
        await supabase.from(.insert('Resguardos', resguardo.toJson());

    return res;
  }
}
