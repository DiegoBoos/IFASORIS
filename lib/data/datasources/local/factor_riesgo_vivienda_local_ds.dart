import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/factor_riesgo_vivienda.dart';

abstract class FactorRiesgoViviendaLocalDataSource {
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgo();
  Future<int> saveFactorRiesgoVivienda(
      FactorRiesgoViviendaModel factorRiesgoVivienda);

  Future<int> saveFactoresRiesgoVivienda(
      int datoViviendaId, List<LstFactorRiesgo> lstFactorRiesgo);

  Future<List<LstFactorRiesgo>> getFactoresRiesgoVivienda(int? datoViviendaId);
}

class FactorRiesgoViviendaLocalDataSourceImpl
    implements FactorRiesgoViviendaLocalDataSource {
  @override
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgo() async {
    try {
      final res =
          await supabase.from('FactoresRiesgoVivienda_DatosVivienda').select();
      final result = List<FactorRiesgoViviendaModel>.from(
          res.map((m) => FactorRiesgoViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveFactorRiesgoVivienda(
      FactorRiesgoViviendaModel factorRiesgoVivienda) async {
    try {
      final res = await supabase
          .from('FactoresRiesgoVivienda_DatosVivienda')
          .insert(factorRiesgoVivienda.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveFactoresRiesgoVivienda(
      int datoViviendaId, List<LstFactorRiesgo> lstFactorRiesgo) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('Asp2_DatosViviendaFactoresRiesgo')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final factoresRiesgoVivienda = lstFactorRiesgo
          .map((item) => {
                'factorRiesgoViviendaId': item.factorRiesgoViviendaId,
                'datoViviendaId': datoViviendaId,
                'otroFactorRiesgo': item.otroFactorRiesgo,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp2_DatosViviendaFactoresRiesgo')
          .insert(factoresRiesgoVivienda);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstFactorRiesgo>> getFactoresRiesgoVivienda(
      int? datoViviendaId) async {
    try {
      final res = await supabase
          .from('Asp2_DatosViviendaFactoresRiesgo')
          .select()
          .eq('DatoVivienda_id', datoViviendaId);
      final result = List<LstFactorRiesgo>.from(
          res.map((m) => LstFactorRiesgo.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
