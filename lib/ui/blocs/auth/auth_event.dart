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

class Register extends AuthEvent {
  final UsuarioEntity usuario;

  const Register({required this.usuario});
}

class LogInDB extends AuthEvent {
  final UsuarioEntity usuario;

  const LogInDB({required this.usuario});
}

class LogOut extends AuthEvent {}
