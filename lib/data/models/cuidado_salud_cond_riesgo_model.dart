import 'dart:convert';

import '../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';

CuidadoSaludCondRiesgoModel cuidadoSaludCondRiesgoFromJson(String str) =>
    CuidadoSaludCondRiesgoModel.fromJson(json.decode(str));

class CuidadoSaludCondRiesgoModel extends CuidadoSaludCondRiesgoEntity {
  CuidadoSaludCondRiesgoModel({
    int? cuidadoSaludCondRiesgoId,
    int? afiliadoId,
    int? familiaId,
    int? ultimaVezInstSaludId,
    int? seguimientoEnfermedadId,
    int? condicionNutricionalId,
    int? tosFlemaId,
    int? manchasPielId,
    int? carnetVacunacionId,
    int? esquemaVacunacionId,
    int? lugarVacunacionId,
    int? utilizaMetodoPlanificacionId,
    int? metodoPlanificacionId,
    int? conductaSeguirId,
  }) : super(
          cuidadoSaludCondRiesgoId: cuidadoSaludCondRiesgoId,
          afiliadoId: afiliadoId,
          familiaId: familiaId,
          ultimaVezInstSaludId: ultimaVezInstSaludId,
          seguimientoEnfermedadId: seguimientoEnfermedadId,
          condicionNutricionalId: condicionNutricionalId,
          tosFlemaId: tosFlemaId,
          manchasPielId: manchasPielId,
          carnetVacunacionId: carnetVacunacionId,
          esquemaVacunacionId: esquemaVacunacionId,
          lugarVacunacionId: lugarVacunacionId,
          utilizaMetodoPlanificacionId: utilizaMetodoPlanificacionId,
          metodoPlanificacionId: metodoPlanificacionId,
          conductaSeguirId: conductaSeguirId,
        );

  factory CuidadoSaludCondRiesgoModel.fromJson(Map<String, dynamic> json) =>
      CuidadoSaludCondRiesgoModel(
        cuidadoSaludCondRiesgoId: json["CuidadoSaludCondRiesgo_id"],
        afiliadoId: json["Afiliado_id"],
        familiaId: json["Familia_id"],
        ultimaVezInstSaludId: json["UltimaVezInstSalud_id"],
        seguimientoEnfermedadId: json["SeguimientoEnfermedad_id"],
        condicionNutricionalId: json["CondicionNutricional_id"],
        tosFlemaId: json["TosFlema_id"],
        manchasPielId: json["ManchasPiel_id"],
        carnetVacunacionId: json["CarnetVacunacion_id"],
        esquemaVacunacionId: json["EsquemaVacunacion_id"],
        lugarVacunacionId: json["LugarVacunacion_id"],
        utilizaMetodoPlanificacionId: json["UtilizaMetodoPlanificacion_id"],
        metodoPlanificacionId: json["MetodoPlanificacion_id"],
        conductaSeguirId: json["ConductaSeguir_id"],
      );
}
