import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/religion_profesa.dart';

abstract class ReligionProfesaLocalDataSource {
  Future<List<ReligionProfesaModel>> getReligionesProfesa();
  Future<int> saveReligionProfesa(ReligionProfesaModel religionProfesa);
}

class ReligionProfesaLocalDataSourceImpl
    implements ReligionProfesaLocalDataSource {
  @override
  Future<List<ReligionProfesaModel>> getReligionesProfesa() async {
    try {
      final res = await supabase
          .from('ReligionesProfesa_DimSocioCulturalPueblosIndigenas')
          .select();
      final result = List<ReligionProfesaModel>.from(
          res.map((m) => ReligionProfesaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveReligionProfesa(ReligionProfesaModel religionProfesa) async {
    try {
      final res = await supabase
          .from('ReligionesProfesa_DimSocioCulturalPueblosIndigenas')
          .insert(religionProfesa.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
