import 'package:ifasoris/data/models/ficha_model.dart';

import '../../../domain/entities/ficha_entity.dart';
import '../../../services/connection_sqlite_service.dart';

abstract class FichaLocalDataSource {
  Future<FichaEntity> createFicha(FichaEntity ficha);
  Future<List<FichaModel>> loadFichas(int familiaId);

  Future<int> deleteFicha(int fichaId);

  Future<List<FichaModel>> loadFichasDiligenciadas(int familiaId);
}

class FichaLocalDataSourceImpl implements FichaLocalDataSource {
  @override
  Future<FichaEntity> createFicha(FichaEntity ficha) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Ficha', ficha.toJsonLocal());

    ficha.fichaId = res;

    return ficha;
  }

  @override
  Future<List<FichaModel>> loadFichas(int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''
      SELECT Ficha.Ficha_id, Ficha.FechaCreacion,Ficha.NumFicha,Ficha.UserName_Creacion,Ficha.UserName_Actualizacion, Ficha.UltimaActualizacion FROM Familia 
      LEFT JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Familia.Familia_id = $familiaId
      ''');
    final result =
        List<FichaModel>.from(res.map((m) => FichaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> deleteFicha(int fichaId) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.delete('Ficha', where: 'Ficha_id = ?', whereArgs: [fichaId]);

    return res;
  }

  @override
  Future<List<FichaModel>> loadFichasDiligenciadas(int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''
     SELECT Ficha.Ficha_id, Ficha.FechaCreacion,Ficha.NumFicha,Ficha.UserName_Creacion,Ficha.UserName_Actualizacion, Ficha.UltimaActualizacion FROM Ficha 
      LEFT JOIN Familia ON Familia.Ficha_id = Ficha.Ficha_id
      LEFT JOIN Asp1_Ubicacion ON Asp1_Ubicacion.Familia_id = Familia.Familia_id
      LEFT JOIN Asp2_DatosVivienda ON Asp2_DatosVivienda.Familia_id = Familia.Familia_id
      LEFT JOIN Asp3_GrupoFamiliar ON Asp3_GrupoFamiliar.Familia_id = Familia.Familia_id
      LEFT JOIN Asp4_EstilosVidaSaludable ON Asp4_EstilosVidaSaludable.Familia_id = Familia.Familia_id
      LEFT JOIN Asp5_CuidadoSaludCondRiesgo ON Asp5_CuidadoSaludCondRiesgo.Familia_id = Familia.Familia_id
      LEFT JOIN Asp6_DimSocioCulturalPueblosIndigenas ON Asp6_DimSocioCulturalPueblosIndigenas.Familia_id = Familia.Familia_id
      LEFT JOIN Asp7_AtencionSalud ON Asp7_AtencionSalud.Familia_id = Familia.Familia_id
      WHERE Ficha.Ficha_id = $familiaId
      ''');
    final result =
        List<FichaModel>.from(res.map((m) => FichaModel.fromJson(m))).toList();

    return result;
  }
}
