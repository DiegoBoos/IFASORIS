part of 'afiliado_prefs_bloc.dart';

abstract class AfiliadoPrefsEvent extends Equatable {
  const AfiliadoPrefsEvent();

  @override
  List<Object> get props => [];
}

class SaveAfiliado extends AfiliadoPrefsEvent {
  final AfiliadoEntity afiliado;

  const SaveAfiliado(this.afiliado);
}

class LoadAfiliado extends AfiliadoPrefsEvent {}

class DeleteAfiliado extends AfiliadoPrefsEvent {}

class AfiliadoPrefsError extends AfiliadoPrefsEvent {
  final String message;

  const AfiliadoPrefsError(this.message);
}
