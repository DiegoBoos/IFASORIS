part of 'regimen_cubit.dart';

abstract class RegimenesState extends Equatable {
  final List<RegimenEntity>? regimenes;
  const RegimenesState({this.regimenes});

  @override
  List<Object> get props => [];
}

class RegimenesInitial extends RegimenesState {}

class RegimenesLoading extends RegimenesState {}

class RegimenesLoaded extends RegimenesState {
  final List<RegimenEntity>? regimenesLoaded;

  const RegimenesLoaded(this.regimenesLoaded)
      : super(regimenes: regimenesLoaded);
}

class RegimenesError extends RegimenesState {
  final String message;

  const RegimenesError(this.message);
}
