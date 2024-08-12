import 'package:ifasoris/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../models/estilo_vida_saludable.dart';

abstract class EstiloVidaSaludableLocalDataSource {
  Future<int> saveEstiloVidaSaludable(
      EstiloVidaSaludableModel estiloVidaSaludable);

  Future<EstiloVidaSaludableModel?> getEstiloVidaSaludable(int afiliadoId);
}

class EstiloVidaSaludableLocalDataSourceImpl
    implements EstiloVidaSaludableLocalDataSource {
  @override
  Future<int> saveEstiloVidaSaludable(
      EstiloVidaSaludableModel estiloVidaSaludable) async {
    try {
      final res = await supabase.from('Asp4_EstilosVidaSaludable').insert(
            estiloVidaSaludable.toJson(),
          );
      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure(
          ['Error al guardar estilo de vida saludable']);
    }
  }

  @override
  Future<EstiloVidaSaludableModel?> getEstiloVidaSaludable(
      int afiliadoId) async {
    try {
      final res = await supabase
          .from('Asp4_EstilosVidaSaludable')
          .select()
          .eq('Afiliado_id', afiliadoId);

      if (res.isEmpty) return null;

      final result = EstiloVidaSaludableModel.fromJson(res);
      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure(
          ['Error al obtener estilo de vida saludable']);
    }
  }
}
