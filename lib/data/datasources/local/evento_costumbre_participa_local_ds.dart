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
          .from('eventoscostumbresparticipo_dimsocioculturalpueblosindigenas')
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
      await supabase
          .from('eventoscostumbresparticipo_dimsocioculturalpueblosindigenas')
          .upsert(eventoCostumbreParticipa.toJson());

      return eventoCostumbreParticipa.eventoCostumbreParticipaId!;
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
          .from('asp6_dimsocioculturaleventoscostumbresparticipo')
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

  @override
  Future<int> saveAsp6EventosCostumbresParticipa(
      int? dimensionSocioCulturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa) async {
    try {
      // First, delete existing records for the given dimensionSocioCulturalPueblosIndigenasId
      await supabase
          .from('asp6_dimsocioculturaleventoscostumbresparticipo')
          .delete()
          .eq('DimSocioCulturalPueblosIndigenas_id',
              dimensionSocioCulturalPueblosIndigenasId);

      // Prepare the list of records to be inserted
      final eventosCostumbresParticipa = lstEventoCostumbreParticipa
          .map((item) => {
                'EventoCostumbreParticipo_id': item.eventoCostumbreParticipaId,
                'DimSocioCulturalPueblosIndigenas_id':
                    dimensionSocioCulturalPueblosIndigenasId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp6_dimsocioculturaleventoscostumbresparticipo')
          .upsert(eventosCostumbresParticipa);

      // Return the number of rows inserted
      return eventosCostumbresParticipa.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
