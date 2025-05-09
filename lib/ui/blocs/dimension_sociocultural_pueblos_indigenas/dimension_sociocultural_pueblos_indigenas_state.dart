part of 'dimension_sociocultural_pueblos_indigenas_bloc.dart';

abstract class DimensionSocioCulturalPueblosIndigenasState {
  const DimensionSocioCulturalPueblosIndigenasState();
}

class DimensionSocioCulturalPueblosIndigenasFormInitial
    extends DimensionSocioCulturalPueblosIndigenasState {
  const DimensionSocioCulturalPueblosIndigenasFormInitial();
}

class DimensionSocioCulturalPueblosIndigenasFormLoaded
    extends DimensionSocioCulturalPueblosIndigenasState {}

class DimensionSocioCulturalPueblosIndigenasFormEmpty
    extends DimensionSocioCulturalPueblosIndigenasState {}

class DimensionSocioCulturalPueblosIndigenasSubmissionSuccess
    extends DimensionSocioCulturalPueblosIndigenasState {}

class DimensionSocioCulturalPueblosIndigenasSubmissionFailed
    extends DimensionSocioCulturalPueblosIndigenasState {
  final String message;

  DimensionSocioCulturalPueblosIndigenasSubmissionFailed(this.message);
}

DimensionSocioCulturalPueblosIndigenasEntity initObject() {
  return DimensionSocioCulturalPueblosIndigenasEntity(
      formStatus: const DimensionSocioCulturalPueblosIndigenasFormInitial());
}
