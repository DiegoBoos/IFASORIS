part of 'medio_utiliza_med_tradicional_by_dpto_cubit.dart';

abstract class MediosUtilizaMedTradicionalByDptoState extends Equatable {
  final List<MedioUtilizaMedTradicionalEntity>?
      mediosUtilizaMedTradicionalByDpto;
  const MediosUtilizaMedTradicionalByDptoState(
      {this.mediosUtilizaMedTradicionalByDpto});

  @override
  List<Object> get props => [];
}

class MediosUtilizaMedTradicionalByDptoInitial
    extends MediosUtilizaMedTradicionalByDptoState {}

class MediosUtilizaMedTradicionalByDptoLoading
    extends MediosUtilizaMedTradicionalByDptoState {}

class MediosUtilizaMedTradicionalByDptoLoaded
    extends MediosUtilizaMedTradicionalByDptoState {
  final List<MedioUtilizaMedTradicionalEntity>?
      mediosUtilizaMedTradicionalByDptoLoaded;

  const MediosUtilizaMedTradicionalByDptoLoaded(
      this.mediosUtilizaMedTradicionalByDptoLoaded)
      : super(
            mediosUtilizaMedTradicionalByDpto:
                mediosUtilizaMedTradicionalByDptoLoaded);
}

class MediosUtilizaMedTradicionalByDptoError
    extends MediosUtilizaMedTradicionalByDptoState {
  final String message;

  const MediosUtilizaMedTradicionalByDptoError(this.message);
}
