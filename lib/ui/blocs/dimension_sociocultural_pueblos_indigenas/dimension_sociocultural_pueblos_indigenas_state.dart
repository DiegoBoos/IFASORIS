part of 'dimension_sociocultural_pueblos_indigenas_bloc.dart';

abstract class DimensionSocioculturalPueblosIndigenasState {
  const DimensionSocioculturalPueblosIndigenasState();
}

class DimensionSocioculturalPueblosIndigenasFormInitial
    extends DimensionSocioculturalPueblosIndigenasState {
  const DimensionSocioculturalPueblosIndigenasFormInitial();
}

class DimensionSocioculturalPueblosIndigenasFormLoaded
    extends DimensionSocioculturalPueblosIndigenasState {}

class DimensionSocioculturalPueblosIndigenasFormEmpty
    extends DimensionSocioculturalPueblosIndigenasState {}

class DimensionSocioculturalPueblosIndigenasSubmissionSuccess
    extends DimensionSocioculturalPueblosIndigenasState {}

class DimensionSocioculturalPueblosIndigenasSubmissionFailed
    extends DimensionSocioculturalPueblosIndigenasState {
  final String message;

  DimensionSocioculturalPueblosIndigenasSubmissionFailed(this.message);
}

DimensionSocioculturalPueblosIndigenasEntity initObject() {
  return DimensionSocioculturalPueblosIndigenasEntity(
      formStatus: const DimensionSocioculturalPueblosIndigenasFormInitial());
}
