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

class MediosComunicacionChanged extends DimUbicacionEvent {
  final List<int> mediosComunicacionIds;

  const MediosComunicacionChanged(this.mediosComunicacionIds);
}

class TiempoTardaChanged extends DimUbicacionEvent {
  final int tiempoTardaId;

  const TiempoTardaChanged(this.tiempoTardaId);
}

class MediosUtilizaCAChanged extends DimUbicacionEvent {
  final List<int> mediosUtilizaIds;

  const MediosUtilizaCAChanged(this.mediosUtilizaIds);
}

class DificultadesAccesoCAChanged extends DimUbicacionEvent {
  final List<int> dificultadesAccesoIds;

  const DificultadesAccesoCAChanged(this.dificultadesAccesoIds);
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

class EspecialidadesMedTradChanged extends DimUbicacionEvent {
  final List<int> especialidadesMedTradIds;

  const EspecialidadesMedTradChanged(this.especialidadesMedTradIds);
}

class TiempoTardaMedTradChanged extends DimUbicacionEvent {
  final int tiempoTardaMedTradId;

  const TiempoTardaMedTradChanged(this.tiempoTardaMedTradId);
}

class MediosUtilizaMedTradChanged extends DimUbicacionEvent {
  final List<int> mediosUtilizaMedTradIds;

  const MediosUtilizaMedTradChanged(this.mediosUtilizaMedTradIds);
}

class DificultadesAccesoMedTradicionalChanged extends DimUbicacionEvent {
  final List<int> dificultadesAccesoMedTradIds;

  const DificultadesAccesoMedTradicionalChanged(
      this.dificultadesAccesoMedTradIds);
}

class CostoDesplazamientoMedTradicionalChanged extends DimUbicacionEvent {
  final int costoDesplazamientoMedTradicional;

  const CostoDesplazamientoMedTradicionalChanged(
      this.costoDesplazamientoMedTradicional);
}

class NombresMedTradicionalChanged extends DimUbicacionEvent {
  final List<String> nombresMedTradicional;

  const NombresMedTradicionalChanged(this.nombresMedTradicional);
}

class PoseeChagraChanged extends DimUbicacionEvent {
  final int poseeChagra;

  const PoseeChagraChanged(this.poseeChagra);
}

class TuberculosPlatanosChanged extends DimUbicacionEvent {
  final List<int> tuberculosPlatanosIds;

  const TuberculosPlatanosChanged(this.tuberculosPlatanosIds);
}

class LeguminosasChanged extends DimUbicacionEvent {
  final List<int> leguminosasIds;

  const LeguminosasChanged(this.leguminosasIds);
}

class HortalizasChanged extends DimUbicacionEvent {
  final List<int> hortalizasIds;

  const HortalizasChanged(this.hortalizasIds);
}

class VerdurasChanged extends DimUbicacionEvent {
  final List<int> verdurasIds;

  const VerdurasChanged(this.verdurasIds);
}

class FrutosChanged extends DimUbicacionEvent {
  final List<int> frutosIds;

  const FrutosChanged(this.frutosIds);
}

class CerealesChanged extends DimUbicacionEvent {
  final List<int> cerealesIds;

  const CerealesChanged(this.cerealesIds);
}

class EspeciesAnimalesCriaChanged extends DimUbicacionEvent {
  final List<int> especiesAnimalesCriaIds;

  const EspeciesAnimalesCriaChanged(this.especiesAnimalesCriaIds);
}

class ProduccionMineraChanged extends DimUbicacionEvent {
  final int produccionMineraId;

  const ProduccionMineraChanged(this.produccionMineraId);
}

class TiposCalendariosChanged extends DimUbicacionEvent {
  final List<int> tiposCalendariosIds;

  const TiposCalendariosChanged(this.tiposCalendariosIds);
}
