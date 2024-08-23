import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/techo_vivienda.dart';

abstract class TechoViviendaLocalDataSource {
  Future<List<TechoViviendaModel>> getTechosVivienda();
  Future<int> saveTechoVivienda(TechoViviendaModel techoVivienda);
  Future<List<LstTecho>> getTechosViviendaVivienda(int? datoViviendaId);
  Future<int> saveTechosVivienda(int datoViviendaId, List<LstTecho> lstTecho);
}

class TechoViviendaLocalDataSourceImpl implements TechoViviendaLocalDataSource {
  @override
  Future<List<TechoViviendaModel>> getTechosVivienda() async {
    try {
      final res = await supabase.from('techosvivienda_datosvivienda').select();
      final result = List<TechoViviendaModel>.from(
          res.map((m) => TechoViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTechoVivienda(TechoViviendaModel techoVivienda) async {
    try {
      await supabase
          .from('techosvivienda_datosvivienda')
          .upsert(techoVivienda.toJson());

      return techoVivienda.techoViviendaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstTecho>> getTechosViviendaVivienda(int? datoViviendaId) async {
    try {
      final res = await supabase
          .from('asp2_datosviviendatechos')
          .select()
          .eq('DatoVivienda_id', datoViviendaId);
      final result =
          List<LstTecho>.from(res.map((m) => LstTecho.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTechosVivienda(
      int datoViviendaId, List<LstTecho> lstTecho) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('asp2_datosviviendatechos')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaTechos = lstTecho
          .map((item) => {
                'TechoVivienda_id': item.techoViviendaId,
                'DatoVivienda_id': datoViviendaId,
                'OtroTipoTecho': item.otroTipoTecho,
              })
          .toList();

      // Insert the new records
      await supabase.from('asp2_datosviviendatechos').upsert(viviendaTechos);

      // Return the number of rows inserted
      return viviendaTechos.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
