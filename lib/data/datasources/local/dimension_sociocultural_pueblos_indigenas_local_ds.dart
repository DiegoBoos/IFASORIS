import 'package:ifasoris/core/error/failure.dart';

import '../../../core/constants.dart';
import '../../models/dimension_sociocultural_pueblos_indigenas.dart';

abstract class DimensionSocioCulturalPueblosIndigenasLocalDataSource {
  Future<int> saveDimensionSocioCulturalPueblosIndigenas(
      DimensionSocioCulturalPueblosIndigenasModel
          dimensionSocioCulturalPueblosIndigenas);

  Future<DimensionSocioCulturalPueblosIndigenasModel?>
      getDimensionSocioCulturalPueblosIndigenas(int afiliadoId);
}

class DimensionSocioCulturalPueblosIndigenasLocalDataSourceImpl
    implements DimensionSocioCulturalPueblosIndigenasLocalDataSource {
  @override
  Future<int> saveDimensionSocioCulturalPueblosIndigenas(
      DimensionSocioCulturalPueblosIndigenasModel
          dimensionSocioCulturalPueblosIndigenas) async {
    try {
      final res =
          await supabase.from('Asp6_DimSocioCulturalPueblosIndigenas').insert(
                dimensionSocioCulturalPueblosIndigenas.toJson(),
              );
      return res;
    } catch (e) {
      throw const DatabaseFailure(
          ['Error al guardar dim sociocultural pueblos indigenas']);
    }
  }

  @override
  Future<DimensionSocioCulturalPueblosIndigenasModel?>
      getDimensionSocioCulturalPueblosIndigenas(int afiliadoId) async {
    final res = await supabase
        .from('Asp6_DimSocioCulturalPueblosIndigenas')
        .select()
        .eq('Afiliado_id', afiliadoId);

    if (res.isEmpty) return null;

    final result = DimensionSocioCulturalPueblosIndigenasModel.fromJson(res);
    return result;
  }
}
