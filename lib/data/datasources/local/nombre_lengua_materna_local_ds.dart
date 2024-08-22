import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/nombre_lengua_materna.dart';

abstract class NombreLenguaMaternaLocalDataSource {
  Future<List<NombreLenguaMaternaModel>> getNombresLenguasMaterna();
  Future<int> saveNombreLenguaMaterna(
      NombreLenguaMaternaModel nombreLenguaMaterna);
}

class NombreLenguaMaternaLocalDataSourceImpl
    implements NombreLenguaMaternaLocalDataSource {
  @override
  Future<List<NombreLenguaMaternaModel>> getNombresLenguasMaterna() async {
    try {
      final res =
          await supabase.from('nombrelenguamaterna_grupofamiliar').select();
      final result = List<NombreLenguaMaternaModel>.from(
          res.map((m) => NombreLenguaMaternaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveNombreLenguaMaterna(
      NombreLenguaMaternaModel nombreLenguaMaterna) async {
    try {
      await supabase
          .from('nombrelenguamaterna_grupofamiliar')
          .upsert(nombreLenguaMaterna.toJson());

      return nombreLenguaMaterna.lenguaMaternaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
