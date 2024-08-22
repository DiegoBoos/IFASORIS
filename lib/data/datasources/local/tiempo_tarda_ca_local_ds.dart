import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tiempo_tarda_ca.dart';

abstract class TiempoTardaCALocalDataSource {
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA();
  Future<int> saveTiempoTardaCA(TiempoTardaCAModel tiempoTardaCA);
}

class TiempoTardaCALocalDataSourceImpl implements TiempoTardaCALocalDataSource {
  @override
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA() async {
    try {
      final res = await supabase.from('tiempostarda_centroatencion').select();
      final result = List<TiempoTardaCAModel>.from(
          res.map((m) => TiempoTardaCAModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTiempoTardaCA(TiempoTardaCAModel tiempoTardaCA) async {
    try {
      await supabase
          .from('tiempostarda_centroatencion')
          .upsert(tiempoTardaCA.toJson());

      return tiempoTardaCA.tiempoTardaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
