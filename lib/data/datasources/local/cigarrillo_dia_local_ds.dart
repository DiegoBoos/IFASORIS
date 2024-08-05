import '../../../core/constants.dart';
import '../../models/cigarrillo_dia.dart';

abstract class CigarrilloDiaLocalDataSource {
  Future<List<CigarrilloDiaModel>> getCigarrillosDia();
  Future<int> saveCigarrilloDia(CigarrilloDiaModel cigarrilloDia);
}

class CigarrilloDiaLocalDataSourceImpl implements CigarrilloDiaLocalDataSource {
  @override
  Future<List<CigarrilloDiaModel>> getCigarrillosDia() async {
    final res = await supabase
        .from('NumeroCigarrilosDia_EstilosVidaSaludable')
        .select();
    final result = List<CigarrilloDiaModel>.from(
        res.map((m) => CigarrilloDiaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCigarrilloDia(CigarrilloDiaModel cigarrilloDia) async {
    final res = await supabase
        .from('NumeroCigarrilosDia_EstilosVidaSaludable')
        .insert(cigarrilloDia.toJson());

    return res;
  }
}
