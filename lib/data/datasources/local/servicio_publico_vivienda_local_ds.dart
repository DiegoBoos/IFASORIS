import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/servicio_publico_vivienda.dart';

abstract class ServicioPublicoViviendaLocalDataSource {
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicos();
  Future<int> saveServicioPublicoVivienda(
      ServicioPublicoViviendaModel servicioPublicoVivienda);
  Future<List<LstServPublico>> getServiciosPublicosVivienda(
      int? datoViviendaId);
  Future<int> saveServiciosPublicosVivienda(
      int datoViviendaId, List<LstServPublico> lstServPublico);
}

class ServicioPublicoViviendaLocalDataSourceImpl
    implements ServicioPublicoViviendaLocalDataSource {
  @override
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicos() async {
    try {
      final res = await supabase
          .from('serviciospublicosvivienda_datosvivienda')
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
      await supabase
          .from('serviciospublicosvivienda_datosvivienda')
          .upsert(servicioPublicoVivienda.toJson());

      return servicioPublicoVivienda.servicioPublicoViviendaId!;
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
          .from('asp2_datosviviendaserviciospublicos')
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

  @override
  Future<int> saveServiciosPublicosVivienda(
      int datoViviendaId, List<LstServPublico> lstServPublico) async {
    try {
      // First, delete existing records for the given datoViviendaId
      await supabase
          .from('asp2_datosviviendaserviciospublicos')
          .delete()
          .eq('DatoVivienda_id', datoViviendaId);

      // Prepare the list of records to be inserted
      final viviendaServiciosPublicos = lstServPublico
          .map((item) => {
                'ServicioPublicoVivienda_id': item.servicioPublicoViviendaId,
                'DatoVivienda_id': datoViviendaId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp2_datosviviendaserviciospublicos')
          .upsert(viviendaServiciosPublicos);

      // Return the number of rows inserted
      return viviendaServiciosPublicos.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
