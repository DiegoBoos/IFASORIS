import 'package:ifasoris/data/models/medio_utiliza_ca_model.dart';

import '../../data/models/cereal_model.dart';
import '../../data/models/dificultad_acceso_ca_model.dart';
import '../../data/models/dificultad_acceso_med_tradicional_model.dart';
import '../../data/models/especialidad_med_tradicional_model.dart';
import '../../data/models/especie_animal_model.dart';
import '../../data/models/fruto_model.dart';
import '../../data/models/hortaliza_model.dart';
import '../../data/models/leguminosa_model.dart';
import '../../data/models/medio_comunicacion_model.dart';
import '../../data/models/medio_utiliza_med_tradicional_model.dart';
import '../../data/models/nombre_med_tradicional_model.dart';
import '../../data/models/tuberculo_platano_model.dart';
import '../../data/models/verdura_model.dart';
import '../../ui/blocs/dim_ubicacion/dim_ubicacion_bloc.dart';

class DimUbicacionEntity {
  int? ubicacionId;
  int? afiliadoId;
  int? familiaId;
  String? nombreRecibeVisita;
  String? tipoDocRecibeVisita;
  String? documentoRecibeVisita;
  int? perteneceResguardo;
  int? viaAccesoId;
  int? resguardoId;
  int? autoridadIndigenaId;
  int? estadoViaId;
  int? tiempoTardaId;
  int? costoDesplazamientoId;
  int? existeMedTradicionalComunidad;
  int? tiempoTardaMedTradId;
  int? costoDesplazamientoMedTradicional;
  int? poseeChagra;
  int? produccionMinera;
  int? tipoCalendarioId;
  List<LstDificultadAccesoMedTradicional>? lstDificultadAccesoMedTradicional;
  List<LstCereal>? lstCereales;
  List<LstDificultadAccesoAtencion>? lstDificultadAccesoAtencion;
  List<LstEspMedTradicional>? lstEspMedTradicional;
  List<LstAnimalCria>? lstAnimalCria;
  List<LstFruto>? lstFrutos;
  List<LstHortaliza>? lstHortalizas;
  List<LstLeguminosa>? lstLeguminosas;
  List<LstMediosComunica>? lstMediosComunica;
  List<LstMediosUtilizaCA>? lstMediosUtilizaCA;
  List<LstMediosMedTradicional>? lstMediosMedTradicional;
  List<LstNombreMedTradicional>? lstNombreMedTradicional;
  List<LstTuberculo>? lstTuberculos;
  List<LstVerdura>? lstVerduras;
  DimUbicacionState formStatus;

  DimUbicacionEntity({
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
