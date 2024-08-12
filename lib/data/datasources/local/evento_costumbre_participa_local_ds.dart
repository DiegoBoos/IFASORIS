import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/evento_costumbre_participa.dart';

abstract class EventoCostumbreParticipaLocalDataSource {
  Future<List<EventoCostumbreParticipaModel>> getEventosCostumbresParticipa();
  Future<int> saveEventoCostumbreParticipa(
      EventoCostumbreParticipaModel eventoCostumbreParticipa);

  Future<List<LstEventoCostumbreParticipa>> getAsp6EventosCostumbresParticipa(
      int? dimensionSocioCulturalPueblosIndigenasId);

  Future<int> saveAsp6EventosCostumbresParticipa(
      int? dimensionSocioCulturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa);
}

class EventoCostumbreParticipaLocalDataSourceImpl
    implements EventoCostumbreParticipaLocalDataSource {
  @override
  Future<List<EventoCostumbreParticipaModel>>
      getEventosCostumbresParticipa() async {
    try {
      final res = await supabase
          .from('EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas')
          .select();
      final result = List<EventoCostumbreParticipaModel>.from(
          res.map((m) => EventoCostumbreParticipaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEventoCostumbreParticipa(
      EventoCostumbreParticipaModel eventoCostumbreParticipa) async {
    try {
      final res = await supabase
          .from('EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas')
          .insert(eventoCostumbreParticipa.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveAsp6EventosCostumbresParticipa(
      int? dimensionSocioCulturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa) async {
    try {
      // First, delete existing records for the given dimensionSocioCulturalPueblosIndigenasId
      await supabase
          .from('Asp6_DimSocioCulturalEventosCostumbresParticipo')
          .delete()
          .eq('DimSocioCulturalPueblosIndigenas_id',
              dimensionSocioCulturalPueblosIndigenasId);

      // Prepare the list of records to be inserted
      final eventosCostumbresParticipa = lstEventoCostumbreParticipa
          .map((item) => {
                'eventoCostumbreParticipaId': item.eventoCostumbreParticipaId,
                'dimSocioCulturalPueblosIndigenasId':
                    dimensionSocioCulturalPueblosIndigenasId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp6_DimSocioCulturalEventosCostumbresParticipo')
          .insert(eventosCostumbresParticipa);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstEventoCostumbreParticipa>> getAsp6EventosCostumbresParticipa(
      int? dimensionSocioCulturalPueblosIndigenasId) async {
    try {
      final res = await supabase
          .from('Asp6_DimSocioCulturalEventosCostumbresParticipo')
          .select()
          .eq('DimSocioCulturalPueblosIndigenas_id',
              dimensionSocioCulturalPueblosIndigenasId);

      final result = List<LstEventoCostumbreParticipa>.from(
          res.map((m) => LstEventoCostumbreParticipa.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
