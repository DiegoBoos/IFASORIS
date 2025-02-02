import 'dart:convert';

import 'package:ifasoris/data/models/servicio_solicitado.dart';

import '../../domain/entities/cuidado_salud_cond_riesgo.dart';
import 'nombre_enfermedad.dart';

List<CuidadoSaludCondRiesgoModel> listCuidadoSaludCondRiesgoFromJson(
        String str) =>
    List<CuidadoSaludCondRiesgoModel>.from(
        json.decode(str).map((x) => CuidadoSaludCondRiesgoModel.fromJson(x)));

CuidadoSaludCondRiesgoModel cuidadoSaludCondRiesgoFromJson(String str) =>
    CuidadoSaludCondRiesgoModel.fromJson(json.decode(str));

class CuidadoSaludCondRiesgoModel extends CuidadoSaludCondRiesgoEntity {
  const CuidadoSaludCondRiesgoModel({
    super.cuidadoSaludCondRiesgoId,
    super.afiliadoId,
    super.familiaId,
    super.ultimaVezInstSaludId,
    super.seguimientoEnfermedadId,
    super.condicionNutricionalId,
    super.tosFlemaId,
    super.manchasPielId,
    super.carnetVacunacionId,
    super.esquemaVacunacionId,
    super.lugarVacunacionId,
    super.utilizaMetodoPlanificacionId,
    super.metodoPlanificacionId,
    super.conductaSeguirId,
    super.lstServiciosSolicitados,
    super.lstNombresEnfermedades,
  });

  factory CuidadoSaludCondRiesgoModel.fromEntity(
      CuidadoSaludCondRiesgoEntity entity) {
    return CuidadoSaludCondRiesgoModel(
      cuidadoSaludCondRiesgoId: entity.cuidadoSaludCondRiesgoId,
      afiliadoId: entity.afiliadoId,
      familiaId: entity.familiaId,
      ultimaVezInstSaludId: entity.ultimaVezInstSaludId,
      seguimientoEnfermedadId: entity.seguimientoEnfermedadId,
      condicionNutricionalId: entity.condicionNutricionalId,
      tosFlemaId: entity.tosFlemaId,
      manchasPielId: entity.manchasPielId,
      carnetVacunacionId: entity.carnetVacunacionId,
      esquemaVacunacionId: entity.esquemaVacunacionId,
      lugarVacunacionId: entity.lugarVacunacionId,
      utilizaMetodoPlanificacionId: entity.utilizaMetodoPlanificacionId,
      metodoPlanificacionId: entity.metodoPlanificacionId,
      conductaSeguirId: entity.conductaSeguirId,
      lstServiciosSolicitados: entity.lstServiciosSolicitados,
      lstNombresEnfermedades: entity.lstNombresEnfermedades,
    );
  }

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
        lstServiciosSolicitados: json["LstServiciosSolicita"] != null
            ? listServiciosSolicitadosFromJson(
                jsonEncode(json["LstServiciosSolicita"]))
            : null,
        lstNombresEnfermedades: json["LstNombreEnfermedad"] != null
            ? listNombreEnfermedadFromJson(
                jsonEncode(json["LstNombreEnfermedad"]))
            : null,
        // lstServiciosSolicitados: json["LstServiciosSolicita"],
        // lstNombresEnfermedades: json["LstNombreEnfermedad"],
      );

  Map<String, dynamic> toJson() => {
        "CuidadoSaludCondRiesgo_id": cuidadoSaludCondRiesgoId,
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "UltimaVezInstSalud_id": ultimaVezInstSaludId,
        "SeguimientoEnfermedad_id": seguimientoEnfermedadId,
        "CondicionNutricional_id": condicionNutricionalId,
        "TosFlema_id": tosFlemaId,
        "ManchasPiel_id": manchasPielId,
        "CarnetVacunacion_id": carnetVacunacionId,
        "EsquemaVacunacion_id": esquemaVacunacionId,
        "LugarVacunacion_id": lugarVacunacionId,
        "UtilizaMetodoPlanificacion_id": utilizaMetodoPlanificacionId,
        "MetodoPlanificacion_id": metodoPlanificacionId,
        "ConductaSeguir_id": conductaSeguirId,
      };
}
