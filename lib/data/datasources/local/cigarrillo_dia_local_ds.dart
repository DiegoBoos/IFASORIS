import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/cigarrillo_dia.dart';

abstract class CigarrilloDiaLocalDataSource {
  Future<List<CigarrilloDiaModel>> getCigarrillosDia();
  Future<int> saveCigarrilloDia(CigarrilloDiaModel cigarrilloDia);
}

class CigarrilloDiaLocalDataSourceImpl implements CigarrilloDiaLocalDataSource {
  @override
  Future<List<CigarrilloDiaModel>> getCigarrillosDia() async {
    try {
      final res = await supabase
          .from('NumeroCigarrilosDia_EstilosVidaSaludable')
          .select();
      final result = List<CigarrilloDiaModel>.from(
          res.map((m) => CigarrilloDiaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveCigarrilloDia(CigarrilloDiaModel cigarrilloDia) async {
    try {
      final res = await supabase
          .from('NumeroCigarrilosDia_EstilosVidaSaludable')
          .insert(cigarrilloDia.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
