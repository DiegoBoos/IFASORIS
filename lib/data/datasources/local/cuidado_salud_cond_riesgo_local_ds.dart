import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/cuidado_salud_cond_riesgo.dart';

abstract class CuidadoSaludCondRiesgoLocalDataSource {
  Future<int> saveCuidadoSaludCondRiesgo(
      CuidadoSaludCondRiesgoModel cuidadoSaludCondRiesgo);
  Future<CuidadoSaludCondRiesgoModel?> getCuidadoSaludCondRiesgo(
      int afiliadoId);
}

class CuidadoSaludCondRiesgoLocalDataSourceImpl
    implements CuidadoSaludCondRiesgoLocalDataSource {
  @override
  Future<int> saveCuidadoSaludCondRiesgo(
      CuidadoSaludCondRiesgoModel cuidadoSaludCondRiesgo) async {
    try {
      final res = await supabase.from('Asp5_CuidadoSaludCondRiesgo').insert(
            cuidadoSaludCondRiesgo.toJson(),
          );
      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<CuidadoSaludCondRiesgoModel?> getCuidadoSaludCondRiesgo(
      int afiliadoId) async {
    try {
      final res = await supabase
          .from('Asp5_CuidadoSaludCondRiesgo')
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
}
