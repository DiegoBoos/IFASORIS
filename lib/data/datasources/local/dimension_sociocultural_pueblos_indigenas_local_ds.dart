import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/dimension_sociocultural_pueblos_indigenas.dart';

abstract class DimensionSocioCulturalPueblosIndigenasLocalDataSource {
  Future<DimensionSocioCulturalPueblosIndigenasModel?>
      getDimensionSocioCulturalPueblosIndigenas(int afiliadoId);
  Future<int> saveDimensionSocioCulturalPueblosIndigenas(
      DimensionSocioCulturalPueblosIndigenasModel
          dimensionSocioCulturalPueblosIndigenas);
}

class DimensionSocioCulturalPueblosIndigenasLocalDataSourceImpl
    implements DimensionSocioCulturalPueblosIndigenasLocalDataSource {
  @override
  Future<DimensionSocioCulturalPueblosIndigenasModel?>
      getDimensionSocioCulturalPueblosIndigenas(int afiliadoId) async {
    try {
      final res = await supabase
          .from('asp6_dimsocioculturalpueblosindigenas')
          .select()
          .eq('Afiliado_id', afiliadoId);

      if (res.isEmpty) return null;

      final result = DimensionSocioCulturalPueblosIndigenasModel.fromJson(res);
      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveDimensionSocioCulturalPueblosIndigenas(
      DimensionSocioCulturalPueblosIndigenasModel
          dimensionSocioCulturalPueblosIndigenas) async {
    try {
      await supabase.from('asp6_dimsocioculturalpueblosindigenas').upsert(
            dimensionSocioCulturalPueblosIndigenas.toJson(),
          );
      return dimensionSocioCulturalPueblosIndigenas
          .dimSocioCulturalPueblosIndigenasId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
