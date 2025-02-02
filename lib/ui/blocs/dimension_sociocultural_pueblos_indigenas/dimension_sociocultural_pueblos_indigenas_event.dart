part of 'dimension_sociocultural_pueblos_indigenas_bloc.dart';

abstract class DimensionSocioCulturalPueblosIndigenasEvent extends Equatable {
  const DimensionSocioCulturalPueblosIndigenasEvent();

  @override
  List<Object> get props => [];
}

class DimensionSocioCulturalPueblosIndigenasInit
    extends DimensionSocioCulturalPueblosIndigenasEvent {}

class DimensionSocioCulturalPueblosIndigenasSubmitted
    extends DimensionSocioCulturalPueblosIndigenasEvent {}

class GetDimensionSocioCulturalPueblosIndigenas
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int afiliadoId;

  const GetDimensionSocioCulturalPueblosIndigenas(this.afiliadoId);
}

class DimensionSocioCulturalPueblosIndigenasFormSubmissionSuccess
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int dimSocioCulturalPueblosIndigenasId;

  const DimensionSocioCulturalPueblosIndigenasFormSubmissionSuccess(
      this.dimSocioCulturalPueblosIndigenasId);
}

class DimensionSocioCulturalPueblosIndigenasFormSubmissionFailed
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final String message;

  const DimensionSocioCulturalPueblosIndigenasFormSubmissionFailed(
      this.message);
}

class DimensionSocioCulturalPueblosIndigenasChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int dimSocioCulturalPueblosIndigenasId;

  const DimensionSocioCulturalPueblosIndigenasChanged(
      this.dimSocioCulturalPueblosIndigenasId);
}

class AfiliadoChanged extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int afiliadoId;

  const AfiliadoChanged(this.afiliadoId);
}

class FamiliaChanged extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int familiaId;

  const FamiliaChanged(this.familiaId);
}

class ConoceUsosCostumbresChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int conoceUsosCostumbresId;

  const ConoceUsosCostumbresChanged(this.conoceUsosCostumbresId);
}

class EventoCostumbreParticipoChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int eventoCostumbreParticipoId;

  const EventoCostumbreParticipoChanged(this.eventoCostumbreParticipoId);
}

class CostumbrePracticaChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int costumbrePracticaId;

  const CostumbrePracticaChanged(this.costumbrePracticaId);
}

class JusticiaSancionaChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int sancionJusticiaId;

  const JusticiaSancionaChanged(this.sancionJusticiaId);
}

class SitioSagradoChanged extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int sitiosSagradosId;

  const SitioSagradoChanged(this.sitiosSagradosId);
}

class ReligionProfesaChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int religionProfesaId;

  const ReligionProfesaChanged(this.religionProfesaId);
}

class CualesUsosCostumbresChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final String cualesUsosCostumbres;

  const CualesUsosCostumbresChanged(this.cualesUsosCostumbres);
}

class ParticipaCostumbresChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int participaCostumbresId;

  const ParticipaCostumbresChanged(this.participaCostumbresId);
}

class GetEventosCostumbresParticipa
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int? dimSocioCulturalPueblosIndigenasId;

  const GetEventosCostumbresParticipa(this.dimSocioCulturalPueblosIndigenasId);
}

class EventosCostumbresParticipaChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa;

  const EventosCostumbresParticipaChanged(this.lstEventoCostumbreParticipa);
}

class SancionJusticiaChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final int sancionJusticiaId;

  const SancionJusticiaChanged(this.sancionJusticiaId);
}

class CualesSitiosSagradosChanged
    extends DimensionSocioCulturalPueblosIndigenasEvent {
  final String cualesSitiosSagrados;

  const CualesSitiosSagradosChanged(this.cualesSitiosSagrados);
}
