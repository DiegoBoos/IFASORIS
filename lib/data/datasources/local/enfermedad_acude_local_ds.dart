import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/enfermedad_acude.dart';

abstract class EnfermedadAcudeLocalDataSource {
  Future<List<EnfermedadAcudeModel>> getEnfermedadesAcude();
  Future<int> saveEnfermedadAcude(EnfermedadAcudeModel enfermedadAcude);
}

class EnfermedadAcudeLocalDataSourceImpl
    implements EnfermedadAcudeLocalDataSource {
  @override
  Future<List<EnfermedadAcudeModel>> getEnfermedadesAcude() async {
    try {
      final res =
          await supabase.from('enfermedadesacude_atencionsalud').select();
      final result = List<EnfermedadAcudeModel>.from(
          res.map((m) => EnfermedadAcudeModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEnfermedadAcude(EnfermedadAcudeModel enfermedadAcude) async {
    try {
      await supabase
          .from('enfermedadesacude_atencionsalud')
          .upsert(enfermedadAcude.toJson());

      return enfermedadAcude.enfermedadAcudeId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
