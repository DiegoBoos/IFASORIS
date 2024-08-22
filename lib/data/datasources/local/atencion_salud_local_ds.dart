import 'package:ifasoris/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../models/atencion_salud.dart';

abstract class AtencionSaludLocalDataSource {
  Future<int> saveAtencionSalud(AtencionSaludModel atencionSalud);

  Future<AtencionSaludModel?> getAtencionSalud(int afiliadoId);
}

class AtencionSaludLocalDataSourceImpl implements AtencionSaludLocalDataSource {
  @override
  Future<AtencionSaludModel?> getAtencionSalud(int afiliadoId) async {
    try {
      final res = await supabase
          .from('asp7_atencionsalud')
          .select()
          .eq('Afiliado_id', afiliadoId);

      if (res.isEmpty) return null;

      final result = AtencionSaludModel.fromJson(res);
      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveAtencionSalud(AtencionSaludModel atencionSalud) async {
    try {
      await supabase.from('asp7_atencionsalud').upsert(
            atencionSalud.toJson(),
          );
      return atencionSalud.atencionSaludId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure(['Error al guardar atencion en salud']);
    }
  }
}
