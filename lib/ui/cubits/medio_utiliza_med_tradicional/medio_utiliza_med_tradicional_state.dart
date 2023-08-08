part of 'medio_utiliza_med_tradicional_cubit.dart';

abstract class MediosUtilizaMedTradicionalState extends Equatable {
  final List<MedioUtilizaMedTradicionalEntity>? mediosUtilizaMedTradicional;
  const MediosUtilizaMedTradicionalState({this.mediosUtilizaMedTradicional});

  @override
  List<Object> get props => [];
}

class MediosUtilizaMedTradicionalInitial
    extends MediosUtilizaMedTradicionalState {}

class MediosUtilizaMedTradicionalLoading
    extends MediosUtilizaMedTradicionalState {}

class MediosUtilizaMedTradicionalLoaded
    extends MediosUtilizaMedTradicionalState {
  final List<MedioUtilizaMedTradicionalEntity>?
      mediosUtilizaMedTradicionalLoaded;

  const MediosUtilizaMedTradicionalLoaded(
      this.mediosUtilizaMedTradicionalLoaded)
      : super(mediosUtilizaMedTradicional: mediosUtilizaMedTradicionalLoaded);
}

class MediosUtilizaMedTradicionalError
    extends MediosUtilizaMedTradicionalState {
  final String message;

  const MediosUtilizaMedTradicionalError(this.message);
}
