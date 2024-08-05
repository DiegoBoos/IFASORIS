import 'package:ifasoris/core/error/failure.dart';

import '../../../core/constants.dart';
import '../../models/dim_vivienda.dart';

abstract class DimViviendaLocalDataSource {
  Future<int> saveDimVivienda(DimViviendaModel dimVivienda);

  Future<DimViviendaModel?> getDimVivienda(int afiliadoId, int familiaId);
}

class DimViviendaLocalDataSourceImpl implements DimViviendaLocalDataSource {
  @override
  Future<int> saveDimVivienda(DimViviendaModel dimVivienda) async {
    try {
      final res = await supabase.from('Asp2_DatosVivienda').insert(
            dimVivienda.toJson(),
          );
      return res;
    } catch (e) {
      throw const DatabaseFailure(['Error al guardar la vivienda']);
    }
  }

  @override
  Future<DimViviendaModel?> getDimVivienda(
      int afiliadoId, int familiaId) async {
    final res = await supabase
        .from('Asp2_DatosVivienda')
        .select()
        .eq('Afiliado_id,Familia_id', [afiliadoId, familiaId]);

    if (res.isEmpty) return null;

    final result = DimViviendaModel.fromJson(res);
    return result;
  }
}
