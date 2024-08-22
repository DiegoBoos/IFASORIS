import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/ventilacion_vivienda.dart';

abstract class VentilacionViviendaLocalDataSource {
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda();
  Future<int> saveVentilacionVivienda(
      VentilacionViviendaModel ventilacionVivienda);
}

class VentilacionViviendaLocalDataSourceImpl
    implements VentilacionViviendaLocalDataSource {
  @override
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda() async {
    try {
      final res =
          await supabase.from('ventilacionvivienda_datosvivienda').select();
      final result = List<VentilacionViviendaModel>.from(
          res.map((m) => VentilacionViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveVentilacionVivienda(
      VentilacionViviendaModel ventilacionVivienda) async {
    try {
      await supabase
          .from('ventilacionvivienda_datosvivienda')
          .upsert(ventilacionVivienda.toJson());

      return ventilacionVivienda.ventilacionViviendaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
