import 'dart:convert';

import '../../ui/blocs/dim_ubicacion/dim_ubicacion_bloc.dart';

class DimUbicacionEntity {
  int? ubicacionId;
  int? familiaId;
  String? nombreRecibeVisita;
  String? tipoDocRecibeVisita;
  String? documentoRecibeVisita;
  int? perteneceResguardo;
  int? viaAccesoId;
  int? resguardoId;
  int? autoridadIndigenaId;
  int? estadoViaId;
  List<int>? mediosComunicacionIds;
  int? tiempoTardaId;
  List<int>? mediosUtilizaIds;
  List<int>? dificultadesAccesoIds;
  int? costoDesplazamientoId;
  int? existeMedTradicionalComunidad;
  List<int>? especialidadesMedTradIds;
  int? tiempoTardaMedTradId;
  List<int>? mediosUtilizaMedTradIds;
  List<int>? dificultadesAccesoMedTradIds;
  int? costoDesplazamientoMedTradicional;
  List<String>? nombresMedTradicional;
  int? poseeChagra;
  List<int>? tuberculosPlatanosIds;
  List<int>? leguminosasIds;
  List<int>? hortalizasIds;
  List<int>? verdurasIds;
  List<int>? frutosIds;
  List<int>? cerealesIds;
  List<int>? especiesAnimalesCriaIds;
  int? produccionMinera;
  List<int>? tiposCalendariosIds;
  DimUbicacionState formStatus;

  DimUbicacionEntity(
      {this.ubicacionId,
      this.familiaId,
      this.nombreRecibeVisita,
      this.tipoDocRecibeVisita,
      this.documentoRecibeVisita,
      this.perteneceResguardo,
      this.viaAccesoId,
      this.resguardoId,
      this.autoridadIndigenaId,
      this.estadoViaId,
      this.mediosComunicacionIds,
      this.tiempoTardaId,
      this.mediosUtilizaIds,
      this.dificultadesAccesoIds,
      this.costoDesplazamientoId,
      this.existeMedTradicionalComunidad,
      this.especialidadesMedTradIds,
      this.tiempoTardaMedTradId,
      this.mediosUtilizaMedTradIds,
      this.dificultadesAccesoMedTradIds,
      this.costoDesplazamientoMedTradicional,
      this.nombresMedTradicional,
      this.poseeChagra,
      this.tuberculosPlatanosIds,
      this.leguminosasIds,
      this.hortalizasIds,
      this.verdurasIds,
      this.frutosIds,
      this.cerealesIds,
      this.especiesAnimalesCriaIds,
      this.produccionMinera,
      this.tiposCalendariosIds,
      this.formStatus = const DimUbicacionFormInitial()});

  DimUbicacionEntity copyWith(
          {int? ubicacionId,
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
          List<int>? tiposCalendariosIds,
          DimUbicacionState? formStatus}) =>
      DimUbicacionEntity(
        ubicacionId: ubicacionId ?? this.ubicacionId,
        familiaId: familiaId ?? this.familiaId,
        nombreRecibeVisita: nombreRecibeVisita ?? this.nombreRecibeVisita,
        tipoDocRecibeVisita: tipoDocRecibeVisita ?? this.tipoDocRecibeVisita,
        documentoRecibeVisita:
            documentoRecibeVisita ?? this.documentoRecibeVisita,
        perteneceResguardo: perteneceResguardo ?? this.perteneceResguardo,
        viaAccesoId: viaAccesoId ?? this.viaAccesoId,
        resguardoId: resguardoId ?? this.resguardoId,
        autoridadIndigenaId: autoridadIndigenaId ?? this.autoridadIndigenaId,
        estadoViaId: estadoViaId ?? this.estadoViaId,
        mediosComunicacionIds:
            mediosComunicacionIds ?? this.mediosComunicacionIds,
        tiempoTardaId: tiempoTardaId ?? this.tiempoTardaId,
        mediosUtilizaIds: mediosUtilizaIds ?? this.mediosUtilizaIds,
        dificultadesAccesoIds:
            dificultadesAccesoIds ?? this.dificultadesAccesoIds,
        costoDesplazamientoId:
            costoDesplazamientoId ?? this.costoDesplazamientoId,
        existeMedTradicionalComunidad:
            existeMedTradicionalComunidad ?? this.existeMedTradicionalComunidad,
        especialidadesMedTradIds:
            especialidadesMedTradIds ?? this.especialidadesMedTradIds,
        tiempoTardaMedTradId: tiempoTardaMedTradId ?? this.tiempoTardaMedTradId,
        mediosUtilizaMedTradIds:
            mediosUtilizaMedTradIds ?? this.mediosUtilizaMedTradIds,
        dificultadesAccesoMedTradIds:
            dificultadesAccesoMedTradIds ?? this.dificultadesAccesoMedTradIds,
        costoDesplazamientoMedTradicional: costoDesplazamientoMedTradicional ??
            this.costoDesplazamientoMedTradicional,
        nombresMedTradicional:
            nombresMedTradicional ?? this.nombresMedTradicional,
        poseeChagra: poseeChagra ?? this.poseeChagra,
        tuberculosPlatanosIds:
            tuberculosPlatanosIds ?? this.tuberculosPlatanosIds,
        leguminosasIds: leguminosasIds ?? this.leguminosasIds,
        hortalizasIds: hortalizasIds ?? this.hortalizasIds,
        verdurasIds: verdurasIds ?? this.verdurasIds,
        frutosIds: frutosIds ?? this.frutosIds,
        cerealesIds: cerealesIds ?? this.cerealesIds,
        especiesAnimalesCriaIds:
            especiesAnimalesCriaIds ?? this.especiesAnimalesCriaIds,
        produccionMinera: produccionMinera ?? this.produccionMinera,
        tiposCalendariosIds: tiposCalendariosIds ?? this.tiposCalendariosIds,
        formStatus: formStatus ?? this.formStatus,
      );

  Map<String, dynamic> toJson() => {
        "Ubicacion_id": ubicacionId,
        "Familia_id": familiaId,
        "NombreRecibeVisita": nombreRecibeVisita,
        "TipoDoc_RecibeVisita": tipoDocRecibeVisita,
        "Documento_RecibeVisita": documentoRecibeVisita,
        "PerteneceResguardo": perteneceResguardo,
        "ViaAcceso_id": viaAccesoId,
        "Resguardo_id": resguardoId,
        "AutoridadIndigena_id": autoridadIndigenaId,
        "EstadoVia_id": estadoViaId,
        "MediosComunicacion_ids": jsonEncode(mediosComunicacionIds),
        "TiempoTarda_id": tiempoTardaId,
        "MediosUtiliza_ids": jsonEncode(mediosUtilizaIds),
        "DificultadesAcceso_ids": jsonEncode(dificultadesAccesoIds),
        "CostoDesplazamiento_id": costoDesplazamientoId,
        "ExisteMedTradicionalComunidad": existeMedTradicionalComunidad,
        "EspecialidadesMedTrad_ids": jsonEncode(especialidadesMedTradIds),
        "TiempoTardaMedTrad_id": tiempoTardaMedTradId,
        "MediosUtilizaMedTrad_ids": jsonEncode(mediosUtilizaMedTradIds),
        "DificultadesAccesoMedTrad_ids":
            jsonEncode(dificultadesAccesoMedTradIds),
        "CostoDesplazamiento_MedTradicional": costoDesplazamientoMedTradicional,
        "nombresMedTradicional": jsonEncode(nombresMedTradicional),
        "PoseeChagra": poseeChagra,
        "TuberculosPlatanos_ids": jsonEncode(tuberculosPlatanosIds),
        "Leguminosas_ids": jsonEncode(leguminosasIds),
        "Hortalizas_ids": jsonEncode(hortalizasIds),
        "Verduras_ids": jsonEncode(verdurasIds),
        "Frutos_ids": jsonEncode(frutosIds),
        "Cereales_ids": jsonEncode(cerealesIds),
        "EspeciesAnimalesCria_ids": jsonEncode(especiesAnimalesCriaIds),
        "ProduccionMinera": produccionMinera,
        "TiposCalendarios_ids": jsonEncode(tiposCalendariosIds),
      };
}
