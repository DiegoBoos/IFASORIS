import '../../../core/constants.dart';
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
    final res =
        await supabase.from('EnfermedadesTradicionales_AtencionSalud').select();
    final result = List<EnfermedadTradicionalModel>.from(
        res.map((m) => EnfermedadTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEnfermedadTradicional(
      EnfermedadTradicionalModel enfermedadTradicional) async {
    final res = await supabase
        .from('EnfermedadesTradicionales_AtencionSalud')
        .insert(enfermedadTradicional.toJson());

    return res;
  }

  @override
  Future<List<LstEnfermedadTradicional>>
      getEnfermedadesTradicionalesAtencionSalud(int? atencionSaludId) async {
    final res = await supabase
        .from('Asp7_EnfermedadesTradicionales_AtencionSalud')
        .select()
        .eq('AtencionSalud_id', atencionSaludId);
    final result = List<LstEnfermedadTradicional>.from(
        res.map((m) => LstEnfermedadTradicional.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEnfermedadesTradicionalesAtencionSalud(int atencionSaludId,
      List<LstEnfermedadTradicional> lstEnfermedadTradicional) async {
    Batch batch = db.batch();
    batch.delete('Asp7_EnfermedadesTradicionales_AtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);

    final enfermedadesTradicionalesAtencionSalud = lstEnfermedadTradicional
        .map((item) => EnfermedadTradicionalAtencionSalud(
            enfermedadTradicionalId: item.enfermedadTradicionalId,
            atencionSaludId: atencionSaludId))
        .toList();

    for (final enfermedadTradicionalAtencionSalud
        in enfermedadesTradicionalesAtencionSalud) {
      batch.insert('Asp7_EnfermedadesTradicionales_AtencionSalud',
          enfermedadTradicionalAtencionSalud.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
