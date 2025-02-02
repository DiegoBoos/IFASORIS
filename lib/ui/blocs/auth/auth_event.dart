part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LogIn extends AuthEvent {
  final UsuarioEntity usuario;

  const LogIn({required this.usuario});
}

class LogInDB extends AuthEvent {
  final UsuarioEntity usuario;
  const LogInDB({required this.usuario});
}

class CheckAuth extends AuthEvent {}

class LogOut extends AuthEvent {}

class ErrorMsg extends AuthEvent {
  final String message;
  const ErrorMsg(this.message);
}
