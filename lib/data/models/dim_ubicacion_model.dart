import 'dart:convert';

import 'package:ifasoris/data/models/tuberculo_platano_model.dart';
import 'package:ifasoris/data/models/verdura_model.dart';

import '../../domain/entities/dim_ubicacion_entity.dart';
import 'cereal_model.dart';
import 'dificultad_acceso_ca_model.dart';
import 'dificultad_acceso_med_tradicional_model.dart';
import 'especialidad_med_tradicional_model.dart';
import 'especie_animal_model.dart';
import 'fruto_model.dart';
import 'hortaliza_model.dart';
import 'leguminosa_model.dart';
import 'medio_comunicacion_model.dart';
import 'medio_utiliza_ca_model.dart';
import 'medio_utiliza_med_tradicional_model.dart';
import 'nombre_med_tradicional_model.dart';

DimUbicacionModel dimUbicacionFromJson(String str) =>
    DimUbicacionModel.fromJson(json.decode(str));

class DimUbicacionModel extends DimUbicacionEntity {
  DimUbicacionModel({
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
  }) : super(
          ubicacionId: ubicacionId,
          familiaId: familiaId,
          nombreRecibeVisita: nombreRecibeVisita,
          tipoDocRecibeVisita: tipoDocRecibeVisita,
          documentoRecibeVisita: documentoRecibeVisita,
          perteneceResguardo: perteneceResguardo,
          viaAccesoId: viaAccesoId,
          resguardoId: resguardoId,
          autoridadIndigenaId: autoridadIndigenaId,
          estadoViaId: estadoViaId,
          tiempoTardaId: tiempoTardaId,
          costoDesplazamientoId: costoDesplazamientoId,
          existeMedTradicionalComunidad: existeMedTradicionalComunidad,
          tiempoTardaMedTradId: tiempoTardaMedTradId,
          costoDesplazamientoMedTradicional: costoDesplazamientoMedTradicional,
          poseeChagra: poseeChagra,
          produccionMinera: produccionMinera,
          tipoCalendarioId: tipoCalendarioId,
          lstDificultadAccesoMedTradicional: lstDificultadAccesoMedTradicional,
          lstCereales: lstCereales,
          lstDificultadAccesoAtencion: lstDificultadAccesoAtencion,
          lstEspMedTradicional: lstEspMedTradicional,
          lstAnimalCria: lstAnimalCria,
          lstFrutos: lstFrutos,
          lstHortalizas: lstHortalizas,
          lstLeguminosas: lstLeguminosas,
          lstMediosComunica: lstMediosComunica,
          lstMediosUtilizaCA: lstMediosUtilizaCA,
          lstMediosMedTradicional: lstMediosMedTradicional,
          lstNombreMedTradicional: lstNombreMedTradicional,
          lstTuberculos: lstTuberculos,
          lstVerduras: lstVerduras,
        );

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
}
