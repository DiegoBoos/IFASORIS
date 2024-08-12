import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tipo_combustible_vivienda.dart';

abstract class TipoCombustibleViviendaLocalDataSource {
  Future<List<TipoCombustibleViviendaModel>> getTiposCombustible();
  Future<int> saveTipoCombustibleVivienda(
      TipoCombustibleViviendaModel tipoCombustibleVivienda);

  Future<int> saveTiposCombustibleVivienda(
      int datoViviendaId, List<LstTipoCombustible> lstTipoCombustible);

  Future<List<LstTipoCombustible>> getTiposCombustibleVivienda(
      int? datoViviendaId);
}

class TipoCombustibleViviendaLocalDataSourceImpl
    implements TipoCombustibleViviendaLocalDataSource {
  @override
  Future<List<TipoCombustibleViviendaModel>> getTiposCombustible() async {
    try {
      final res = await supabase
          .from('TiposCombustibleVivienda_DatosVivienda')
          .select();
      final result = List<TipoCombustibleViviendaModel>.from(
          res.map((m) => TipoCombustibleViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTipoCombustibleVivienda(
      TipoCombustibleViviendaModel tipoCombustibleVivienda) async {
    try {
      final res = await supabase
          .from('TiposCombustibleVivienda_DatosVivienda')
          .insert(tipoCombustibleVivienda.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTiposCombustibleVivienda(
      int datoViviendaId, List<LstTipoCombustible> lstTipoCombustible) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('Asp2_DatosViviendaTiposCombustible')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaTiposCombustible = lstTipoCombustible
          .map((item) => {
                'tipoCombustibleViviendaId': item.tipoCombustibleViviendaId,
                'datoViviendaId': datoViviendaId,
                'otroTipoCombustible': item.otroTipoCombustible,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp2_DatosViviendaTiposCombustible')
          .insert(viviendaTiposCombustible);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstTipoCombustible>> getTiposCombustibleVivienda(
      int? datoViviendaId) async {
    try {
      final res = await supabase
          .from('Asp2_DatosViviendaTiposCombustible')
          .select()
          .eq('DatoVivienda_id', datoViviendaId);
      final result = List<LstTipoCombustible>.from(
          res.map((m) => LstTipoCombustible.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
