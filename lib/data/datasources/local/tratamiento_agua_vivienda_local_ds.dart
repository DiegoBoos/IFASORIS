import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tratamiento_agua_vivienda.dart';

abstract class TratamientoAguaViviendaLocalDataSource {
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAgua();
  Future<int> saveTratamientoAguaVivienda(
      TratamientoAguaViviendaModel tratamientoAguaVivienda);
  Future<List<LstTmtoAgua>> getTratamientosAguaVivienda(int? datoViviendaId);
  Future<int> saveTmtoAguasVivienda(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAgua);
}

class TratamientoAguaViviendaLocalDataSourceImpl
    implements TratamientoAguaViviendaLocalDataSource {
  @override
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAgua() async {
    try {
      final res =
          await supabase.from('tratamientoaguavivienda_datosvivienda').select();
      final result = List<TratamientoAguaViviendaModel>.from(
          res.map((m) => TratamientoAguaViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTratamientoAguaVivienda(
      TratamientoAguaViviendaModel tratamientoAguaVivienda) async {
    try {
      await supabase
          .from('tratamientoaguavivienda_datosvivienda')
          .upsert(tratamientoAguaVivienda.toJson());

      return tratamientoAguaVivienda.tratamientoAguaViviendaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstTmtoAgua>> getTratamientosAguaVivienda(
      int? datoViviendaId) async {
    try {
      final res = await supabase
          .from('asp2_datosviviendatratamientosagua')
          .select()
          .eq('DatoVivienda_id', datoViviendaId);
      final result =
          List<LstTmtoAgua>.from(res.map((m) => LstTmtoAgua.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTmtoAguasVivienda(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAgua) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('asp2_datosviviendatratamientosagua')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaTratamientosAgua = lstTmtoAgua
          .map((item) => {
                'TratamientoAguaVivienda_id': item.tratamientoAguaViviendaId,
                'DatoVivienda_id': datoViviendaId,
                'OtroTratamientoAgua': item.otroTratamientoAgua,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp2_datosviviendatratamientosagua')
          .upsert(viviendaTratamientosAgua);

      // Return the number of rows inserted
      return viviendaTratamientosAgua.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
