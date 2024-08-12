import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/planta_medicinal.dart';

abstract class PlantaMedicinalLocalDataSource {
  Future<List<PlantaMedicinalModel>> getPlantasMedicinales();
  Future<int> savePlantaMedicinal(PlantaMedicinalModel plantaMedicinal);
  Future<List<LstPlantaMedicinal>> getPlantasMedicinalesAtencionSalud(
      int? atencionSaludId);

  Future<int> savePlantasMedicinalesAtencionSalud(
      int atencionSaludId, List<LstPlantaMedicinal> lstPlantaMedicinal);
}

class PlantaMedicinalLocalDataSourceImpl
    implements PlantaMedicinalLocalDataSource {
  @override
  Future<List<PlantaMedicinalModel>> getPlantasMedicinales() async {
    try {
      final res =
          await supabase.from('PlantasMedicinales_AtencionSalud').select();
      final result = List<PlantaMedicinalModel>.from(
          res.map((m) => PlantaMedicinalModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> savePlantaMedicinal(PlantaMedicinalModel plantaMedicinal) async {
    try {
      final res = await supabase
          .from('PlantasMedicinales_AtencionSalud')
          .insert(plantaMedicinal.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstPlantaMedicinal>> getPlantasMedicinalesAtencionSalud(
      int? atencionSaludId) async {
    try {
      final res = await supabase
          .from('Asp7_PlantasMedicinales_AtencionSalud')
          .select()
          .eq('AtencionSalud_id', atencionSaludId);
      final result = List<LstPlantaMedicinal>.from(
          res.map((m) => LstPlantaMedicinal.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> savePlantasMedicinalesAtencionSalud(
      int atencionSaludId, List<LstPlantaMedicinal> lstPlantaMedicinal) async {
    try {
      // First, delete existing records for the given atencionSaludId
      await supabase
          .from('Asp7_PlantasMedicinales_AtencionSalud')
          .delete()
          .eq('AtencionSalud_id', atencionSaludId);

      // Prepare the list of records to be inserted
      final plantasMedicinalesAtencionSalud = lstPlantaMedicinal
          .map((item) => {
                'plantaMedicinalId': item.plantaMedicinalId,
                'atencionSaludId': atencionSaludId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp7_PlantasMedicinales_AtencionSalud')
          .insert(plantasMedicinalesAtencionSalud);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
