import '../../models/lengua_maneja.dart';

abstract class LenguaManejaLocalDataSource {
  Future<List<LenguaManejaModel>> getLenguasManeja();
  Future<int> saveLenguaManeja(LenguaManejaModel lenguaManeja);
}

class LenguaManejaLocalDataSourceImpl implements LenguaManejaLocalDataSource {
  @override
  Future<List<LenguaManejaModel>> getLenguasManeja() async {
    final res = await supabase.from(.select()'LenguaManeja_GrupoFamiliar');
    final result = List<LenguaManejaModel>.from(
        res.map((m) => LenguaManejaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLenguaManeja(LenguaManejaModel lenguaManeja) async {
    final res = await supabase
        .from(
        .insert('LenguaManeja_GrupoFamiliar', lenguaManeja.toJson());

    return res;
  }
}
