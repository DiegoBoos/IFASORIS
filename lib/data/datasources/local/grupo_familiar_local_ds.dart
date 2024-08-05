import '../../../core/constants.dart';
import '../../../core/error/failure.dart';

import '../../models/grupo_familiar.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<GrupoFamiliarModel> saveGrupoFamiliar(
      GrupoFamiliarModel afiliadoGrupoFamiliar);

  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId);

  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId);

  Future<int> completeGrupoFamiliar(int afiliadoId);

  Future<bool> existeAfiliadoCabezaFamilia(int afiliadoId);
}

class GrupoFamiliarLocalDataSourceImpl implements GrupoFamiliarLocalDataSource {
  @override
  Future<GrupoFamiliarModel> saveGrupoFamiliar(
      GrupoFamiliarModel afiliadoGrupoFamiliar) async {
    try {
      if (afiliadoGrupoFamiliar.grupoFamiliarId == null) {
        await supabase.from('Asp3_GrupoFamiliar').insert(
              afiliadoGrupoFamiliar.toJson(),
            );
      } else {
        await supabase
            .from('Asp3_GrupoFamiliar')
            .update(
              afiliadoGrupoFamiliar.toJson(),
            )
            .eq('Afiliado_id', afiliadoGrupoFamiliar.afiliadoId);
      }

      final consultarAfiliado = await supabase
          .from('Asp3_GrupoFamiliar')
          .select('Afiliado.nombre1, Afiliado.nombre2')
          .rawQuery('''SELECT 
              Afiliado.apellido1, Afiliado.apellido2, Asp3_GrupoFamiliar.* FROM 
              LEFT JOIN Afiliado ON Asp3_GrupoFamiliar.Afiliado_id = Afiliado.Afiliado_id
              WHERE Asp3_GrupoFamiliar.Afiliado_id = ${afiliadoGrupoFamiliar.afiliadoId}
              AND Asp3_GrupoFamiliar.Familia_id = ${afiliadoGrupoFamiliar.familiaId}''');

      if (consultarAfiliado.isNotEmpty) {
        return GrupoFamiliarModel.fromJson(consultarAfiliado.first);
      } else {
        throw const DatabaseFailure(['Registro no encontrado']);
      }
    } catch (e) {
      throw const DatabaseFailure(['Error al guardar el grupo familiar']);
    }
  }

  @override
  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId) async {
    final res = await supabase
        .from('Asp3_GrupoFamiliar')
        .select()
        .rawQuery('''SELECT * FROM  
           JOIN Afiliado ON Asp3_GrupoFamiliar.Afiliado_id = Afiliado.Afiliado_id
           WHERE Asp3_GrupoFamiliar.Familia_id = $familiaId''');

    final result = List<GrupoFamiliarModel>.from(
        res.map((m) => GrupoFamiliarModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId) async {
    final result = await supabase
        .from('Asp3_GrupoFamiliar')
        .delete()
        .eq('Afiliado_id,Familia_id', [afiliadoId, familiaId]);

    return result;
  }

  @override
  Future<int> completeGrupoFamiliar(int afiliado) async {
    final res = await supabase
        .from('Asp3_GrupoFamiliar')
        .update()
        .eq('Afiliado_id', afiliado)
        .eq('isComplete', 1);

    return res;
  }

  @override
  Future<bool> existeAfiliadoCabezaFamilia(int afiliadoId) async {
    final res = await supabase.from('Asp3_GrupoFamiliar').select().rawQuery('''
    SELECT EXISTS (
      SELECT 1 FROM Asp3_GrupoFamiliar 
      INNER JOIN Familia ON Asp3_GrupoFamiliar.Afiliado_id = Familia.FK_Afiliado_id
      WHERE Asp3_GrupoFamiliar.Afiliado_id = ?
    )
  ''', [afiliadoId]);

    if (res.isEmpty) return false;

    final result = res.first.values.first as int;

    return result == 1;
  }
}
