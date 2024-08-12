import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/hortaliza.dart';

abstract class HortalizaLocalDataSource {
  Future<List<HortalizaModel>> getHortalizas();
  Future<int> saveHortaliza(HortalizaModel hortaliza);

  Future<int> saveUbicacionHortalizas(
      int ubicacionId, List<LstHortaliza> lstHortalizas);

  Future<List<LstHortaliza>> getUbicacionHortalizas(int? ubicacionId);
}

class HortalizaLocalDataSourceImpl implements HortalizaLocalDataSource {
  @override
  Future<List<HortalizaModel>> getHortalizas() async {
    try {
      final res =
          await supabase.from('Hortalizas_AspectosSocioEconomicos').select();
      final result =
          List<HortalizaModel>.from(res.map((m) => HortalizaModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveHortaliza(HortalizaModel hortaliza) async {
    try {
      final res = await supabase
          .from('Hortalizas_AspectosSocioEconomicos')
          .insert(hortaliza.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionHortalizas(
      int ubicacionId, List<LstHortaliza> lstHortalizas) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('Asp1_UbicacionHortalizas')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionHortalizas = lstHortalizas
          .map((item) => {
                'hortalizaId': item.hortalizaId,
                'ubicacionId': ubicacionId,
                'otroHortaliza': item.otroHortaliza,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionHortalizas')
          .insert(ubicacionHortalizas);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstHortaliza>> getUbicacionHortalizas(int? ubicacionId) async {
    try {
      final res = await supabase
          .from('Asp1_UbicacionHortalizas')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result =
          List<LstHortaliza>.from(res.map((m) => LstHortaliza.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
