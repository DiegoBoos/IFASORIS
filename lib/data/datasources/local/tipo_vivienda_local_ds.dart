import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tipo_vivienda.dart';

abstract class TipoViviendaLocalDataSource {
  Future<List<TipoViviendaModel>> getTiposVivienda();
  Future<int> saveTipoVivienda(TipoViviendaModel tipoVivienda);
}

class TipoViviendaLocalDataSourceImpl implements TipoViviendaLocalDataSource {
  @override
  Future<List<TipoViviendaModel>> getTiposVivienda() async {
    try {
      final res = await supabase.from('TiposVivienda_DatosVivienda').select();
      final result = List<TipoViviendaModel>.from(
          res.map((m) => TipoViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTipoVivienda(TipoViviendaModel tipoVivienda) async {
    try {
      final res = await supabase
          .from('TiposVivienda_DatosVivienda')
          .insert(tipoVivienda.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
