import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/usecases/auth/auth_db_usecase.dart';
import '../../../domain/usecases/auth/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase auth;
  final AuthUsecaseDB authDB;

  AuthBloc({
    required this.auth,
    required this.authDB,
  }) : super(AuthInitial()) {
    on<LogIn>((event, emit) async {
      emit(AuthLoading());
      await _logIn(event, emit);
    });

    on<LogInDB>((event, emit) async {
      emit(AuthLoading());
      await _logInDB(event, emit);
    });

    on<LogOut>((_, emit) async {
      emit(AuthInitial());
      await _logOut(emit);
    });
  }

  _logIn(event, emit) async {
    final usuario = event.usuario;

    final result = await auth.logInUsecase(usuario);
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) {
      emit(AuthLoaded(data));
    });
  }

  _logInDB(event, emit) async {
    final checkToken = await _checkToken();
    if (checkToken != null) {
      final usuario = event.usuario;

      final result = await authDB.logInUsecaseDB(usuario);
      result.fold((failure) {
        emit(AuthError(failure.properties.first));
      }, (data) {
        if (data == null) {
          emit(const AuthError('Usuario no autenticado'));
        } else {
          emit(AuthLoaded(data));
        }
      });
    } else {
      emit(const AuthError(
          'No existen datos, inicie sesión con una conexión a internet'));
    }
  }

  Future<UsuarioEntity?> _checkToken() async {
    final result = await authDB.checkTokenUsecaseDB();
    return result.fold((failure) {
      return failure.properties.first;
    }, (data) {
      if (data == null) {
        return null;
      }
      return data;
    });
  }

  _logOut(Emitter<AuthState> emit) async {
    final result = await authDB.logOutUsecaseDB();
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) {
      emit(AuthInitial());
    });
  }
}
