import '../../../core/constants.dart';
import '../../models/especialidad_med_tradicional.dart';
import '../../models/nombre_med_tradicional.dart';

abstract class EspecialidadMedTradicionalLocalDataSource {
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicional();
  Future<int> saveEspecialidadMedTradicional(
      EspecialidadMedTradicionalModel especialidadMedTradicional);

  Future<int> saveUbicacionEspecialidadMedTradicional(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional);

  Future<int> saveUbicacionNombresMedTradicional(
      int ubicacionId, List<LstNombreMedTradicional> lstNombreMedTradicional);

  Future<List<LstEspMedTradicional>> getUbicacionEspecialidadesMedTradicional(
      int? ubicacionId);
  Future<List<LstNombreMedTradicional>> getUbicacionNombresMedTradicional(
      int? ubicacionId);

  Future<List<LstEspMedTradicional>>
      getEspecialidadesMedTradicionalAtencionSalud(int? atencionSaludId);

  Future<int> saveEspecialidadesMedTradicionalAtencionSalud(
      int atencionSaludId, List<LstEspMedTradicional> lstEspMedTradicional);
}

class EspecialidadMedTradicionalLocalDataSourceImpl
    implements EspecialidadMedTradicionalLocalDataSource {
  @override
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicional() async {
    final res = await supabase
        .from('EspecialidadesMedTrad_AccesoMedTradicional')
        .select();
    final result = List<EspecialidadMedTradicionalModel>.from(
        res.map((m) => EspecialidadMedTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEspecialidadMedTradicional(
      EspecialidadMedTradicionalModel especialidadMedTradicional) async {
    final res = await supabase
        .from('EspecialidadesMedTrad_AccesoMedTradicional')
        .insert(especialidadMedTradicional.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionEspecialidadMedTradicional(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionEspecialidadMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionEspecialidadesMedTradicional = lstEspMedTradicional
        .map((item) => UbicacionEspecialidadMedTradicional(
            especialidadMedTradicionalId: item.especialidadMedTradId,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionEspecialidadMedTradicional
        in ubicacionEspecialidadesMedTradicional) {
      batch.insert('Asp1_UbicacionEspecialidadMedTradicional',
          ubicacionEspecialidadMedTradicional.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveUbicacionNombresMedTradicional(int ubicacionId,
      List<LstNombreMedTradicional> lstNombreMedTradicional) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionNombresMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionNombresMedTradicional = lstNombreMedTradicional
        .map((item) => UbicacionNombresMedTradicional(
            nombreMedTradicional: item.nombreMedTradicional,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionNombreMedTradicional
        in ubicacionNombresMedTradicional) {
      batch.insert('Asp1_UbicacionNombresMedTradicional',
          ubicacionNombreMedTradicional.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstNombreMedTradicional>> getUbicacionNombresMedTradicional(
      int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionNombresMedTradicional')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final result = List<LstNombreMedTradicional>.from(
        res.map((m) => LstNombreMedTradicional.fromJson(m))).toList();

    return result;
  }

  @override
  Future<List<LstEspMedTradicional>> getUbicacionEspecialidadesMedTradicional(
      int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionEspecialidadMedTradicional')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final result = List<LstEspMedTradicional>.from(
        res.map((m) => LstEspMedTradicional.fromJson(m))).toList();

    return result;
  }

  @override
  Future<List<LstEspMedTradicional>>
      getEspecialidadesMedTradicionalAtencionSalud(int? atencionSaludId) async {
    final res = await supabase
        .from('Asp7_EspecialidadesMedTradAtencionSalud')
        .select()
        .eq('AtencionSalud_id', atencionSaludId);
    final result = List<LstEspMedTradicional>.from(
        res.map((m) => LstEspMedTradicional.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEspecialidadesMedTradicionalAtencionSalud(int atencionSaludId,
      List<LstEspMedTradicional> lstEspMedTradicional) async {
    Batch batch = db.batch();
    batch.delete('Asp7_EspecialidadesMedTradAtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);

    final nombresMedTradicionalAtencionSalud = lstEspMedTradicional
        .map((item) => EspecialidadMedTradAtencionSalud(
            especialidadMedTradId: item.especialidadMedTradId,
            atencionSaludId: atencionSaludId))
        .toList();

    for (final nombreMedTradicionalAtencionSalud
        in nombresMedTradicionalAtencionSalud) {
      batch.insert('Asp7_EspecialidadesMedTradAtencionSalud',
          nombreMedTradicionalAtencionSalud.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
