import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/cuarto_vivienda.dart';

abstract class CuartoViviendaLocalDataSource {
  Future<List<CuartoViviendaModel>> getCuartosVivienda();
  Future<int> saveCuartoVivienda(CuartoViviendaModel cuartoVivienda);
}

class CuartoViviendaLocalDataSourceImpl
    implements CuartoViviendaLocalDataSource {
  @override
  Future<List<CuartoViviendaModel>> getCuartosVivienda() async {
    try {
      final res = await supabase.from('CuartosVivienda_DatosVivienda').select();
      final result = List<CuartoViviendaModel>.from(
          res.map((m) => CuartoViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveCuartoVivienda(CuartoViviendaModel cuartoVivienda) async {
    try {
      final res = await supabase
          .from('CuartosVivienda_DatosVivienda')
          .insert(cuartoVivienda.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
