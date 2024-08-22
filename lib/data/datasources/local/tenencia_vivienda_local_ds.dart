import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tenencia_vivienda.dart';

abstract class TenenciaViviendaLocalDataSource {
  Future<List<TenenciaViviendaModel>> getTenenciasVivienda();
  Future<int> saveTenenciaVivienda(TenenciaViviendaModel tenenciaVivienda);
}

class TenenciaViviendaLocalDataSourceImpl
    implements TenenciaViviendaLocalDataSource {
  @override
  Future<List<TenenciaViviendaModel>> getTenenciasVivienda() async {
    try {
      final res =
          await supabase.from('tenenciasvivienda_datosvivienda').select();
      final result = List<TenenciaViviendaModel>.from(
          res.map((m) => TenenciaViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTenenciaVivienda(
      TenenciaViviendaModel tenenciaVivienda) async {
    try {
      await supabase
          .from('tenenciasvivienda_datosvivienda')
          .upsert(tenenciaVivienda.toJson());

      return tenenciaVivienda.tenenciaViviendaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
