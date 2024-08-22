import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/enfermedad_tratamiento.dart';

abstract class EnfermedadTratamientoLocalDataSource {
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento();
  Future<int> saveEnfermedadTratamiento(
      EnfermedadTratamientoModel enfermedadTratamiento);
}

class EnfermedadTratamientoLocalDataSourceImpl
    implements EnfermedadTratamientoLocalDataSource {
  @override
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento() async {
    try {
      final res = await supabase
          .from('enfermedadestratamientos_atencionsalud')
          .select();
      final result = List<EnfermedadTratamientoModel>.from(
          res.map((m) => EnfermedadTratamientoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEnfermedadTratamiento(
      EnfermedadTratamientoModel enfermedadTratamiento) async {
    try {
      await supabase
          .from('enfermedadestratamientos_atencionsalud')
          .upsert(enfermedadTratamiento.toJson());

      return enfermedadTratamiento.enfermedadTratamientoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
