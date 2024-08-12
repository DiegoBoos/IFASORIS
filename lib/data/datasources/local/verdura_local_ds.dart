import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/verdura.dart';

abstract class VerduraLocalDataSource {
  Future<List<VerduraModel>> getVerduras();
  Future<int> saveVerdura(VerduraModel verdura);

  Future<int> saveUbicacionVerduras(
      int ubicacionId, List<LstVerdura> lstVerduras);

  Future<List<LstVerdura>> getUbicacionVerduras(int? ubicacionId);
}

class VerduraLocalDataSourceImpl implements VerduraLocalDataSource {
  @override
  Future<List<VerduraModel>> getVerduras() async {
    try {
      final res =
          await supabase.from('Verduras_AspectosSocioEconomicos').select();
      final result =
          List<VerduraModel>.from(res.map((m) => VerduraModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveVerdura(VerduraModel verdura) async {
    try {
      final res = await supabase
          .from('Verduras_AspectosSocioEconomicos')
          .insert(verdura.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionVerduras(
      int ubicacionId, List<LstVerdura> lstVerduras) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('Asp1_UbicacionVerduras')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionVerduras = lstVerduras
          .map((item) => {
                'verduraId': item.verduraId,
                'ubicacionId': ubicacionId,
                'otroVerdura': item.otroVerdura,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionVerduras')
          .insert(ubicacionVerduras);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstVerdura>> getUbicacionVerduras(int? ubicacionId) async {
    try {
      final res = await supabase
          .from('Asp1_UbicacionVerduras')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result =
          List<LstVerdura>.from(res.map((m) => LstVerdura.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
