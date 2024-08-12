import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/pueblo_indigena.dart';

abstract class PuebloIndigenaLocalDataSource {
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas();
  Future<int> savePuebloIndigena(PuebloIndigenaModel puebloIndigena);
}

class PuebloIndigenaLocalDataSourceImpl
    implements PuebloIndigenaLocalDataSource {
  @override
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas() async {
    try {
      final res =
          await supabase.from('PueblosIndigenas_GrupoFamiliar').select();
      final result = List<PuebloIndigenaModel>.from(
          res.map((m) => PuebloIndigenaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> savePuebloIndigena(PuebloIndigenaModel puebloIndigena) async {
    try {
      final res = await supabase
          .from('PueblosIndigenas_GrupoFamiliar')
          .insert(puebloIndigena.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
