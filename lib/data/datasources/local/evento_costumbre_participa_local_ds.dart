import '../../../core/constants.dart';
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
    final res = await supabase
        .from('EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas')
        .select();
    final result = List<EventoCostumbreParticipaModel>.from(
        res.map((m) => EventoCostumbreParticipaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEventoCostumbreParticipa(
      EventoCostumbreParticipaModel eventoCostumbreParticipa) async {
    final res = await supabase
        .from('EventosCostumbresParticipo_DimSocioCulturalPueblosIndigenas')
        .insert(eventoCostumbreParticipa.toJson());

    return res;
  }

  @override
  Future<int> saveAsp6EventosCostumbresParticipa(
      int? dimensionSocioCulturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa) async {
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
    final res = await supabase
        .from('Asp6_DimSocioCulturalEventosCostumbresParticipo')
        .select()
        .eq('DimSocioCulturalPueblosIndigenas_id',
            dimensionSocioCulturalPueblosIndigenasId);

    final result = List<LstEventoCostumbreParticipa>.from(
        res.map((m) => LstEventoCostumbreParticipa.fromJson(m))).toList();

    return result;
  }
}
