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
      final res = await supabase.from('PisosVivienda_DatosVivienda').select();
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
      final res = await supabase
          .from('PisosVivienda_DatosVivienda')
          .insert(pisoVivienda.toJson());

      return res;
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
          .from('Asp2_DatosViviendaPisos')
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
          .from('Asp2_DatosViviendaPisos')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaPisos = lstPiso
          .map((item) => {
                'pisoViviendaId': item.pisoViviendaId,
                'datoViviendaId': datoViviendaId,
                'otroTipoPiso': item.otroTipoPiso,
              })
          .toList();

      // Insert the new records
      final res =
          await supabase.from('Asp2_DatosViviendaPisos').insert(viviendaPisos);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
