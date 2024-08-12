import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/estado_via.dart';

abstract class EstadoViaLocalDataSource {
  Future<List<EstadoViaModel>> getEstadosVias();
  Future<int> saveEstadoVia(EstadoViaModel estadoVia);
}

class EstadoViaLocalDataSourceImpl implements EstadoViaLocalDataSource {
  @override
  Future<List<EstadoViaModel>> getEstadosVias() async {
    try {
      final res = await supabase.from('EstadoVias').select();
      final result =
          List<EstadoViaModel>.from(res.map((m) => EstadoViaModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEstadoVia(EstadoViaModel estadoVia) async {
    try {
      final res = await supabase.from('EstadoVias').insert(estadoVia.toJson());
      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
