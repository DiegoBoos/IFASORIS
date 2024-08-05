import '../../../core/constants.dart';
import '../../models/estadistica.dart';
import '../../models/familia.dart';
import '../../models/ficha.dart';
import '../../models/grupo_familiar.dart';

abstract class FichaLocalDataSource {
  Future<FichaModel> createFicha(FichaModel ficha);
  Future<FichaModel> createFichaCompleta(FichaModel ficha);
  Future<List<FichaModel>> loadFichas(int familiaId);
  Future<List<EstadisticaModel>> loadEstadisticas();
  Future<int> deleteFicha(int fichaId);
  Future<List<FichaModel>> loadFichasSincronizadas();
}

class FichaLocalDataSourceImpl implements FichaLocalDataSource {
  @override
  Future<FichaModel> createFicha(FichaModel ficha) async {
    final res = await supabase.from('Ficha').insert(ficha.toJsonLocal());

    ficha.copyWith(fichaId: res);

    return ficha;
  }

  @override
  Future<List<FichaModel>> loadFichas(int familiaId) async {
    final res = await db.rawQuery('''
      SELECT Ficha.* FROM Familia 
      LEFT JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Familia.Familia_id = $familiaId
      ''');
    final result =
        List<FichaModel>.from(res.map((m) => FichaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<List<EstadisticaModel>> loadEstadisticas() async {
    final resFichasReportadas = await db.rawQuery('''
      SELECT  'FichasReportadas' as Estadistica,  count(*) as Cantidad FROM Ficha
      WHERE NumFicha <> '' or Ficha_id_remote IS NOT NULL
      UNION ALL 
      SELECT  'FichasRegistradas' as Estadistica, count(*)  as Cantidad FROM Ficha
        WHERE NumFicha = '' AND Ficha_id_remote IS NULL
      UNION ALL
      SELECT  'FichasRegistradasIncompletas' as Estadistica,  count(*) as Cantidad FROM Ficha
      inner join Familia ON (Familia.Ficha_id  =  Ficha.Ficha_id)
      left join Asp3_GrupoFamiliar on (Familia.Familia_id = Asp3_GrupoFamiliar.Familia_id)
      WHERE (Asp3_GrupoFamiliar.isComplete=0 OR Asp3_GrupoFamiliar.isComplete IS NULL) AND NumFicha = '' AND Ficha_id_remote IS NULL
    	UNION ALL
      SELECT  'FichasRegistradasCompletas' as Estadistica,  count(*) as Cantidad
      FROM Ficha 
	    WHERE NumFicha = '' AND Ficha.Ficha_id Not In(
	    SELECT FichasIncompletas.Ficha_id FROM Ficha as FichasIncompletas
      inner join Familia ON (Familia.Ficha_id  =  FichasIncompletas.Ficha_id)
      left join Asp3_GrupoFamiliar on (Familia.Familia_id = Asp3_GrupoFamiliar.Familia_id)
      WHERE (Asp3_GrupoFamiliar.isComplete=0 OR Asp3_GrupoFamiliar.isComplete IS NULL) AND NumFicha = '' AND Ficha_id_remote IS NULL)
     	UNION ALL 
    	SELECT  'AfiliadosReportados' as Estadistica,  count(*) as Cantidad FROM Asp3_GrupoFamiliar
    	inner join Familia ON (Familia.Familia_id  =  Asp3_GrupoFamiliar.Familia_id)
    	inner join Ficha on Ficha.Ficha_id=Familia.Ficha_id
      WHERE NumFicha <> '' or Ficha_id_remote IS NOT NULL
    	UNION ALL 
    	SELECT  'AfiliadosRegistrados' as Estadistica,  count(*) as Cantidad FROM Asp3_GrupoFamiliar
    	inner join Familia ON (Familia.Familia_id  =  Asp3_GrupoFamiliar.Familia_id)
    	inner join Ficha on Ficha.Ficha_id=Familia.Ficha_id
          WHERE NumFicha = '' AND Ficha_id_remote IS NULL
      ''');
    final result = List<EstadisticaModel>.from(
        resFichasReportadas.map((m) => EstadisticaModel.fromJson(m))).toList();
    return result;
  }

  @override
  Future<int> deleteFicha(int fichaId) async {
    final res = await supabase.from('Ficha').delete().eq('Ficha_id', fichaId);
    return res;
  }

  @override
  Future<List<FichaModel>> loadFichasSincronizadas() async {
    final res =
        await supabase.from('Ficha').select('Ficha.*, Familia.*').rawQuery('''
      SELECT Ficha.*, Familia.* FROM Ficha 
      INNER JOIN Familia ON (Familia.Ficha_id  =  Ficha.Ficha_id)
      WHERE NumFicha <> '' or Ficha_id_remote IS NOT NULL
    ''');

    final result = List<FichaModel>.from(res.map((ficha) {
      final familia = FamiliaModel.fromJson(ficha);

      final fichaConFamilia = {...ficha, 'familia': familia.toJson()};
      return FichaModel.fromJson(fichaConFamilia);
    }).toList());

    return result;
  }

  @override
  Future<FichaModel> createFichaCompleta(FichaModel ficha) async {
    // Ficha
    ficha.copyWith(fichaIdRemote: ficha.fichaId);
    ficha.copyWith(fichaId: null);

    // Familia
    final familia = ficha.familia;
    familia?.copyWith(familiaId: null);

    // GrupoFamiliar
    final grupoFamiliar = ficha.familia!.grupoFamiliar;

    await db.transaction((txn) async {
      // Ficha
      final newFichaId = await txn.insert('Ficha', ficha.toJsonLocal());

      // Familia
      familia?.copyWith(fichaId: newFichaId);
      final newFamilia = await txn.insert('Familia', familia!.toJson());

      // grupoFamiliar
      List<GrupoFamiliarModel> grupoFamiliarDat =
          grupoFamiliar!.map((integrante) {
        return GrupoFamiliarModel(
          familiaId: newFamilia,
          afiliadoId: integrante.afiliadoId,
          tipoDocumentoId: integrante.tipoDocumentoId,
          documento: integrante.documento,
          generoId: integrante.generoId,
          fechaNacimiento: integrante.fechaNacimiento,
          edad: integrante.edad,
          nombre1: integrante.nombre1,
          nombre2: integrante.nombre2,
          apellido1: integrante.apellido1,
          apellido2: integrante.apellido2,
          tipoDocAfiliado: integrante.tipoDocAfiliado,
          codGeneroAfiliado: integrante.codGeneroAfiliado,
          codRegimenAfiliado: integrante.codRegimenAfiliado,
          tipoRegimenId: integrante.tipoRegimenId,
          parentescoId: integrante.parentescoId,
          etniaId: integrante.etniaId,
          cursoVidaId: integrante.cursoVidaId,
          nivelEducativoId: integrante.nivelEducativoId,
          ocupacionId: integrante.ocupacionId,
          grupoRiesgoId: integrante.grupoRiesgoId,
          origenEtnico5602Id: integrante.origenEtnico5602Id,
          puebloIndigenaId: integrante.puebloIndigenaId,
          lenguaManejaId: integrante.lenguaManejaId,
          lenguaMaternaId: integrante.lenguaMaternaId,
        );
      }).toList();
      for (var e in grupoFamiliarDat) {
        await txn.insert('Asp3_GrupoFamiliar', e.toJson());
      }
    });

    return ficha;
  }
}
