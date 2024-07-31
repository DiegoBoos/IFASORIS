import 'dart:convert';

import 'package:ifasoris/data/models/planta_medicinal.dart';

import '../../domain/entities/atencion_salud.dart';
import 'enfermedad_tradicional.dart';
import 'especialidad_med_tradicional.dart';
import 'lugar_atencion_medico.dart';

List<AtencionSaludModel> listAtencionSaludFromJson(String str) =>
    List<AtencionSaludModel>.from(
        json.decode(str).map((x) => AtencionSaludModel.fromJson(x)));

AtencionSaludModel atencionSaludFromJson(String str) =>
    AtencionSaludModel.fromJson(json.decode(str));

class AtencionSaludModel extends AtencionSaludEntity {
  const AtencionSaludModel(
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
      List<LstPlantaMedicinal>? lstPlantasMedicinales});

  static fromEntity(AtencionSaludEntity atencionSalud) {
    return AtencionSaludModel(
      atencionSaludId: atencionSalud.atencionSaludId,
      afiliadoId: atencionSalud.afiliadoId,
      familiaId: atencionSalud.familiaId,
      enfermedadAcudeId: atencionSalud.enfermedadAcudeId,
      recibioAtencionMedTradicionalId:
          atencionSalud.recibioAtencionMedTradicionalId,
      enfermedadTratamientoId: atencionSalud.enfermedadTratamientoId,
      utilizaPlantasMedId: atencionSalud.utilizaPlantasMedId,
      lugarPlantaMedicinalId: atencionSalud.lugarPlantaMedicinalId,
      lstEnfermedadesTradicionales: atencionSalud.lstEnfermedadesTradicionales,
      lstEspecialidadesMedTradicional:
          atencionSalud.lstEspecialidadesMedTradicional,
      lstLugaresAtencionMedico: atencionSalud.lstLugaresAtencionMedico,
      lstPlantasMedicinales: atencionSalud.lstPlantasMedicinales,
    );
  }

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
        lstEnfermedadesTradicionales:
            json["LstEnfermedadesTRadicionales"] != null
                ? listEnfermedadTradicionalFromJson(
                    jsonEncode(json["LstEnfermedadesTRadicionales"]))
                : null,
        lstEspecialidadesMedTradicional:
            json["LstEpecialidadesMedTradicional"] != null
                ? listEspMedTradicionalFromJson(
                    jsonEncode(json["LstEpecialidadesMedTradicional"]))
                : null,
        lstLugaresAtencionMedico: json["LstLugaresatencion"] != null
            ? listLugarAtencionFromJson(jsonEncode(json["LstLugaresatencion"]))
            : null,
        lstPlantasMedicinales: json["LstPlantasMedicinales"] != null
            ? listPlantaMedicinalFromJson(
                jsonEncode(json["LstPlantasMedicinales"]))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "AtencionSalud_id": atencionSaludId,
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "EnfermedadAcude_id": enfermedadAcudeId,
        "RecibioAtencionMedTradicional_id": recibioAtencionMedTradicionalId,
        "EnfermedadTratamiento_id": enfermedadTratamientoId,
        "UtilizaPlantasMed_id": utilizaPlantasMedId,
        "LugarPlantaMedicinal_id": lugarPlantaMedicinalId,
        "LstEnfermedadesTRadicionales": lstEnfermedadesTradicionales,
        "LstEpecialidadesMedTradicional": lstEspecialidadesMedTradicional,
        "LstLugaresatencion": lstLugaresAtencionMedico,
        "LstPlantasMedicinales": lstPlantasMedicinales,
      };
}
