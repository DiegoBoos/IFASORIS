import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
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
    final db = await ConnectionSQLiteService.db;
    final res = await db
        .query('EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas');
    final result = List<EventoCostumbreParticipaModel>.from(
        res.map((m) => EventoCostumbreParticipaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEventoCostumbreParticipa(
      EventoCostumbreParticipaModel eventoCostumbreParticipa) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas',
        eventoCostumbreParticipa.toJson());

    return res;
  }

  @override
  Future<int> saveAsp6EventosCostumbresParticipa(
      int? dimensionSocioCulturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp6_DimSocioCulturalEventosCostumbresParticipo',
        where: 'DimSocioCulturalPueblosIndigenas_id = ?',
        whereArgs: [dimensionSocioCulturalPueblosIndigenasId]);

    final ubicacionEspeciesAnimalesCria = lstEventoCostumbreParticipa
        .map((item) => Asp6EventoCostumbreParticipa(
            eventoCostumbreParticipaId: item.eventoCostumbreParticipaId,
            dimSocioCulturalPueblosIndigenasId:
                dimensionSocioCulturalPueblosIndigenasId))
        .toList();

    for (final ubicacionEspecieAnimalCria in ubicacionEspeciesAnimalesCria) {
      batch.insert('Asp6_DimSocioCulturalEventosCostumbresParticipo',
          ubicacionEspecieAnimalCria.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstEventoCostumbreParticipa>> getAsp6EventosCostumbresParticipa(
      int? dimensionSocioCulturalPueblosIndigenasId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query(
        'Asp6_DimSocioCulturalEventosCostumbresParticipo',
        where: 'DimSocioCulturalPueblosIndigenas_id = ?',
        whereArgs: [dimensionSocioCulturalPueblosIndigenasId]);
    final result = List<LstEventoCostumbreParticipa>.from(
        res.map((m) => LstEventoCostumbreParticipa.fromJson(m))).toList();

    return result;
  }
}
