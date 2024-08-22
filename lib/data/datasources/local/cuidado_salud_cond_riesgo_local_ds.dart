import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/cuidado_salud_cond_riesgo.dart';

abstract class CuidadoSaludCondRiesgoLocalDataSource {
  Future<CuidadoSaludCondRiesgoModel?> getCuidadoSaludCondRiesgo(
      int afiliadoId);
  Future<int> saveCuidadoSaludCondRiesgo(
      CuidadoSaludCondRiesgoModel cuidadoSaludCondRiesgo);
}

class CuidadoSaludCondRiesgoLocalDataSourceImpl
    implements CuidadoSaludCondRiesgoLocalDataSource {
  @override
  Future<CuidadoSaludCondRiesgoModel?> getCuidadoSaludCondRiesgo(
      int afiliadoId) async {
    try {
      final res = await supabase
          .from('asp5_cuidadosaludcondriesgo')
          .select()
          .eq('Afiliado_id', afiliadoId);

      if (res.isEmpty) return null;

      final result = CuidadoSaludCondRiesgoModel.fromJson(res);
      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveCuidadoSaludCondRiesgo(
      CuidadoSaludCondRiesgoModel cuidadoSaludCondRiesgo) async {
    try {
      final res = await supabase.from('asp5_cuidadosaludcondriesgo').upsert(
            cuidadoSaludCondRiesgo.toJson(),
          );
      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
