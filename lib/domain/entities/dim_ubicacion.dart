import 'package:equatable/equatable.dart';

import '../../data/models/cereal.dart';
import '../../data/models/dificultad_acceso_ca.dart';
import '../../data/models/dificultad_acceso_med_tradicional.dart';
import '../../data/models/especialidad_med_tradicional.dart';
import '../../data/models/especie_animal.dart';
import '../../data/models/fruto.dart';
import '../../data/models/hortaliza.dart';
import '../../data/models/leguminosa.dart';
import '../../data/models/medio_comunicacion.dart';
import '../../data/models/medio_utiliza_ca.dart';
import '../../data/models/medio_utiliza_med_tradicional.dart';
import '../../data/models/nombre_med_tradicional.dart';
import '../../data/models/tuberculo_platano.dart';
import '../../data/models/verdura.dart';
import '../../ui/blocs/dim_ubicacion/dim_ubicacion_bloc.dart';

class DimUbicacionEntity extends Equatable {
  final int? ubicacionId;
  final int? afiliadoId;
  final int? familiaId;
  final String? nombreRecibeVisita;
  final String? tipoDocRecibeVisita;
  final String? documentoRecibeVisita;
  final int? perteneceResguardo;
  final int? viaAccesoId;
  final int? resguardoId;
  final int? autoridadIndigenaId;
  final int? estadoViaId;
  final int? tiempoTardaId;
  final int? medioUtilizaId;
  final int? costoDesplazamientoId;
  final int? existeMedTradicionalComunidad;
  final int? tiempoTardaMedTradId;
  final int? costoDesplazamientoMedTradicional;
  final int? poseeChagra;
  final int? produccionMinera;
  final int? tipoCalendarioId;
  final List<LstDificultadAccesoMedTradicional>?
      lstDificultadAccesoMedTradicional;
  final List<LstCereal>? lstCereales;
  final List<LstDificultadAccesoAtencion>? lstDificultadAccesoAtencion;
  final List<LstEspMedTradicional>? lstEspMedTradicional;
  final List<LstAnimalCria>? lstAnimalCria;
  final List<LstFruto>? lstFrutos;
  final List<LstHortaliza>? lstHortalizas;
  final List<LstLeguminosa>? lstLeguminosas;
  final List<LstMediosComunica>? lstMediosComunica;
  final List<LstMediosUtilizaCA>? lstMediosUtilizaCA;
  final List<LstMediosMedTradicional>? lstMediosMedTradicional;
  final List<LstNombreMedTradicional>? lstNombreMedTradicional;
  final List<LstTuberculo>? lstTuberculos;
  final List<LstVerdura>? lstVerduras;
  final DimUbicacionState formStatus;

  const DimUbicacionEntity({
    this.ubicacionId,
    this.afiliadoId,
    this.familiaId,
    this.nombreRecibeVisita,
    this.tipoDocRecibeVisita,
    this.documentoRecibeVisita,
    this.perteneceResguardo,
    this.viaAccesoId,
    this.resguardoId,
    this.autoridadIndigenaId,
    this.estadoViaId,
    this.tiempoTardaId,
    this.medioUtilizaId,
    this.costoDesplazamientoId,
    this.existeMedTradicionalComunidad,
    this.tiempoTardaMedTradId,
    this.costoDesplazamientoMedTradicional,
    this.poseeChagra,
    this.produccionMinera,
    this.tipoCalendarioId,
    this.lstDificultadAccesoMedTradicional,
    this.lstCereales,
    this.lstDificultadAccesoAtencion,
    this.lstEspMedTradicional,
    this.lstAnimalCria,
    this.lstFrutos,
    this.lstHortalizas,
    this.lstLeguminosas,
    this.lstMediosComunica,
    this.lstMediosUtilizaCA,
    this.lstMediosMedTradicional,
    this.lstNombreMedTradicional,
    this.lstTuberculos,
    this.lstVerduras,
    this.formStatus = const DimUbicacionFormInitial(),
  });

  DimUbicacionEntity copyWith(
          {int? ubicacionId,
          int? afiliadoId,
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
          List<LstDificultadAccesoMedTradicional>?
              lstDificultadAccesoMedTradicional,
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
          DimUbicacionState? formStatus}) =>
      DimUbicacionEntity(
        ubicacionId: ubicacionId ?? this.ubicacionId,
        afiliadoId: afiliadoId ?? this.afiliadoId,
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
        tiempoTardaId: tiempoTardaId ?? this.tiempoTardaId,
        medioUtilizaId: medioUtilizaId ?? this.medioUtilizaId,
        costoDesplazamientoId:
            costoDesplazamientoId ?? this.costoDesplazamientoId,
        existeMedTradicionalComunidad:
            existeMedTradicionalComunidad ?? this.existeMedTradicionalComunidad,
        tiempoTardaMedTradId: tiempoTardaMedTradId ?? this.tiempoTardaMedTradId,
        costoDesplazamientoMedTradicional: costoDesplazamientoMedTradicional ??
            this.costoDesplazamientoMedTradicional,
        poseeChagra: poseeChagra ?? this.poseeChagra,
        produccionMinera: produccionMinera ?? this.produccionMinera,
        tipoCalendarioId: tipoCalendarioId ?? this.tipoCalendarioId,
        lstDificultadAccesoMedTradicional: lstDificultadAccesoMedTradicional ??
            this.lstDificultadAccesoMedTradicional,
        lstCereales: lstCereales ?? this.lstCereales,
        lstDificultadAccesoAtencion:
            lstDificultadAccesoAtencion ?? this.lstDificultadAccesoAtencion,
        lstEspMedTradicional: lstEspMedTradicional ?? this.lstEspMedTradicional,
        lstAnimalCria: lstAnimalCria ?? this.lstAnimalCria,
        lstFrutos: lstFrutos ?? this.lstFrutos,
        lstHortalizas: lstHortalizas ?? this.lstHortalizas,
        lstLeguminosas: lstLeguminosas ?? this.lstLeguminosas,
        lstMediosComunica: lstMediosComunica ?? this.lstMediosComunica,
        lstMediosUtilizaCA: lstMediosUtilizaCA ?? this.lstMediosUtilizaCA,
        lstMediosMedTradicional:
            lstMediosMedTradicional ?? this.lstMediosMedTradicional,
        lstNombreMedTradicional:
            lstNombreMedTradicional ?? this.lstNombreMedTradicional,
        lstTuberculos: lstTuberculos ?? this.lstTuberculos,
        lstVerduras: lstVerduras ?? this.lstVerduras,
        formStatus: formStatus ?? this.formStatus,
      );

  @override
  List<Object?> get props => [
        ubicacionId,
        afiliadoId,
        familiaId,
        nombreRecibeVisita,
        tipoDocRecibeVisita,
        documentoRecibeVisita,
        perteneceResguardo,
        viaAccesoId,
        resguardoId,
        autoridadIndigenaId,
        estadoViaId,
        tiempoTardaId,
        medioUtilizaId,
        costoDesplazamientoId,
        existeMedTradicionalComunidad,
        tiempoTardaMedTradId,
        costoDesplazamientoMedTradicional,
        poseeChagra,
        produccionMinera,
        tipoCalendarioId,
        lstDificultadAccesoMedTradicional,
        lstCereales,
        lstDificultadAccesoAtencion,
        lstEspMedTradicional,
        lstAnimalCria,
        lstFrutos,
        lstHortalizas,
        lstLeguminosas,
        lstMediosComunica,
        lstMediosUtilizaCA,
        lstMediosMedTradicional,
        lstNombreMedTradicional,
        lstTuberculos,
        lstVerduras,
        formStatus,
      ];
}
