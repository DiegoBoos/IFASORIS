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

class LoadAfiliado extends AfiliadoPrefsEvent {
  final String? username;

  const LoadAfiliado({this.username});
}

class DeleteAfiliado extends AfiliadoPrefsEvent {}

class AfiliadoPrefsErrorMsg extends AfiliadoPrefsEvent {
  final String message;

  const AfiliadoPrefsErrorMsg(this.message);
}
