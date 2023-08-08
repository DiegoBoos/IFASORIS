import 'dart:convert';

import 'package:ifasoris/data/models/planta_medicinal_model.dart';

import '../../domain/entities/atencion_salud_entity.dart';
import 'enfermedad_tradicional_model.dart';
import 'especialidad_med_tradicional_model.dart';
import 'lugar_atencion_medico_model.dart';

AtencionSaludModel atencionSaludFromJson(String str) =>
    AtencionSaludModel.fromJson(json.decode(str));

class AtencionSaludModel extends AtencionSaludEntity {
  AtencionSaludModel(
      {int? atencionSaludId,
      int? afiliadoId,
      int? familiaId,
      int? enfermedadAcudeId,
      int? recibioAtencionMedTradicionalId,
      int? enfermedadTratamientoId,
      int? utilizaPlantasMedId,
      int? lugarPlantaMedicinalId,
      List<LstEnfermedadTradicional>? lstEnfermedadesTradicionales,
      List<LstEspMedTradicional>? lstEspecialidadesMedTradicional,
      List<LstLugarAtencionMedico>? lstLugaresAtencionMedico,
      List<LstPlantaMedicinal>? lstPlantasMedicinales})
      : super(
          atencionSaludId: atencionSaludId,
          afiliadoId: afiliadoId,
          familiaId: familiaId,
          enfermedadAcudeId: enfermedadAcudeId,
          recibioAtencionMedTradicionalId: recibioAtencionMedTradicionalId,
          enfermedadTratamientoId: enfermedadTratamientoId,
          utilizaPlantasMedId: utilizaPlantasMedId,
          lugarPlantaMedicinalId: lugarPlantaMedicinalId,
          lstEnfermedadesTradicionales: lstEnfermedadesTradicionales,
          lstEspecialidadesMedTradicional: lstEspecialidadesMedTradicional,
          lstLugaresAtencionMedico: lstLugaresAtencionMedico,
          lstPlantasMedicinales: lstPlantasMedicinales,
        );

  factory AtencionSaludModel.fromJson(Map<String, dynamic> json) =>
      AtencionSaludModel(
        atencionSaludId: json["AtencionSalud_id"],
        afiliadoId: json["Afiliado_id"],
        familiaId: json["Familia_id"],
        enfermedadAcudeId: json["EnfermedadAcude_id"],
        recibioAtencionMedTradicionalId:
            json["RecibioAtencionMedTradicional_id"],
        enfermedadTratamientoId: json["EnfermedadTratamiento_id"],
        utilizaPlantasMedId: json["UtilizaPlantasMed_id"],
        lugarPlantaMedicinalId: json["LugarPlantaMedicinal_id"],
      );
}
