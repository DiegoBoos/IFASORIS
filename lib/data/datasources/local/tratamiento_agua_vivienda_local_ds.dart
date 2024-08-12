import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tratamiento_agua_vivienda.dart';

abstract class TratamientoAguaViviendaLocalDataSource {
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAgua();
  Future<int> saveTratamientoAguaVivienda(
      TratamientoAguaViviendaModel tratamientoAguaVivienda);

  Future<int> saveTmtoAguasVivienda(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAgua);

  Future<List<LstTmtoAgua>> getTratamientosAguaVivienda(int? datoViviendaId);
}

class TratamientoAguaViviendaLocalDataSourceImpl
    implements TratamientoAguaViviendaLocalDataSource {
  @override
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAgua() async {
    try {
      final res =
          await supabase.from('TratamientoAguaVivienda_DatosVivienda').select();
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
      final res = await supabase
          .from('TratamientoAguaVivienda_DatosVivienda')
          .insert(tratamientoAguaVivienda.toJson());

      return res;
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
          .from('Asp2_DatosViviendaTratamientosAgua')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaTratamientosAgua = lstTmtoAgua
          .map((item) => {
                'tratamientoAguaViviendaId': item.tratamientoAguaViviendaId,
                'datoViviendaId': datoViviendaId,
                'otroTratamientoAgua': item.otroTratamientoAgua,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp2_DatosViviendaTratamientosAgua')
          .insert(viviendaTratamientosAgua);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
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
          .from('Asp2_DatosViviendaTratamientosAgua')
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
}
