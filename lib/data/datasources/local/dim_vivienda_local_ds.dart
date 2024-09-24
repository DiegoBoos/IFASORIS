import 'package:ifasoris/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../models/dim_vivienda.dart';

abstract class DimViviendaLocalDataSource {
  Future<DimViviendaModel?> getDimVivienda(int afiliadoId, int familiaId);
  Future<DimViviendaModel> saveDimVivienda(DimViviendaModel dimVivienda);
}

class DimViviendaLocalDataSourceImpl implements DimViviendaLocalDataSource {
  @override
  Future<DimViviendaModel?> getDimVivienda(
      int afiliadoId, int familiaId) async {
    try {
      final res = await supabase
          .from('asp2_datosvivienda')
          .select()
          .eq('Afiliado_id,Familia_id', [afiliadoId, familiaId]);

      if (res.isEmpty) return null;

      final result = DimViviendaModel.fromJson(res);
      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<DimViviendaModel> saveDimVivienda(DimViviendaModel dimVivienda) async {
    try {
      final resp = await supabase
          .from('asp2_datosvivienda')
          .upsert(
            dimVivienda.toJson(),
          )
          .select()
          .single();

      final vivienda = DimViviendaModel.fromJson(resp);
      return vivienda;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
