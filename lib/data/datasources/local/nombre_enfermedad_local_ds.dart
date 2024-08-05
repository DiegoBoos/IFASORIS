

import '../../models/nombre_enfermedad.dart';

abstract class NombreEnfermedadLocalDataSource {
  Future<List<NombreEnfermedadModel>> getNombresEnfermedades();
  Future<int> saveNombreEnfermedad(NombreEnfermedadModel nombreEnfermedad);

  Future<List<LstNombreEnfermedad>> getLstNombresEnfermedades(
      int? cuidadoSaludCondRiesgoId);

  Future<int> saveNombresEnfermedades(int cuidadoSaludCondRiesgoId,
      List<LstNombreEnfermedad> lstNombresEnfermedades);
}

class NombreEnfermedadLocalDataSourceImpl
    implements NombreEnfermedadLocalDataSource {
  @override
  Future<List<NombreEnfermedadModel>> getNombresEnfermedades() async {
    final res = await supabase.from(.select()'NombresEnfermedad_CuidadoSaludCondRiesgo');
    final result = List<NombreEnfermedadModel>.from(
        res.map((m) => NombreEnfermedadModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNombreEnfermedad(
      NombreEnfermedadModel nombreEnfermedad) async {
    final res = await supabase.from(.insert(
        'NombresEnfermedad_CuidadoSaludCondRiesgo', nombreEnfermedad.toJson());

    return res;
  }

  @override
  Future<List<LstNombreEnfermedad>> getLstNombresEnfermedades(
      int? cuidadoSaludCondRiesgoId) async {
    final res = await supabase.from(.select()'Asp5_CuidadoSaludCondRiesgoNombresEnfermedad',
        where: 'CuidadoSaludCondRiesgo_id = ?',
        whereArgs: [cuidadoSaludCondRiesgoId]);
    final result = List<LstNombreEnfermedad>.from(
        res.map((m) => LstNombreEnfermedad.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNombresEnfermedades(int cuidadoSaludCondRiesgoId,
      List<LstNombreEnfermedad> lstNombresEnfermedades) async {
    Batch batch = db.batch();
    batch.delete('Asp5_CuidadoSaludCondRiesgoNombresEnfermedad',
        where: 'CuidadoSaludCondRiesgo_id = ?',
        whereArgs: [cuidadoSaludCondRiesgoId]);

    final cuidadoSaludCondRiesgoNombresEnfermedades = lstNombresEnfermedades
        .map((item) => CuidadoSaludCondRiesgoNombreEnfermedad(
            nombreEnfermedadId: item.nombreEnfermedadId,
            cuidadoSaludCondRiesgoId: cuidadoSaludCondRiesgoId))
        .toList();

    for (final cuidadoSaludCondRiesgoNombreEnfermedad
        in cuidadoSaludCondRiesgoNombresEnfermedades) {
      batch.insert('Asp5_CuidadoSaludCondRiesgoNombresEnfermedad',
          cuidadoSaludCondRiesgoNombreEnfermedad.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
