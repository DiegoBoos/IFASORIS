part of 'dim_ubicacion_bloc.dart';

abstract class DimUbicacionEvent extends Equatable {
  const DimUbicacionEvent();

  @override
  List<Object> get props => [];
}

class DimUbicacionInit extends DimUbicacionEvent {}

class DimUbicacionReset extends DimUbicacionEvent {}

class DimUbicacionSubmitted extends DimUbicacionEvent {}

class GetDimUbicacion extends DimUbicacionEvent {
  final int familiaId;

  const GetDimUbicacion(this.familiaId);
}

class UbicacionChanged extends DimUbicacionEvent {
  final int ubicacionId;

  const UbicacionChanged(this.ubicacionId);
}

class DimUbicacionFamiliaChanged extends DimUbicacionEvent {
  final int familiaId;

  const DimUbicacionFamiliaChanged(this.familiaId);
}

class NombreRecibeVisitaChanged extends DimUbicacionEvent {
  final String nombreRecibeVisita;

  const NombreRecibeVisitaChanged(this.nombreRecibeVisita);
}

class TipoDocRecibeVisitaChanged extends DimUbicacionEvent {
  final String tipoDocRecibeVisita;

  const TipoDocRecibeVisitaChanged(this.tipoDocRecibeVisita);
}

class DocumentoRecibeVisitaChanged extends DimUbicacionEvent {
  final String documentoRecibeVisita;

  const DocumentoRecibeVisitaChanged(this.documentoRecibeVisita);
}

class PerteneceResguardoChanged extends DimUbicacionEvent {
  final int perteneceResguardo;

  const PerteneceResguardoChanged(this.perteneceResguardo);
}

class ViaAccesoChanged extends DimUbicacionEvent {
  final int viaAccesoId;

  const ViaAccesoChanged(this.viaAccesoId);
}

class ResguardoChanged extends DimUbicacionEvent {
  final int resguardoId;

  const ResguardoChanged(this.resguardoId);
}

class AutoridadIndigenaChanged extends DimUbicacionEvent {
  final int autoridadIndigenaId;

  const AutoridadIndigenaChanged(this.autoridadIndigenaId);
}

class EstadoViaChanged extends DimUbicacionEvent {
  final int estadoViaId;

  const EstadoViaChanged(this.estadoViaId);
}

class MedioComunicacionChanged extends DimUbicacionEvent {
  final int medioComunicacionId;

  const MedioComunicacionChanged(this.medioComunicacionId);
}

class TiempoTardaChanged extends DimUbicacionEvent {
  final int tiempoTardaId;

  const TiempoTardaChanged(this.tiempoTardaId);
}

class MedioUtilizaChanged extends DimUbicacionEvent {
  final int medioUtilizaId;

  const MedioUtilizaChanged(this.medioUtilizaId);
}

class DificultaAccesoChanged extends DimUbicacionEvent {
  final int dificultaAccesoId;

  const DificultaAccesoChanged(this.dificultaAccesoId);
}

class CostoDesplazamientoChanged extends DimUbicacionEvent {
  final int costoDesplazamientoId;

  const CostoDesplazamientoChanged(this.costoDesplazamientoId);
}

class ExisteMedTradicionalComunidadChanged extends DimUbicacionEvent {
  final int existeMedTradicionalComunidad;

  const ExisteMedTradicionalComunidadChanged(
      this.existeMedTradicionalComunidad);
}

class EspecialidadMedTradChanged extends DimUbicacionEvent {
  final int especialidadMedTradId;

  const EspecialidadMedTradChanged(this.especialidadMedTradId);
}

class TiempoTardaMedTradChanged extends DimUbicacionEvent {
  final int tiempoTardaMedTradId;

  const TiempoTardaMedTradChanged(this.tiempoTardaMedTradId);
}

class MedioUtilizaMedTradChanged extends DimUbicacionEvent {
  final int medioUtilizaMedTradId;

  const MedioUtilizaMedTradChanged(this.medioUtilizaMedTradId);
}

class DificultadAccesoMedTradicionalChanged extends DimUbicacionEvent {
  final int dificultadAccesoMedTradicionalId;

  const DificultadAccesoMedTradicionalChanged(
      this.dificultadAccesoMedTradicionalId);
}

class CostoDesplazamientoMedTradicionalChanged extends DimUbicacionEvent {
  final int costoDesplazamientoMedTradicional;

  const CostoDesplazamientoMedTradicionalChanged(
      this.costoDesplazamientoMedTradicional);
}

class NombreMedTradicionalChanged extends DimUbicacionEvent {
  final String nombreMedTradicional;

  const NombreMedTradicionalChanged(this.nombreMedTradicional);
}

class PoseeChagraChanged extends DimUbicacionEvent {
  final int poseeChagra;

  const PoseeChagraChanged(this.poseeChagra);
}

class TuberculoPlatanoChanged extends DimUbicacionEvent {
  final int tuberculoPlatanoId;

  const TuberculoPlatanoChanged(this.tuberculoPlatanoId);
}

class LeguminosaChanged extends DimUbicacionEvent {
  final int leguminosaId;

  const LeguminosaChanged(this.leguminosaId);
}

class HortalizaChanged extends DimUbicacionEvent {
  final int hortalizaId;

  const HortalizaChanged(this.hortalizaId);
}

class VerduraChanged extends DimUbicacionEvent {
  final int verduraId;

  const VerduraChanged(this.verduraId);
}

class FrutoChanged extends DimUbicacionEvent {
  final int frutoId;

  const FrutoChanged(this.frutoId);
}

class CerealChanged extends DimUbicacionEvent {
  final int cerealId;

  const CerealChanged(this.cerealId);
}

class EspecieAnimalCriaChanged extends DimUbicacionEvent {
  final int especieAnimalCriaId;

  const EspecieAnimalCriaChanged(this.especieAnimalCriaId);
}

class ProduccionMineraChanged extends DimUbicacionEvent {
  final int produccionMineraId;

  const ProduccionMineraChanged(this.produccionMineraId);
}

class TipoCalendarioChanged extends DimUbicacionEvent {
  final int tipoCalendarioId;

  const TipoCalendarioChanged(this.tipoCalendarioId);
}
