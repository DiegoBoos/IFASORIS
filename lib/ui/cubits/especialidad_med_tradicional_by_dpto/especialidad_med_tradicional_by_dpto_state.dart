part of 'especialidad_med_tradicional_by_dpto_cubit.dart';

abstract class EspecialidadesMedTradicionalByDptoState extends Equatable {
  final List<EspecialidadMedTradicionalEntity>?
      especialidadesMedtradicionalByDpto;
  const EspecialidadesMedTradicionalByDptoState(
      {this.especialidadesMedtradicionalByDpto});

  @override
  List<Object> get props => [];
}

class EspecialidadesMedTradicionalByDptoInitial
    extends EspecialidadesMedTradicionalByDptoState {}

class EspecialidadesMedTradicionalByDptoLoading
    extends EspecialidadesMedTradicionalByDptoState {}

class EspecialidadesMedTradicionalByDptoLoaded
    extends EspecialidadesMedTradicionalByDptoState {
  final List<EspecialidadMedTradicionalEntity>?
      especialidadesMedtradicionalByDptoLoaded;

  const EspecialidadesMedTradicionalByDptoLoaded(
      this.especialidadesMedtradicionalByDptoLoaded)
      : super(
            especialidadesMedtradicionalByDpto:
                especialidadesMedtradicionalByDptoLoaded);
}

class EspecialidadesMedTradicionalByDptoError
    extends EspecialidadesMedTradicionalByDptoState {
  final String message;

  const EspecialidadesMedTradicionalByDptoError(this.message);
}
