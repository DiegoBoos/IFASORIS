part of 'dim_ubicacion_bloc.dart';

abstract class DimUbicacionEvent extends Equatable {
  const DimUbicacionEvent();

  @override
  List<Object> get props => [];
}

class DimUbicacionInit extends DimUbicacionEvent {}

class DimUbicacionSubmitted extends DimUbicacionEvent {}

class GetDimUbicacion extends DimUbicacionEvent {
  final int afiliadoId;
  final int familiaId;

  const GetDimUbicacion(this.afiliadoId, this.familiaId);
}

class GetDificultadesAcceso extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetDificultadesAcceso(this.ubicacionId);
}

class GetEspecialidadesMedTradicional extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetEspecialidadesMedTradicional(this.ubicacionId);
}

class GetNombresMedTrad extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetNombresMedTrad(this.ubicacionId);
}

class GetMediosUtilizaMedTradicional extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetMediosUtilizaMedTradicional(this.ubicacionId);
}

class GetDificultadesAccesoMedTradicional extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetDificultadesAccesoMedTradicional(this.ubicacionId);
}

class GetTuberculosPlatanos extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetTuberculosPlatanos(this.ubicacionId);
}

class GetLeguminosas extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetLeguminosas(this.ubicacionId);
}

class GetHortalizas extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetHortalizas(this.ubicacionId);
}

class GetVerduras extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetVerduras(this.ubicacionId);
}

class GetFrutos extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetFrutos(this.ubicacionId);
}

class GetCereales extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetCereales(this.ubicacionId);
}

class GetEspeciesAnimales extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetEspeciesAnimales(this.ubicacionId);
}

class GetMediosComunicacion extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetMediosComunicacion(this.ubicacionId);
}

class GetMediosUtilizaCA extends DimUbicacionEvent {
  final int? ubicacionId;

  const GetMediosUtilizaCA(this.ubicacionId);
}

class DimUbicacionFormSubmissionSuccess extends DimUbicacionEvent {
  final int ubicacionId;

  const DimUbicacionFormSubmissionSuccess(this.ubicacionId);
}

class DimUbicacionFormSubmissionFailed extends DimUbicacionEvent {
  final String message;

  const DimUbicacionFormSubmissionFailed(this.message);
}

class UbicacionChanged extends DimUbicacionEvent {
  final int ubicacionId;

  const UbicacionChanged(this.ubicacionId);
}

class DimUbicacionAfiliadoChanged extends DimUbicacionEvent {
  final int afiliadoId;

  const DimUbicacionAfiliadoChanged(this.afiliadoId);
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
  final List<LstMediosComunica> lstMediosComunica;

  const MediosComunicacionChanged(this.lstMediosComunica);
}

class MediosUtilizaCAChanged extends DimUbicacionEvent {
  final List<LstMediosUtilizaCA> lstMediosUtilizaCA;

  const MediosUtilizaCAChanged(this.lstMediosUtilizaCA);
}

class TiempoTardaChanged extends DimUbicacionEvent {
  final int tiempoTardaId;

  const TiempoTardaChanged(this.tiempoTardaId);
}

class DificultadesAccesoCAChanged extends DimUbicacionEvent {
  final List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion;

  const DificultadesAccesoCAChanged(this.lstDificultadAccesoAtencion);
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
  final List<LstEspMedTradicional> lstEspMedTradicional;

  const EspecialidadesMedTradChanged(this.lstEspMedTradicional);
}

class TiempoTardaMedTradChanged extends DimUbicacionEvent {
  final int tiempoTardaMedTradId;

  const TiempoTardaMedTradChanged(this.tiempoTardaMedTradId);
}

class MediosUtilizaMedTradChanged extends DimUbicacionEvent {
  final List<LstMediosMedTradicional> lstMediosMedTradicional;

  const MediosUtilizaMedTradChanged(this.lstMediosMedTradicional);
}

class DificultadesAccesoMedTradicionalChanged extends DimUbicacionEvent {
  final List<LstDificultadAccesoMedTradicional>
      lstDificultadAccesoMedTradicional;

  const DificultadesAccesoMedTradicionalChanged(
      this.lstDificultadAccesoMedTradicional);
}

class CostoDesplazamientoMedTradicionalChanged extends DimUbicacionEvent {
  final int costoDesplazamientoMedTradicional;

  const CostoDesplazamientoMedTradicionalChanged(
      this.costoDesplazamientoMedTradicional);
}

class NombresMedTradicionalChanged extends DimUbicacionEvent {
  final List<LstNombreMedTradicional> lstNombreMedTradicional;

  const NombresMedTradicionalChanged(this.lstNombreMedTradicional);
}

class PoseeChagraChanged extends DimUbicacionEvent {
  final int poseeChagra;

  const PoseeChagraChanged(this.poseeChagra);
}

class TuberculosPlatanosChanged extends DimUbicacionEvent {
  final List<LstTuberculo> lstTuberculos;

  const TuberculosPlatanosChanged(this.lstTuberculos);
}

class LeguminosasChanged extends DimUbicacionEvent {
  final List<LstLeguminosa> lstLeguminosas;

  const LeguminosasChanged(this.lstLeguminosas);
}

class HortalizasChanged extends DimUbicacionEvent {
  final List<LstHortaliza> lstHortalizas;

  const HortalizasChanged(this.lstHortalizas);
}

class VerdurasChanged extends DimUbicacionEvent {
  final List<LstVerdura> lstVerduras;

  const VerdurasChanged(this.lstVerduras);
}

class FrutosChanged extends DimUbicacionEvent {
  final List<LstFruto> lstFrutos;

  const FrutosChanged(this.lstFrutos);
}

class CerealesChanged extends DimUbicacionEvent {
  final List<LstCereal> lstCereales;

  const CerealesChanged(this.lstCereales);
}

class EspeciesAnimalesCriaChanged extends DimUbicacionEvent {
  final List<LstAnimalCria> lstAnimalCria;

  const EspeciesAnimalesCriaChanged(this.lstAnimalCria);
}

class ProduccionMineraChanged extends DimUbicacionEvent {
  final int produccionMineraId;

  const ProduccionMineraChanged(this.produccionMineraId);
}

class TipoCalendarioChanged extends DimUbicacionEvent {
  final int tipoCalendarioId;

  const TipoCalendarioChanged(this.tipoCalendarioId);
}
