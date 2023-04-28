part of 'afiliado_prefs_bloc.dart';

abstract class AfiliadoPrefsState extends Equatable {
  final AfiliadoEntity? afiliado;

  const AfiliadoPrefsState({this.afiliado});

  @override
  List<Object?> get props => [afiliado];
}

class AfiliadoInitial extends AfiliadoPrefsState {}

class AfiliadoLoaded extends AfiliadoPrefsState {
  final AfiliadoEntity? afiliadoLoaded;

  const AfiliadoLoaded(this.afiliadoLoaded) : super(afiliado: afiliadoLoaded);
}

class AfiliadoDeleted extends AfiliadoPrefsState {}

class AfiliadoError extends AfiliadoPrefsState {
  final String message;

  const AfiliadoError(this.message);
}
