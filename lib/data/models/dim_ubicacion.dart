import 'dart:convert';

import '../../domain/entities/dim_ubicacion.dart';
import 'cereal.dart';
import 'dificultad_acceso_ca.dart';
import 'dificultad_acceso_med_tradicional.dart';
import 'especialidad_med_tradicional.dart';
import 'especie_animal.dart';
import 'fruto.dart';
import 'hortaliza.dart';
import 'leguminosa.dart';
import 'medio_comunicacion.dart';
import 'medio_utiliza_ca.dart';
import 'medio_utiliza_med_tradicional.dart';
import 'nombre_med_tradicional.dart';
import 'tuberculo_platano.dart';
import 'verdura.dart';

DimUbicacionModel dimUbicacionFromJson(String str) =>
    DimUbicacionModel.fromJson(json.decode(str));

class DimUbicacionModel extends DimUbicacionEntity {
  const DimUbicacionModel({
    int? ubicacionId,
    int? familiaId,
    String? nombreRecibeVisita,
    String? tipoDocRecibeVisita,
    String? documentoRecibeVisita,
    int? perteneceResguardo,
    int? viaAccesoId,
    int? resguardoId,
    int? autoridadIndigenaId,
    int? estadoViaId,
    int? tiempoTardaId,
    int? medioUtilizaId,
    int? costoDesplazamientoId,
    int? existeMedTradicionalComunidad,
    int? tiempoTardaMedTradId,
    int? costoDesplazamientoMedTradicional,
    int? poseeChagra,
    int? produccionMinera,
    int? tipoCalendarioId,
    List<LstDificultadAccesoMedTradicional>? lstDificultadAccesoMedTradicional,
    List<LstCereal>? lstCereales,
    List<LstDificultadAccesoAtencion>? lstDificultadAccesoAtencion,
    List<LstEspMedTradicional>? lstEspMedTradicional,
    List<LstAnimalCria>? lstAnimalCria,
    List<LstFruto>? lstFrutos,
    List<LstHortaliza>? lstHortalizas,
    List<LstLeguminosa>? lstLeguminosas,
    List<LstMediosComunica>? lstMediosComunica,
    List<LstMediosUtilizaCA>? lstMediosUtilizaCA,
    List<LstMediosMedTradicional>? lstMediosMedTradicional,
    List<LstNombreMedTradicional>? lstNombreMedTradicional,
    List<LstTuberculo>? lstTuberculos,
    List<LstVerdura>? lstVerduras,
  });

  static DimUbicacionModel fromEntity(DimUbicacionEntity entity) {
    return DimUbicacionModel(
      ubicacionId: entity.ubicacionId,
      familiaId: entity.familiaId,
      nombreRecibeVisita: entity.nombreRecibeVisita,
      tipoDocRecibeVisita: entity.tipoDocRecibeVisita,
      documentoRecibeVisita: entity.documentoRecibeVisita,
      perteneceResguardo: entity.perteneceResguardo,
      viaAccesoId: entity.viaAccesoId,
      resguardoId: entity.resguardoId,
      autoridadIndigenaId: entity.autoridadIndigenaId,
      estadoViaId: entity.estadoViaId,
      tiempoTardaId: entity.tiempoTardaId,
      medioUtilizaId: entity.medioUtilizaId,
      costoDesplazamientoId: entity.costoDesplazamientoId,
      existeMedTradicionalComunidad: entity.existeMedTradicionalComunidad,
      tiempoTardaMedTradId: entity.tiempoTardaMedTradId,
      costoDesplazamientoMedTradicional:
          entity.costoDesplazamientoMedTradicional,
      poseeChagra: entity.poseeChagra,
      produccionMinera: entity.produccionMinera,
      tipoCalendarioId: entity.tipoCalendarioId,
      lstDificultadAccesoMedTradicional:
          entity.lstDificultadAccesoMedTradicional,
      lstCereales: entity.lstCereales,
      lstDificultadAccesoAtencion: entity.lstDificultadAccesoAtencion,
      lstEspMedTradicional: entity.lstEspMedTradicional,
      lstAnimalCria: entity.lstAnimalCria,
      lstFrutos: entity.lstFrutos,
      lstHortalizas: entity.lstHortalizas,
      lstLeguminosas: entity.lstLeguminosas,
      lstMediosComunica: entity.lstMediosComunica,
      lstMediosUtilizaCA: entity.lstMediosUtilizaCA,
      lstMediosMedTradicional: entity.lstMediosMedTradicional,
      lstNombreMedTradicional: entity.lstNombreMedTradicional,
      lstTuberculos: entity.lstTuberculos,
      lstVerduras: entity.lstVerduras,
    );
  }

  factory DimUbicacionModel.fromJson(Map<String, dynamic> json) =>
      DimUbicacionModel(
        ubicacionId: json["Ubicacion_id"],
        familiaId: json["Familia_id"],
        nombreRecibeVisita: json["NombreRecibeVisita"],
        tipoDocRecibeVisita: json["TipoDoc_RecibeVisita"],
        documentoRecibeVisita: json["Documento_RecibeVisita"],
        perteneceResguardo: json["PerteneceResguardo"],
        viaAccesoId: json["ViaAcceso_id"],
        resguardoId: json["Resguardo_id"],
        autoridadIndigenaId: json["AutoridadIndigena_id"],
        estadoViaId: json["EstadoVia_id"],
        tiempoTardaId: json["TiempoTarda_id"],
        medioUtilizaId: json["MedioUtiliza_id"],
        costoDesplazamientoId: json["CostoDesplazamiento_id"],
        existeMedTradicionalComunidad: json["ExisteMedTradicionalComunidad"],
        tiempoTardaMedTradId: json["TiempoTardaMedTrad_id"],
        costoDesplazamientoMedTradicional:
            json["CostoDesplazamiento_MedTradicional"],
        poseeChagra: json["PoseeChagra"],
        produccionMinera: json["ProduccionMinera"],
        tipoCalendarioId: json["TipoCalendario_id"],
        lstDificultadAccesoMedTradicional:
            json["lstDificultadAccesoMedTradicional"] == null
                ? []
                : List<LstDificultadAccesoMedTradicional>.from(
                    json["lstDificultadAccesoMedTradicional"]!.map(
                        (x) => LstDificultadAccesoMedTradicional.fromJson(x))),
        lstCereales: json["lstCereales"] == null
            ? []
            : List<LstCereal>.from(
                json["lstCereales"]!.map((x) => LstCereal.fromJson(x))),
        lstDificultadAccesoAtencion: json["lstDificultadAccesoAtencion"] == null
            ? []
            : List<LstDificultadAccesoAtencion>.from(
                json["lstDificultadAccesoAtencion"]!
                    .map((x) => LstDificultadAccesoAtencion.fromJson(x))),
        lstEspMedTradicional: json["lstEspMedTradicional"] == null
            ? []
            : List<LstEspMedTradicional>.from(json["lstEspMedTradicional"]!
                .map((x) => LstEspMedTradicional.fromJson(x))),
        lstAnimalCria: json["lstAnimalCria"] == null
            ? []
            : List<LstAnimalCria>.from(
                json["lstAnimalCria"]!.map((x) => LstAnimalCria.fromJson(x))),
        lstFrutos: json["lstFrutos"] == null
            ? []
            : List<LstFruto>.from(
                json["lstFrutos"]!.map((x) => LstFruto.fromJson(x))),
        lstHortalizas: json["lstHortalizas"] == null
            ? []
            : List<LstHortaliza>.from(
                json["lstHortalizas"]!.map((x) => LstHortaliza.fromJson(x))),
        lstLeguminosas: json["lstLeguminosas"] == null
            ? []
            : List<LstLeguminosa>.from(
                json["lstLeguminosas"]!.map((x) => LstLeguminosa.fromJson(x))),
        lstMediosComunica: json["lstMediosComunica"] == null
            ? []
            : List<LstMediosComunica>.from(json["lstMediosComunica"]!
                .map((x) => LstMediosComunica.fromJson(x))),
        lstMediosMedTradicional: json["lstMediosMedTradicional"] == null
            ? []
            : List<LstMediosMedTradicional>.from(
                json["lstMediosMedTradicional"]!
                    .map((x) => LstMediosMedTradicional.fromJson(x))),
        lstNombreMedTradicional: json["lstNombreMedTradicional"] == null
            ? []
            : List<LstNombreMedTradicional>.from(
                json["lstNombreMedTradicional"]!
                    .map((x) => LstNombreMedTradicional.fromJson(x))),
        lstTuberculos: json["lstTuberculos"] == null
            ? []
            : List<LstTuberculo>.from(
                json["lstTuberculos"]!.map((x) => LstTuberculo.fromJson(x))),
        lstVerduras: json["lstVerduras"] == null
            ? []
            : List<LstVerdura>.from(
                json["lstVerduras"]!.map((x) => LstVerdura.fromJson(x))),
        lstMediosUtilizaCA: json["lstMediosUtilizaCA"] == null
            ? []
            : List<LstMediosUtilizaCA>.from(json["lstMediosUtilizaCA"]!
                .map((x) => LstMediosUtilizaCA.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Afiliado_id": afiliadoId,
        "Familia_id": familiaId,
        "NombreRecibeVisita": nombreRecibeVisita,
        "TipoDoc_RecibeVisita": tipoDocRecibeVisita,
        "Documento_RecibeVisita": documentoRecibeVisita,
        "PerteneceResguardo": perteneceResguardo,
        "ViaAcceso_id": viaAccesoId,
        "Resguardo_id": resguardoId,
        "AutoridadIndigena_id": autoridadIndigenaId,
        "EstadoVia_id": estadoViaId,
        "TiempoTarda_id": tiempoTardaId,
        "CostoDesplazamiento_id": costoDesplazamientoId,
        "ExisteMedTradicionalComunidad": existeMedTradicionalComunidad,
        "TiempoTardaMedTrad_id": tiempoTardaMedTradId,
        "CostoDesplazamiento_MedTradicional": costoDesplazamientoMedTradicional,
        "PoseeChagra": poseeChagra,
        "ProduccionMinera": produccionMinera,
        "TipoCalendario_id": tipoCalendarioId
      };
}
