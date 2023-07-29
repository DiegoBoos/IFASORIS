import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/planta_medicinal_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/planta_medicinal_model.dart';

abstract class PlantaMedicinalLocalDataSource {
  Future<List<PlantaMedicinalModel>> getPlantasMedicinales();
  Future<int> savePlantaMedicinal(PlantaMedicinalEntity plantaMedicinal);
  Future<List<LstPlantaMedicinal>> getPlantasMedicinalesAtencionSalud(
      int? atencionSaludId);

  Future<int> savePlantasMedicinalesAtencionSalud(
      int atencionSaludId, List<LstPlantaMedicinal> lstPlantaMedicinal);
}

class PlantaMedicinalLocalDataSourceImpl
    implements PlantaMedicinalLocalDataSource {
  @override
  Future<List<PlantaMedicinalModel>> getPlantasMedicinales() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('PlantasMedicinales_AtencionSalud');
    final result = List<PlantaMedicinalModel>.from(
        res.map((m) => PlantaMedicinalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePlantaMedicinal(PlantaMedicinalEntity plantaMedicinal) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'PlantasMedicinales_AtencionSalud', plantaMedicinal.toJson());

    return res;
  }

  @override
  Future<List<LstPlantaMedicinal>> getPlantasMedicinalesAtencionSalud(
      int? atencionSaludId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp7_PlantasMedicinales_AtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);
    final result = List<LstPlantaMedicinal>.from(
        res.map((m) => LstPlantaMedicinal.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePlantasMedicinalesAtencionSalud(
      int atencionSaludId, List<LstPlantaMedicinal> lstPlantaMedicinal) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp7_PlantasMedicinales_AtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);

    final plantasMedicinalesAtencionSalud = lstPlantaMedicinal
        .map((item) => PlantaMedicinalAtencionSalud(
            plantaMedicinalId: item.plantaMedicinalId,
            atencionSaludId: atencionSaludId))
        .toList();

    for (final plantaMedicinalAtencionSalud
        in plantasMedicinalesAtencionSalud) {
      batch.insert('Asp7_PlantasMedicinales_AtencionSalud',
          plantaMedicinalAtencionSalud.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
