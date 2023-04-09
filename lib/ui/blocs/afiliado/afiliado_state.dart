part of 'afiliado_bloc.dart';

abstract class AfiliadosState extends Equatable {
  final List<AfiliadoEntity>? afiliados;

  const AfiliadosState({this.afiliados});

  @override
  List<Object> get props => [];
}

class AfiliadosInitial extends AfiliadosState {
  AfiliadosInitial() : super(afiliados: []);
}

class AfiliadosLoading extends AfiliadosState {}

class AfiliadosLoaded extends AfiliadosState {
  final List<AfiliadoEntity>? afiliadosLoaded;

  const AfiliadosLoaded({this.afiliadosLoaded})
      : super(afiliados: afiliadosLoaded);
}

class AfiliadosError extends AfiliadosState {
  final String message;

  AfiliadosError(this.message) : super(afiliados: []);
}
