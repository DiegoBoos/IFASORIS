import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/via_acceso.dart';

abstract class ViaAccesoLocalDataSource {
  Future<List<ViaAccesoModel>> getViasAcceso();
  Future<int> saveViaAcceso(ViaAccesoModel viaAcceso);
}

class ViaAccesoLocalDataSourceImpl implements ViaAccesoLocalDataSource {
  @override
  Future<List<ViaAccesoModel>> getViasAcceso() async {
    try {
      final res = await supabase.from('viasacceso').select();
      final result =
          List<ViaAccesoModel>.from(res.map((m) => ViaAccesoModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveViaAcceso(ViaAccesoModel viaAcceso) async {
    try {
      await supabase.from('viasacceso').upsert(viaAcceso.toJson());

      return viaAcceso.viaAccesoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
