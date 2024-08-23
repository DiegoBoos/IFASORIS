import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/piso_vivienda.dart';

abstract class PisoViviendaLocalDataSource {
  Future<List<PisoViviendaModel>> getPisosVivienda();
  Future<int> savePisoVivienda(PisoViviendaModel pisoVivienda);
  Future<int> savePisosVivienda(int datoViviendaId, List<LstPiso> lstPiso);
  Future<List<LstPiso>> getPisosViviendaVivienda(int? datoViviendaId);
}

class PisoViviendaLocalDataSourceImpl implements PisoViviendaLocalDataSource {
  @override
  Future<List<PisoViviendaModel>> getPisosVivienda() async {
    try {
      final res = await supabase.from('pisosvivienda_datosvivienda').select();
      final result = List<PisoViviendaModel>.from(
          res.map((m) => PisoViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> savePisoVivienda(PisoViviendaModel pisoVivienda) async {
    try {
      await supabase
          .from('pisosvivienda_datosvivienda')
          .upsert(pisoVivienda.toJson());

      return pisoVivienda.pisoViviendaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstPiso>> getPisosViviendaVivienda(int? datoViviendaId) async {
    try {
      final res = await supabase
          .from('asp2_datosviviendapisos')
          .select()
          .eq('DatoVivienda_id', datoViviendaId);
      final result =
          List<LstPiso>.from(res.map((m) => LstPiso.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> savePisosVivienda(
      int datoViviendaId, List<LstPiso> lstPiso) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('asp2_datosviviendapisos')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaPisos = lstPiso
          .map((item) => {
                'PisoVivienda_id': item.pisoViviendaId,
                'DatoVivienda_id': datoViviendaId,
                'OtroTipoPiso': item.otroTipoPiso,
              })
          .toList();

      // Insert the new records
      await supabase.from('asp2_datosviviendapisos').upsert(viviendaPisos);

      // Return the number of rows inserted
      return viviendaPisos.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
