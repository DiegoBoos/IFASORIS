

import '../../models/lugar_atencion_medico.dart';

abstract class LugarAtencionMedicoLocalDataSource {
  Future<List<LugarAtencionMedicoModel>> getLugaresAtencionMedico();
  Future<int> saveLugarAtencionMedico(
      LugarAtencionMedicoModel lugarAtencionMedico);

  Future<List<LstLugarAtencionMedico>> getLugaresAtencionMedicoAtencionSalud(
      int? atencionSaludId);

  Future<int> saveLugaresAtencionMedicoAtencionSalud(
      int atencionSaludId, List<LstLugarAtencionMedico> lstLugarAtencionMedico);
}

class LugarAtencionMedicoLocalDataSourceImpl
    implements LugarAtencionMedicoLocalDataSource {
  @override
  Future<List<LugarAtencionMedicoModel>> getLugaresAtencionMedico() async {
    final res = await supabase.from(.select()'LugaresAtencionMedico_AtencionSalud');
    final result = List<LugarAtencionMedicoModel>.from(
        res.map((m) => LugarAtencionMedicoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLugarAtencionMedico(
      LugarAtencionMedicoModel lugarAtencionMedico) async {
    final res = await supabase.from(.insert(
        'LugaresAtencionMedico_AtencionSalud', lugarAtencionMedico.toJson());

    return res;
  }

  @override
  Future<List<LstLugarAtencionMedico>> getLugaresAtencionMedicoAtencionSalud(
      int? atencionSaludId) async {
    final res = await supabase.from(.select()'Asp7_LugaresAtencionAtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);
    final result = List<LstLugarAtencionMedico>.from(
        res.map((m) => LstLugarAtencionMedico.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLugaresAtencionMedicoAtencionSalud(int atencionSaludId,
      List<LstLugarAtencionMedico> lstLugarAtencionMedico) async {
    Batch batch = db.batch();
    batch.delete('Asp7_LugaresAtencionAtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);

    final lugaresAtencionMedicoAtencionSalud = lstLugarAtencionMedico
        .map((item) => LugarAtencionMedicoAtencionSalud(
            lugarAtencionMedicoId: item.lugarAtencionMedicoId,
            atencionSaludId: atencionSaludId))
        .toList();

    for (final lugarAtencionMedicoAtencionSalud
        in lugaresAtencionMedicoAtencionSalud) {
      batch.insert('Asp7_LugaresAtencionAtencionSalud',
          lugarAtencionMedicoAtencionSalud.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
