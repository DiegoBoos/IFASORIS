import 'package:ifasoris/core/error/failure.dart';

import '../../../core/constants.dart';
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
    } catch (e) {
      throw const DatabaseFailure(
          ['Error al guardar cuidado salud cond riesgo']);
    }
  }

  @override
  Future<CuidadoSaludCondRiesgoModel?> getCuidadoSaludCondRiesgo(
      int afiliadoId) async {
    final res = await supabase
        .from('Asp5_CuidadoSaludCondRiesgo')
        .select()
        .eq('Afiliado_id', afiliadoId);

    if (res.isEmpty) return null;

    final result = CuidadoSaludCondRiesgoModel.fromJson(res);
    return result;
  }
}
