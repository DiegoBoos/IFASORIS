import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/iluminacion_vivienda.dart';

abstract class IluminacionViviendaLocalDataSource {
  Future<List<IluminacionViviendaModel>> getIluminacionesVivienda();
  Future<int> saveIluminacionVivienda(
      IluminacionViviendaModel iluminacionVivienda);
}

class IluminacionViviendaLocalDataSourceImpl
    implements IluminacionViviendaLocalDataSource {
  @override
  Future<List<IluminacionViviendaModel>> getIluminacionesVivienda() async {
    try {
      final res =
          await supabase.from('iluminacionvivienda_datosvivienda').select();
      final result = List<IluminacionViviendaModel>.from(
          res.map((m) => IluminacionViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveIluminacionVivienda(
      IluminacionViviendaModel iluminacionVivienda) async {
    try {
      await supabase
          .from('iluminacionvivienda_datosvivienda')
          .upsert(iluminacionVivienda.toJson());

      return iluminacionVivienda.iluminacionViviendaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
