part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final UsuarioEntity? usuario;

  const AuthState({this.usuario});

  @override
  List<Object?> get props => [usuario];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final UsuarioEntity? usuarioAutenticado;

  const AuthLoaded(this.usuarioAutenticado)
      : super(
          usuario: usuarioAutenticado,
        );

  @override
  List<Object?> get props => [usuarioAutenticado];
}

class AuthAPILoaded extends AuthState {
  final Map<String, dynamic>? sessionDetails;

  const AuthAPILoaded(this.sessionDetails);

  @override
  List<Object?> get props => [sessionDetails];
}

class LoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
