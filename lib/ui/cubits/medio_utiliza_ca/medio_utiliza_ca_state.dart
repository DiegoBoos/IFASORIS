part of 'medio_utiliza_ca_cubit.dart';

abstract class MediosUtilizaCAState extends Equatable {
  final List<MedioUtilizaCAEntity>? mediosUtilizaCA;
  const MediosUtilizaCAState({this.mediosUtilizaCA});

  @override
  List<Object> get props => [];
}

class MediosUtilizaCAInitial extends MediosUtilizaCAState {}

class MediosUtilizaCALoading extends MediosUtilizaCAState {}

class MediosUtilizaCALoaded extends MediosUtilizaCAState {
  final List<MedioUtilizaCAEntity>? mediosUtilizaCALoaded;

  const MediosUtilizaCALoaded(this.mediosUtilizaCALoaded)
      : super(mediosUtilizaCA: mediosUtilizaCALoaded);
}

class MediosUtilizaCAError extends MediosUtilizaCAState {
  final String message;

  const MediosUtilizaCAError(this.message);
}
