import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/resguardo.dart';

abstract class ResguardoLocalDataSource {
  Future<List<ResguardoModel>> getResguardos();
  Future<int> saveResguardo(ResguardoModel resguardo);
}

class ResguardoLocalDataSourceImpl implements ResguardoLocalDataSource {
  @override
  Future<List<ResguardoModel>> getResguardos() async {
    try {
      final res = await supabase.from('resguardos').select();
      final result =
          List<ResguardoModel>.from(res.map((m) => ResguardoModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveResguardo(ResguardoModel resguardo) async {
    try {
      await supabase.from('resguardos').upsert(resguardo.toJson());

      return resguardo.resguardoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
