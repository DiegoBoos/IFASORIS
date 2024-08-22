import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/ocupacion.dart';

abstract class OcupacionLocalDataSource {
  Future<List<OcupacionModel>> getOcupaciones();
  Future<int> saveOcupacion(OcupacionModel ocupacion);
}

class OcupacionLocalDataSourceImpl implements OcupacionLocalDataSource {
  @override
  Future<List<OcupacionModel>> getOcupaciones() async {
    try {
      final res = await supabase.from('ocupacion_grupofamiliar').select();
      final result =
          List<OcupacionModel>.from(res.map((m) => OcupacionModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveOcupacion(OcupacionModel ocupacion) async {
    try {
      await supabase.from('ocupacion_grupofamiliar').upsert(ocupacion.toJson());

      return ocupacion.ocupacionId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
