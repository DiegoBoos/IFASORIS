import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/opcion_si_no.dart';

abstract class OpcionSiNoLocalDataSource {
  Future<List<OpcionSiNoModel>> getOpcionesSiNo();
  Future<int> saveOpcionSiNo(OpcionSiNoModel opcionSiNo);
}

class OpcionSiNoLocalDataSourceImpl implements OpcionSiNoLocalDataSource {
  @override
  Future<List<OpcionSiNoModel>> getOpcionesSiNo() async {
    try {
      final res = await supabase.from('opcionessi_no').select();
      final result = List<OpcionSiNoModel>.from(
          res.map((m) => OpcionSiNoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveOpcionSiNo(OpcionSiNoModel opcionSiNo) async {
    try {
      await supabase.from('opcionessi_no').upsert(opcionSiNo.toJson());

      return opcionSiNo.opcionId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
