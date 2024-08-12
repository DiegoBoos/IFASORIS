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
          .from('EnfermedadesTradicionales_AtencionSalud')
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
      final res = await supabase
          .from('EnfermedadesTradicionales_AtencionSalud')
          .insert(enfermedadTradicional.toJson());

      return res;
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
          .from('Asp7_EnfermedadesTradicionales_AtencionSalud')
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
          .from('Asp7_EnfermedadesTradicionales_AtencionSalud')
          .delete()
          .eq('AtencionSalud_id', atencionSaludId);

      // Prepare the list of records to be inserted
      final enfermedadesTradicionalesAtencionSalud = lstEnfermedadTradicional
          .map((item) => {
                'enfermedadTradicionalId': item.enfermedadTradicionalId,
                'atencionSaludId': atencionSaludId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp7_EnfermedadesTradicionales_AtencionSalud')
          .insert(enfermedadesTradicionalesAtencionSalud);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
