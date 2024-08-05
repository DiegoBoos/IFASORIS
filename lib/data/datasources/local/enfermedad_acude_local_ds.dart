import '../../../core/constants.dart';
import '../../models/enfermedad_acude.dart';

abstract class EnfermedadAcudeLocalDataSource {
  Future<List<EnfermedadAcudeModel>> getEnfermedadesAcude();
  Future<int> saveEnfermedadAcude(EnfermedadAcudeModel enfermedadAcude);
}

class EnfermedadAcudeLocalDataSourceImpl
    implements EnfermedadAcudeLocalDataSource {
  @override
  Future<List<EnfermedadAcudeModel>> getEnfermedadesAcude() async {
    final res = await supabase.from('EnfermedadesAcude_AtencionSalud').select();
    final result = List<EnfermedadAcudeModel>.from(
        res.map((m) => EnfermedadAcudeModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEnfermedadAcude(EnfermedadAcudeModel enfermedadAcude) async {
    final res = await supabase
        .from('EnfermedadesAcude_AtencionSalud')
        .insert(enfermedadAcude.toJson());

    return res;
  }
}
