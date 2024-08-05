import 'package:ifasoris/core/error/failure.dart';

import '../../../core/constants.dart';
import '../../models/atencion_salud.dart';

abstract class AtencionSaludLocalDataSource {
  Future<int> saveAtencionSalud(AtencionSaludModel atencionSalud);

  Future<AtencionSaludModel?> getAtencionSalud(int afiliadoId);
}

class AtencionSaludLocalDataSourceImpl implements AtencionSaludLocalDataSource {
  @override
  Future<int> saveAtencionSalud(AtencionSaludModel atencionSalud) async {
    try {
      final res = await supabase.from('Asp7_AtencionSalud').insert(
            atencionSalud.toJson(),
          );
      return res;
    } catch (e) {
      throw const DatabaseFailure(['Error al guardar atencion en salud']);
    }
  }

  @override
  Future<AtencionSaludModel?> getAtencionSalud(int afiliadoId) async {
    final res = await supabase
        .from('Asp7_AtencionSalud')
        .select()
        .eq('Afiliado_id', afiliadoId);

    if (res.isEmpty) return null;

    final result = AtencionSaludModel.fromJson(res);
    return result;
  }
}
