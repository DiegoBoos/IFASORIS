import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/lugar_planta_medicinal.dart';

abstract class LugarPlantaMedicinalLocalDataSource {
  Future<List<LugarPlantaMedicinalModel>> getLugaresPlantasMedicinales();
  Future<int> saveLugarPlantaMedicinal(
      LugarPlantaMedicinalModel lugarPlantaMedicinal);
}

class LugarPlantaMedicinalLocalDataSourceImpl
    implements LugarPlantaMedicinalLocalDataSource {
  @override
  Future<List<LugarPlantaMedicinalModel>> getLugaresPlantasMedicinales() async {
    try {
      final res = await supabase
          .from('lugaresplantasmedicinales_atencionsalud')
          .select();
      final result = List<LugarPlantaMedicinalModel>.from(
          res.map((m) => LugarPlantaMedicinalModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveLugarPlantaMedicinal(
      LugarPlantaMedicinalModel lugarPlantaMedicinal) async {
    try {
      await supabase
          .from('lugaresplantasmedicinales_atencionsalud')
          .upsert(lugarPlantaMedicinal.toJson());

      return lugarPlantaMedicinal.lugarPlantaMedicinalId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
