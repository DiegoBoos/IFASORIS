part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final User? loggedUser;

  const AuthenticationState({this.loggedUser});

  @override
  List<Object?> get props => [loggedUser];
}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthLoaded extends AuthenticationState {
  final User? currentUser;

  const AuthLoaded(this.currentUser)
      : super(
          loggedUser: currentUser,
        );

  @override
  List<Object?> get props => [currentUser];
}

class Registered extends AuthenticationState {
  final User user;

  const Registered(this.user);

  @override
  List<Object?> get props => [user];
}

class LoggedOut extends AuthenticationState {}

class AuthError extends AuthenticationState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
