import 'package:ifasoris/core/error/failure.dart';

import '../../../core/constants.dart';
import '../../models/dim_ubicacion.dart';

abstract class DimUbicacionLocalDataSource {
  Future<int> saveDimUbicacion(DimUbicacionModel dimUbicacion);
  Future<DimUbicacionModel?> getDimUbicacion(int afiliadoId, int familiaId);
}

class DimUbicacionLocalDataSourceImpl implements DimUbicacionLocalDataSource {
  @override
  Future<DimUbicacionModel?> getDimUbicacion(
      int afiliadoId, int familiaId) async {
    final res = await supabase
        .from('Asp1_Ubicacion')
        .select()
        .eq('Afiliado_id,Familia_id', [afiliadoId, familiaId]);

    if (res.isEmpty) return null;

    final result = DimUbicacionModel.fromJson(res);
    return result;
  }

  @override
  Future<int> saveDimUbicacion(DimUbicacionModel dimUbicacion) async {
    try {
      final res = await supabase.from('Asp1_Ubicacion').insert(
            dimUbicacion.toJson(),
          );
      return res;
    } catch (e) {
      throw const DatabaseFailure(['Error al guardar la ubicación']);
    }
  }
}
