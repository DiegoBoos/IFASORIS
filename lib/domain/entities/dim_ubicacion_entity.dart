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
  int? medioComunicacionId;
  int? tiempoTardaId;
  int? medioUtilizaId;
  int? dificultaAccesoId;
  int? costoDesplazamientoId;
  int? existeMedTradicionalComunidad;
  int? especialidadMedTradId;
  int? tiempoTardaMedTradId;
  int? medioUtilizaMedTradId;
  int? dificultadAccesoMedTradId;
  int? costoDesplazamientoMedTradicional;
  String? nombreMedTradicional;
  int? poseeChagra;
  int? tuberculoPlatanoId;
  int? leguminosaId;
  int? hortalizaId;
  int? verduraId;
  int? frutoId;
  int? cerealId;
  int? especieAnimalCriaId;
  int? produccionMinera;
  int? tipoCalendarioId;
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
      this.medioComunicacionId,
      this.tiempoTardaId,
      this.medioUtilizaId,
      this.dificultaAccesoId,
      this.costoDesplazamientoId,
      this.existeMedTradicionalComunidad,
      this.especialidadMedTradId,
      this.tiempoTardaMedTradId,
      this.medioUtilizaMedTradId,
      this.dificultadAccesoMedTradId,
      this.costoDesplazamientoMedTradicional,
      this.nombreMedTradicional,
      this.poseeChagra,
      this.tuberculoPlatanoId,
      this.leguminosaId,
      this.hortalizaId,
      this.verduraId,
      this.frutoId,
      this.cerealId,
      this.especieAnimalCriaId,
      this.produccionMinera,
      this.tipoCalendarioId,
      this.formStatus = const FormInitial()});

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
          int? medioComunicacionId,
          int? tiempoTardaId,
          int? medioUtilizaId,
          int? dificultaAccesoId,
          int? costoDesplazamientoId,
          int? existeMedTradicionalComunidad,
          int? especialidadMedTradId,
          int? tiempoTardaMedTradId,
          int? medioUtilizaMedTradId,
          int? dificultadAccesoMedTradId,
          int? costoDesplazamientoMedTradicional,
          String? nombreMedTradicional,
          int? poseeChagra,
          int? tuberculoPlatanoId,
          int? leguminosaId,
          int? hortalizaId,
          int? verduraId,
          int? frutoId,
          int? cerealId,
          int? especieAnimalCriaId,
          int? produccionMinera,
          int? tipoCalendarioId,
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
        medioComunicacionId: medioComunicacionId ?? this.medioComunicacionId,
        tiempoTardaId: tiempoTardaId ?? this.tiempoTardaId,
        medioUtilizaId: medioUtilizaId ?? this.medioUtilizaId,
        dificultaAccesoId: dificultaAccesoId ?? this.dificultaAccesoId,
        costoDesplazamientoId:
            costoDesplazamientoId ?? this.costoDesplazamientoId,
        existeMedTradicionalComunidad:
            existeMedTradicionalComunidad ?? this.existeMedTradicionalComunidad,
        especialidadMedTradId:
            especialidadMedTradId ?? this.especialidadMedTradId,
        tiempoTardaMedTradId: tiempoTardaMedTradId ?? this.tiempoTardaMedTradId,
        medioUtilizaMedTradId:
            medioUtilizaMedTradId ?? this.medioUtilizaMedTradId,
        dificultadAccesoMedTradId:
            dificultadAccesoMedTradId ?? this.dificultadAccesoMedTradId,
        costoDesplazamientoMedTradicional: costoDesplazamientoMedTradicional ??
            this.costoDesplazamientoMedTradicional,
        nombreMedTradicional: nombreMedTradicional ?? this.nombreMedTradicional,
        poseeChagra: poseeChagra ?? this.poseeChagra,
        tuberculoPlatanoId: tuberculoPlatanoId ?? this.tuberculoPlatanoId,
        leguminosaId: leguminosaId ?? this.leguminosaId,
        hortalizaId: hortalizaId ?? this.hortalizaId,
        verduraId: verduraId ?? this.verduraId,
        frutoId: frutoId ?? this.frutoId,
        cerealId: cerealId ?? this.cerealId,
        especieAnimalCriaId: especieAnimalCriaId ?? this.especieAnimalCriaId,
        produccionMinera: produccionMinera ?? this.produccionMinera,
        tipoCalendarioId: tipoCalendarioId ?? this.tipoCalendarioId,
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
        "MedioComunicacion_id": medioComunicacionId,
        "TiempoTarda_id": tiempoTardaId,
        "MedioUtiliza_id": medioUtilizaId,
        "DificultaAcceso_id": dificultaAccesoId,
        "CostoDesplazamiento_id": costoDesplazamientoId,
        "ExisteMedTradicionalComunidad": existeMedTradicionalComunidad,
        "EspecialidadMedTrad_id": especialidadMedTradId,
        "TiempoTardaMedTrad_id": tiempoTardaMedTradId,
        "MedioUtilizaMedTrad_id": medioUtilizaMedTradId,
        "DificultadAccesoMedTrad_id": dificultadAccesoMedTradId,
        "CostoDesplazamiento_MedTradicional": costoDesplazamientoMedTradicional,
        "NombreMedTradicional": nombreMedTradicional,
        "PoseeChagra": poseeChagra,
        "TuberculoPlatano_id": tuberculoPlatanoId,
        "Leguminosa_id": leguminosaId,
        "Hortaliza_id": hortalizaId,
        "Verdura_id": verduraId,
        "Fruto_id": frutoId,
        "Cereal_id": cerealId,
        "EspecieAnimalCria_id": especieAnimalCriaId,
        "ProduccionMinera": produccionMinera,
        "TipoCalendario_id": tipoCalendarioId,
      };
}
