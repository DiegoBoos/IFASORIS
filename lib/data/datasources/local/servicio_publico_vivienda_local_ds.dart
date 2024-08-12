import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/servicio_publico_vivienda.dart';

abstract class ServicioPublicoViviendaLocalDataSource {
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicos();
  Future<int> saveServicioPublicoVivienda(
      ServicioPublicoViviendaModel servicioPublicoVivienda);

  Future<int> saveServiciosPublicosVivienda(
      int datoViviendaId, List<LstServPublico> lstServPublico);

  Future<List<LstServPublico>> getServiciosPublicosVivienda(
      int? datoViviendaId);
}

class ServicioPublicoViviendaLocalDataSourceImpl
    implements ServicioPublicoViviendaLocalDataSource {
  @override
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicos() async {
    try {
      final res = await supabase
          .from('ServiciosPublicosVivienda_DatosVivienda')
          .select();
      final result = List<ServicioPublicoViviendaModel>.from(
          res.map((m) => ServicioPublicoViviendaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveServicioPublicoVivienda(
      ServicioPublicoViviendaModel servicioPublicoVivienda) async {
    try {
      final res = await supabase
          .from('ServiciosPublicosVivienda_DatosVivienda')
          .insert(servicioPublicoVivienda.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveServiciosPublicosVivienda(
      int datoViviendaId, List<LstServPublico> lstServPublico) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('Asp2_DatosViviendaServiciosPublicos')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaServiciosPublicos = lstServPublico
          .map((item) => {
                'servicioPublicoViviendaId': item.servicioPublicoViviendaId,
                'datoViviendaId': datoViviendaId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp2_DatosViviendaServiciosPublicos')
          .insert(viviendaServiciosPublicos);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstServPublico>> getServiciosPublicosVivienda(
      int? datoViviendaId) async {
    try {
      final res = await supabase
          .from('Asp2_DatosViviendaServiciosPublicos')
          .select()
          .eq('DatoVivienda_id', datoViviendaId);
      final result =
          List<LstServPublico>.from(res.map((m) => LstServPublico.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
