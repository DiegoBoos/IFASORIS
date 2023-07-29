part of 'dimension_sociocultural_pueblos_indigenas_bloc.dart';

abstract class DimensionSocioculturalPueblosIndigenasEvent extends Equatable {
  const DimensionSocioculturalPueblosIndigenasEvent();

  @override
  List<Object> get props => [];
}

class DimensionSocioculturalPueblosIndigenasInit
    extends DimensionSocioculturalPueblosIndigenasEvent {}

class DimensionSocioculturalPueblosIndigenasSubmitted
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final DimensionSocioculturalPueblosIndigenasEntity
      dimensionSocioculturalPueblosIndigenas;

  const DimensionSocioculturalPueblosIndigenasSubmitted(
      this.dimensionSocioculturalPueblosIndigenas);
}

class GetDimensionSocioculturalPueblosIndigenas
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int afiliadoId;

  const GetDimensionSocioculturalPueblosIndigenas(this.afiliadoId);
}

class DimensionSocioculturalPueblosIndigenasFormSubmissionSuccess
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int ubicacionId;

  const DimensionSocioculturalPueblosIndigenasFormSubmissionSuccess(
      this.ubicacionId);
}

class DimensionSocioculturalPueblosIndigenasFormSubmissionFailed
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final String message;

  const DimensionSocioculturalPueblosIndigenasFormSubmissionFailed(
      this.message);
}

class DimensionSocioculturalPuebloIndigenaChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int dimensionSocioculturalPueblosIndigenasId;

  const DimensionSocioculturalPuebloIndigenaChanged(
      this.dimensionSocioculturalPueblosIndigenasId);
}

class AfiliadoChanged extends DimensionSocioculturalPueblosIndigenasEvent {
  final int afiliadoId;

  const AfiliadoChanged(this.afiliadoId);
}

class FamiliaChanged extends DimensionSocioculturalPueblosIndigenasEvent {
  final int familiaId;

  const FamiliaChanged(this.familiaId);
}

class ConoceUsosCostumbresChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int conoceUsosCostumbresId;

  const ConoceUsosCostumbresChanged(this.conoceUsosCostumbresId);
}

class EventoCostumbreParticipoChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int eventoCostumbreParticipoId;

  const EventoCostumbreParticipoChanged(this.eventoCostumbreParticipoId);
}

class CostumbrePracticaChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int costumbrePracticaId;

  const CostumbrePracticaChanged(this.costumbrePracticaId);
}

class JusticiaSancionaChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int sancionJusticiaId;

  const JusticiaSancionaChanged(this.sancionJusticiaId);
}

class SitioSagradoChanged extends DimensionSocioculturalPueblosIndigenasEvent {
  final int sitiosSagradosId;

  const SitioSagradoChanged(this.sitiosSagradosId);
}

class ReligionProfesaChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int religionProfesaId;

  const ReligionProfesaChanged(this.religionProfesaId);
}

class CualesUsosCostumbresChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final String cualesUsosCostumbres;

  const CualesUsosCostumbresChanged(this.cualesUsosCostumbres);
}

class ParticipaCostumbresChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int participaCostumbresId;

  const ParticipaCostumbresChanged(this.participaCostumbresId);
}

class EventosCostumbresParticipaChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa;

  const EventosCostumbresParticipaChanged(this.lstEventoCostumbreParticipa);
}

class SancionJusticiaChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final int sancionJusticiaId;

  const SancionJusticiaChanged(this.sancionJusticiaId);
}

class CualesSitiosSagradosChanged
    extends DimensionSocioculturalPueblosIndigenasEvent {
  final String cualesSitiosSagrados;

  const CualesSitiosSagradosChanged(this.cualesSitiosSagrados);
}
