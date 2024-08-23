import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/enfermedad_tradicional.dart';

abstract class EnfermedadTradicionalLocalDataSource {
  Future<List<EnfermedadTradicionalModel>> getEnfermedadesTradicionales();
  Future<int> saveEnfermedadTradicional(
      EnfermedadTradicionalModel enfermedadTradicional);
  Future<List<LstEnfermedadTradicional>>
      getEnfermedadesTradicionalesAtencionSalud(int? atencionSaludId);
  Future<int> saveEnfermedadesTradicionalesAtencionSalud(int atencionSaludId,
      List<LstEnfermedadTradicional> lstEnfermedadTradicional);
}

class EnfermedadTradicionalLocalDataSourceImpl
    implements EnfermedadTradicionalLocalDataSource {
  @override
  Future<List<EnfermedadTradicionalModel>>
      getEnfermedadesTradicionales() async {
    try {
      final res = await supabase
          .from('enfermedadestradicionales_atencionsalud')
          .select();
      final result = List<EnfermedadTradicionalModel>.from(
          res.map((m) => EnfermedadTradicionalModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEnfermedadTradicional(
      EnfermedadTradicionalModel enfermedadTradicional) async {
    try {
      await supabase
          .from('enfermedadestradicionales_atencionsalud')
          .upsert(enfermedadTradicional.toJson());

      return enfermedadTradicional.enfermedadTradicionalId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstEnfermedadTradicional>>
      getEnfermedadesTradicionalesAtencionSalud(int? atencionSaludId) async {
    try {
      final res = await supabase
          .from('asp7_enfermedadestradicionales_atencionsalud')
          .select()
          .eq('AtencionSalud_id', atencionSaludId);
      final result = List<LstEnfermedadTradicional>.from(
          res.map((m) => LstEnfermedadTradicional.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEnfermedadesTradicionalesAtencionSalud(int atencionSaludId,
      List<LstEnfermedadTradicional> lstEnfermedadTradicional) async {
    try {
      // First, delete existing records for the given atencionSaludId
      await supabase
          .from('asp7_enfermedadestradicionales_atencionsalud')
          .delete()
          .eq('AtencionSalud_id', atencionSaludId);

      // Prepare the list of records to be inserted
      final enfermedadesTradicionalesAtencionSalud = lstEnfermedadTradicional
          .map((item) => {
                'EnfermedadTradicional_id': item.enfermedadTradicionalId,
                'AtencionSalud_id': atencionSaludId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp7_enfermedadestradicionales_atencionsalud')
          .upsert(enfermedadesTradicionalesAtencionSalud);

      // Return the number of rows inserted
      return enfermedadesTradicionalesAtencionSalud.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
