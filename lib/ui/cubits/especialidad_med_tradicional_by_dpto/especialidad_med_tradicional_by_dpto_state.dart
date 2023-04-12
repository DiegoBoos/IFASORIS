part of 'especialidad_med_tradicional_by_dpto_cubit.dart';

abstract class EspecialidadesMedTradicionalByDptoState extends Equatable {
  final List<EspecialidadMedTradicionalEntity>?
      especialidadesmedtradicionalByDpto;
  const EspecialidadesMedTradicionalByDptoState(
      {this.especialidadesmedtradicionalByDpto});

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
      especialidadesmedtradicionalByDptoLoaded;

  const EspecialidadesMedTradicionalByDptoLoaded(
      this.especialidadesmedtradicionalByDptoLoaded)
      : super(
            especialidadesmedtradicionalByDpto:
                especialidadesmedtradicionalByDptoLoaded);
}

class EspecialidadesMedTradicionalByDptoError
    extends EspecialidadesMedTradicionalByDptoState {
  final String message;

  const EspecialidadesMedTradicionalByDptoError(this.message);
}
