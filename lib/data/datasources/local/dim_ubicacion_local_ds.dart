import 'package:ifasoris/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../models/dim_ubicacion.dart';

abstract class DimUbicacionLocalDataSource {
  Future<DimUbicacionModel?> getDimUbicacion(int afiliadoId, int familiaId);
  Future<DimUbicacionModel> saveDimUbicacion(DimUbicacionModel dimUbicacion);
}

class DimUbicacionLocalDataSourceImpl implements DimUbicacionLocalDataSource {
  @override
  Future<DimUbicacionModel?> getDimUbicacion(
      int afiliadoId, int familiaId) async {
    try {
      final res = await supabase
          .from('asp1_ubicacion')
          .select()
          .eq('Afiliado_id', afiliadoId)
          .eq('Familia_id', familiaId);

      if (res == null || res.isEmpty) return null;

      // Assuming you expect only one result, take the first entry
      final result = DimUbicacionModel.fromJson(res.data[0]);
      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<DimUbicacionModel> saveDimUbicacion(
      DimUbicacionModel dimUbicacion) async {
    try {
      final resp = await supabase
          .from('asp1_ubicacion')
          .upsert(
            dimUbicacion.toJson(),
          )
          .select()
          .single();

      final ubicacion = DimUbicacionModel.fromJson(resp);
      return ubicacion;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
