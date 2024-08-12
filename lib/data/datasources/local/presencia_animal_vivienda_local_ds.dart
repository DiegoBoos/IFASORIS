import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/presencia_animal_vivienda.dart';

abstract class PresenciaAnimalViviendaLocalDataSource {
  Future<List<PresenciaAnimalViviendaModel>> getPresenciaAnimales();
  Future<int> savePresenciaAnimalVivienda(
      PresenciaAnimalViviendaModel presenciaAnimalVivienda);

  Future<List<LstPresenciaAnimal>> getPresenciasAnimalesVivienda(
      int? datoViviendaId);

  Future<int> savePresenciaAnimalesVivienda(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimal);
}

class PresenciaAnimalViviendaLocalDataSourceImpl
    implements PresenciaAnimalViviendaLocalDataSource {
  @override
  Future<List<PresenciaAnimalViviendaModel>> getPresenciaAnimales() async {
    try {
      final res = await supabase
          .from('PresenciaAnimalesVivienda_DatosVivienda')
          .select();
      final result = List<PresenciaAnimalViviendaModel>.from(
          res.map((m) => PresenciaAnimalViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> savePresenciaAnimalVivienda(
      PresenciaAnimalViviendaModel presenciaAnimalVivienda) async {
    try {
      final res = await supabase
          .from('PresenciaAnimalesVivienda_DatosVivienda')
          .insert(presenciaAnimalVivienda.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> savePresenciaAnimalesVivienda(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimal) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('Asp2_DatosViviendaPresenciaAnimales')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaPresenciaAnimales = lstPresenciaAnimal
          .map((item) => {
                'presenciaAnimalViviendaId': item.presenciaAnimalViviendaId,
                'datoViviendaId': datoViviendaId,
                'otroPresenciaAnimal': item.otroPresenciaAnimal,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp2_DatosViviendaPresenciaAnimales')
          .insert(viviendaPresenciaAnimales);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstPresenciaAnimal>> getPresenciasAnimalesVivienda(
      int? datoViviendaId) async {
    try {
      final res = await supabase
          .from('Asp2_DatosViviendaPresenciaAnimales')
          .select()
          .eq('DatoVivienda_id', datoViviendaId);
      final result = List<LstPresenciaAnimal>.from(
          res.map((m) => LstPresenciaAnimal.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
