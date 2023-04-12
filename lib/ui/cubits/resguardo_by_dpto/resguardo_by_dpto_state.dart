part of 'resguardo_by_dpto_cubit.dart';

abstract class ResguardosByDptoState extends Equatable {
  final List<ResguardoEntity>? resguardosByDpto;
  const ResguardosByDptoState({this.resguardosByDpto});

  @override
  List<Object> get props => [];
}

class ResguardosByDptoInitial extends ResguardosByDptoState {}

class ResguardosByDptoLoading extends ResguardosByDptoState {}

class ResguardosByDptoLoaded extends ResguardosByDptoState {
  final List<ResguardoEntity>? resguardosByDptoLoaded;

  const ResguardosByDptoLoaded(this.resguardosByDptoLoaded)
      : super(resguardosByDpto: resguardosByDptoLoaded);
}

class ResguardosByDptoError extends ResguardosByDptoState {
  final String message;

  const ResguardosByDptoError(this.message);
}
