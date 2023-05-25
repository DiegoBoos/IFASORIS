import 'dart:convert';

import '../../domain/entities/dim_ubicacion_entity.dart';

DimUbicacionModel dimUbicacionFromJson(String str) =>
    DimUbicacionModel.fromDB(json.decode(str));

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
    List<int>? mediosComunicacionIds,
    int? tiempoTardaId,
    List<int>? mediosUtilizaIds,
    List<int>? dificultadesAccesoIds,
    int? costoDesplazamientoId,
    int? existeMedTradicionalComunidad,
    List<int>? especialidadesMedTradIds,
    int? tiempoTardaMedTradId,
    List<int>? mediosUtilizaMedTradIds,
    List<int>? dificultadesAccesoMedTradIds,
    int? costoDesplazamientoMedTradicional,
    List<String>? nombresMedTradicional,
    int? poseeChagra,
    List<int>? tuberculosPlatanosIds,
    List<int>? leguminosasIds,
    List<int>? hortalizasIds,
    List<int>? verdurasIds,
    List<int>? frutosIds,
    List<int>? cerealesIds,
    List<int>? especiesAnimalesCriaIds,
    int? produccionMinera,
    int? tipoCalendarioId,
  }) : super(
          ubicacionId: ubicacionId ?? 0,
          familiaId: familiaId ?? 0,
          nombreRecibeVisita: nombreRecibeVisita ?? '',
          tipoDocRecibeVisita: tipoDocRecibeVisita ?? '',
          documentoRecibeVisita: documentoRecibeVisita ?? '',
          perteneceResguardo: perteneceResguardo ?? 0,
          viaAccesoId: viaAccesoId ?? 0,
          resguardoId: resguardoId ?? 0,
          autoridadIndigenaId: autoridadIndigenaId ?? 0,
          estadoViaId: estadoViaId ?? 0,
          mediosComunicacionIds: mediosComunicacionIds,
          tiempoTardaId: tiempoTardaId ?? 0,
          mediosUtilizaIds: mediosUtilizaIds,
          dificultadesAccesoIds: dificultadesAccesoIds,
          costoDesplazamientoId: costoDesplazamientoId ?? 0,
          existeMedTradicionalComunidad: existeMedTradicionalComunidad ?? 0,
          especialidadesMedTradIds: especialidadesMedTradIds,
          tiempoTardaMedTradId: tiempoTardaMedTradId ?? 0,
          mediosUtilizaMedTradIds: mediosUtilizaMedTradIds,
          dificultadesAccesoMedTradIds: dificultadesAccesoMedTradIds,
          costoDesplazamientoMedTradicional:
              costoDesplazamientoMedTradicional ?? 0,
          nombresMedTradicional: nombresMedTradicional,
          poseeChagra: poseeChagra ?? 0,
          tuberculosPlatanosIds: tuberculosPlatanosIds,
          leguminosasIds: leguminosasIds,
          hortalizasIds: hortalizasIds,
          verdurasIds: verdurasIds,
          frutosIds: frutosIds,
          cerealesIds: cerealesIds,
          especiesAnimalesCriaIds: especiesAnimalesCriaIds,
          produccionMinera: produccionMinera ?? 0,
          tipoCalendarioId: tipoCalendarioId,
        );

  factory DimUbicacionModel.fromDB(Map<String, dynamic> json) =>
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
        mediosComunicacionIds:
            List<int>.from(jsonDecode(json["MediosComunicacion_ids"])),
        tiempoTardaId: json["TiempoTarda_id"],
        mediosUtilizaIds: List<int>.from(jsonDecode(json["MediosUtiliza_ids"])),
        dificultadesAccesoIds:
            List<int>.from(jsonDecode(json["DificultadesAcceso_ids"])),
        costoDesplazamientoId: json["CostoDesplazamiento_id"],
        existeMedTradicionalComunidad: json["ExisteMedTradicionalComunidad"],
        especialidadesMedTradIds:
            List<int>.from(jsonDecode(json["EspecialidadesMedTrad_ids"])),
        tiempoTardaMedTradId: json["TiempoTardaMedTrad_id"],
        mediosUtilizaMedTradIds: json["MediosUtilizaMedTrad_ids"] != "null"
            ? List<int>.from(jsonDecode(json["MediosUtilizaMedTrad_ids"]))
            : [],
        dificultadesAccesoMedTradIds: json["DificultadesAccesoMedTrad_ids"] !=
                "null"
            ? List<int>.from(jsonDecode(json["DificultadesAccesoMedTrad_ids"]))
            : [],
        costoDesplazamientoMedTradicional:
            json["CostoDesplazamiento_MedTradicional"],
        nombresMedTradicional:
            List<String>.from(jsonDecode(json["nombresMedTradicional"])),
        poseeChagra: json["PoseeChagra"],
        tuberculosPlatanosIds: json["TuberculosPlatanos_ids"] != "null"
            ? List<int>.from(jsonDecode(json["TuberculosPlatanos_ids"]))
            : [],
        leguminosasIds: json["Leguminosas_ids"] != "null"
            ? List<int>.from(jsonDecode(json["Leguminosas_ids"]))
            : [],
        hortalizasIds: json["Hortalizas_ids"] != "null"
            ? List<int>.from(jsonDecode(json["Hortalizas_ids"]))
            : [],
        verdurasIds: json["Verduras_ids"] != "null"
            ? List<int>.from(jsonDecode(json["Verduras_ids"]))
            : [],
        frutosIds: json["Frutos_ids"] != "null"
            ? List<int>.from(jsonDecode(json["Frutos_ids"]))
            : [],
        cerealesIds: json["Cereales_ids"] != "null"
            ? List<int>.from(jsonDecode(json["Cereales_ids"]))
            : [],
        especiesAnimalesCriaIds:
            List<int>.from(jsonDecode(json["EspeciesAnimalesCria_ids"])),
        produccionMinera: json["ProduccionMinera"],
        tipoCalendarioId: json["TipoCalendario_id"],
      );
}
