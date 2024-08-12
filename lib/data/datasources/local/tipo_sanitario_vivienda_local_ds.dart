import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tipo_sanitario_vivienda.dart';

abstract class TipoSanitarioViviendaLocalDataSource {
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitario();
  Future<int> saveTipoSanitarioVivienda(
      TipoSanitarioViviendaModel tipoSanitarioVivienda);

  Future<int> saveTiposSanitarioVivienda(
      int datoViviendaId, List<LstTipoSanitario> lstTipoSanitario);

  Future<List<LstTipoSanitario>> getTiposSanitarioVivienda(int? datoViviendaId);
}

class TipoSanitarioViviendaLocalDataSourceImpl
    implements TipoSanitarioViviendaLocalDataSource {
  @override
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitario() async {
    try {
      final res =
          await supabase.from('TiposSanitarioVivienda_DatosVivienda').select();
      final result = List<TipoSanitarioViviendaModel>.from(
          res.map((m) => TipoSanitarioViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTipoSanitarioVivienda(
      TipoSanitarioViviendaModel tipoSanitarioVivienda) async {
    try {
      final res = await supabase
          .from('TiposSanitarioVivienda_DatosVivienda')
          .insert(tipoSanitarioVivienda.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTiposSanitarioVivienda(
      int datoViviendaId, List<LstTipoSanitario> lstTipoSanitario) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('Asp2_DatosViviendaTiposSanitario')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaTiposSanitario = lstTipoSanitario
          .map((item) => {
                'tipoSanitarioViviendaId': item.tipoSanitarioViviendaId,
                'datoViviendaId': datoViviendaId,
                'otroTipoSanitario': item.otroTipoSanitario,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp2_DatosViviendaTiposSanitario')
          .insert(viviendaTiposSanitario);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstTipoSanitario>> getTiposSanitarioVivienda(
      int? datoViviendaId) async {
    try {
      final res = await supabase
          .from('Asp2_DatosViviendaTiposSanitario')
          .select()
          .eq('DatoVivienda_id', datoViviendaId);
      final result = List<LstTipoSanitario>.from(
          res.map((m) => LstTipoSanitario.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
