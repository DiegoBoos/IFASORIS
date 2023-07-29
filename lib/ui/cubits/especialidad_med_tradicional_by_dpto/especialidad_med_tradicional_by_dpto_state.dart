part of 'especialidad_med_tradicional_by_dpto_cubit.dart';

abstract class EspecialidadesMedTradicionalState extends Equatable {
  final List<EspecialidadMedTradicionalEntity>? especialidadesMedTradicional;
  const EspecialidadesMedTradicionalState({this.especialidadesMedTradicional});

  @override
  List<Object> get props => [];
}

class EspecialidadesMedTradicionalInitial
    extends EspecialidadesMedTradicionalState {}

class EspecialidadesMedTradicionalLoading
    extends EspecialidadesMedTradicionalState {}

class EspecialidadesMedTradicionalLoaded
    extends EspecialidadesMedTradicionalState {
  final List<EspecialidadMedTradicionalEntity>?
      especialidadesMedTradicionalLoaded;

  const EspecialidadesMedTradicionalLoaded(
      this.especialidadesMedTradicionalLoaded)
      : super(especialidadesMedTradicional: especialidadesMedTradicionalLoaded);
}

class EspecialidadesMedTradicionalError
    extends EspecialidadesMedTradicionalState {
  final String message;

  const EspecialidadesMedTradicionalError(this.message);
}
