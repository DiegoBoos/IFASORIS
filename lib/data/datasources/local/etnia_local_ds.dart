import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/etnia.dart';

abstract class EtniaLocalDataSource {
  Future<List<EtniaModel>> getEtnias();
  Future<int> saveEtnia(EtniaModel etnia);
}

class EtniaLocalDataSourceImpl implements EtniaLocalDataSource {
  @override
  Future<List<EtniaModel>> getEtnias() async {
    try {
      final res = await supabase.from('etnia_grupofamiliar').select();
      final result =
          List<EtniaModel>.from(res.map((m) => EtniaModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEtnia(EtniaModel etnia) async {
    try {
      await supabase.from('etnia_grupofamiliar').upsert(etnia.toJson());

      return etnia.etniaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
