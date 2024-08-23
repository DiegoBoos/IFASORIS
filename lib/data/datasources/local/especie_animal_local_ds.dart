import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/especie_animal.dart';

abstract class EspecieAnimalLocalDataSource {
  Future<List<EspecieAnimalModel>> getEspeciesAnimales();
  Future<int> saveEspecieAnimal(EspecieAnimalModel especieAnimal);
  Future<int> saveUbicacionEspecieAnimalesCria(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria);
  Future<List<LstAnimalCria>> getAsp1EspeciesAnimales(int? ubicacionId);
}

class EspecieAnimalLocalDataSourceImpl implements EspecieAnimalLocalDataSource {
  @override
  Future<List<EspecieAnimalModel>> getEspeciesAnimales() async {
    try {
      final res = await supabase
          .from('especieanimalescria_aspectossocioeconomicos')
          .select();
      final result = List<EspecieAnimalModel>.from(
          res.map((m) => EspecieAnimalModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEspecieAnimal(EspecieAnimalModel especieAnimal) async {
    try {
      await supabase
          .from('especieanimalescria_aspectossocioeconomicos')
          .upsert(especieAnimal.toJson());

      return especieAnimal.especieAnimalCriaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionEspecieAnimalesCria(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicacionespecieanimalescria')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionEspeciesAnimalesCria = lstAnimalCria
          .map((item) => {
                'EspecieAnimalCria_id': item.especieAnimalCriaId,
                'Ubicacion_id': ubicacionId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp1_ubicacionespecieanimalescria')
          .upsert(ubicacionEspeciesAnimalesCria);

      // Return the number of rows inserted
      return ubicacionEspeciesAnimalesCria.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure(['Error saving animal breeding species']);
    }
  }

  @override
  Future<List<LstAnimalCria>> getAsp1EspeciesAnimales(int? ubicacionId) async {
    try {
      final res = await supabase
          .from('asp1_ubicacionespecieanimalescria')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result =
          List<LstAnimalCria>.from(res.map((m) => LstAnimalCria.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
