import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/alimentacion.dart';

abstract class AlimentacionLocalDataSource {
  Future<List<AlimentacionModel>> getAlimentaciones();
  Future<int> saveAlimentacion(AlimentacionModel alimentacion);
}

class AlimentacionLocalDataSourceImpl implements AlimentacionLocalDataSource {
  @override
  Future<List<AlimentacionModel>> getAlimentaciones() async {
    try {
      final res = await supabase.from('alimentacion_estilosvidasaludable');
      final result = List<AlimentacionModel>.from(
          res.map((m) => AlimentacionModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveAlimentacion(AlimentacionModel alimentacion) async {
    try {
      await supabase
          .from('alimentacion_estilosvidasaludable')
          .upsert(alimentacion.toJson());

      return alimentacion.alimentacionId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
