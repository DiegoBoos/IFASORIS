part of 'afiliado_prefs_bloc.dart';

abstract class AfiliadoPrefsState extends Equatable {
  final AfiliadoEntity? afiliado;

  const AfiliadoPrefsState({this.afiliado});

  @override
  List<Object?> get props => [afiliado];
}

class AfiliadoPrefsInitial extends AfiliadoPrefsState {}

class AfiliadoPrefsLoaded extends AfiliadoPrefsState {
  final AfiliadoEntity? afiliadoLoaded;

  const AfiliadoPrefsLoaded(this.afiliadoLoaded)
      : super(afiliado: afiliadoLoaded);
}

class AfiliadoPrefsDeleted extends AfiliadoPrefsState {}

class AfiliadoPrefsError extends AfiliadoPrefsState {
  final String message;

  const AfiliadoPrefsError(this.message);
}
