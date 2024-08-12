import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/costo_desplazamiento.dart';

abstract class CostoDesplazamientoLocalDataSource {
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento();
  Future<int> saveCostoDesplazamiento(
      CostoDesplazamientoModel costoDesplazamiento);
}

class CostoDesplazamientoLocalDataSourceImpl
    implements CostoDesplazamientoLocalDataSource {
  @override
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento() async {
    try {
      final res =
          await supabase.from('CostosDesplazamiento_CentroAtencion').select();
      final result = List<CostoDesplazamientoModel>.from(
          res.map((m) => CostoDesplazamientoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveCostoDesplazamiento(
      CostoDesplazamientoModel costoDesplazamiento) async {
    try {
      final res = await supabase
          .from('CostosDesplazamiento_CentroAtencion')
          .insert(costoDesplazamiento.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
