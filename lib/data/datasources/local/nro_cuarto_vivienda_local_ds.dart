import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/nro_cuarto_vivienda.dart';

abstract class NroCuartoViviendaLocalDataSource {
  Future<List<NroCuartoViviendaModel>> getNroCuartosVivienda();
  Future<int> saveNroCuartoVivienda(NroCuartoViviendaModel nroCuartoVivienda);
}

class NroCuartoViviendaLocalDataSourceImpl
    implements NroCuartoViviendaLocalDataSource {
  @override
  Future<List<NroCuartoViviendaModel>> getNroCuartosVivienda() async {
    try {
      final res =
          await supabase.from('nrocuartosvivienda_datosvivienda').select();
      final result = List<NroCuartoViviendaModel>.from(
          res.map((m) => NroCuartoViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveNroCuartoVivienda(
      NroCuartoViviendaModel nroCuartoVivienda) async {
    try {
      await supabase
          .from('nrocuartosvivienda_datosvivienda')
          .upsert(nroCuartoVivienda.toJson());

      return nroCuartoVivienda.nroCuartoViviendaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
