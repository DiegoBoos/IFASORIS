part of 'resguardo_cubit.dart';

abstract class ResguardosState extends Equatable {
  final List<ResguardoEntity>? resguardos;
  const ResguardosState({this.resguardos});

  @override
  List<Object> get props => [];
}

class ResguardosInitial extends ResguardosState {}

class ResguardosLoading extends ResguardosState {}

class ResguardosLoaded extends ResguardosState {
  final List<ResguardoEntity>? resguardosLoaded;

  const ResguardosLoaded(this.resguardosLoaded)
      : super(resguardos: resguardosLoaded);
}

class ResguardosError extends ResguardosState {
  final String message;

  const ResguardosError(this.message);
}
