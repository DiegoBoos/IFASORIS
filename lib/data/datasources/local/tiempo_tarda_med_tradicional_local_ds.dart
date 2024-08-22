import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tiempo_tarda_med_tradicional.dart';

abstract class TiempoTardaMedTradicionalLocalDataSource {
  Future<List<TiempoTardaMedTradicionalModel>> getTiemposTardaMedTradicional();
  Future<int> saveTiempoTardaMedTradicional(
      TiempoTardaMedTradicionalModel tiempoTardaMedTradicional);
}

class TiempoTardaMedTradicionalLocalDataSourceImpl
    implements TiempoTardaMedTradicionalLocalDataSource {
  @override
  Future<List<TiempoTardaMedTradicionalModel>>
      getTiemposTardaMedTradicional() async {
    try {
      final res =
          await supabase.from('tiempostarda_accesomedtradicional').select();
      final result = List<TiempoTardaMedTradicionalModel>.from(
          res.map((m) => TiempoTardaMedTradicionalModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTiempoTardaMedTradicional(
      TiempoTardaMedTradicionalModel tiempoTardaMedTradicional) async {
    try {
      await supabase
          .from('tiempostarda_accesomedtradicional')
          .upsert(tiempoTardaMedTradicional.toJson());

      return tiempoTardaMedTradicional.tiempoTardaMedTradId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
