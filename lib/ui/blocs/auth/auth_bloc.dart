import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/data/models/usuario.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';

import '../../../domain/entities/usuario.dart';
import '../../../domain/usecases/auth/auth_db_usecase.dart';
import '../../../domain/usecases/auth/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase auth;
  final AuthUsecaseDB authDB;

  final SharedPreferencesService prefs;

  AuthBloc({
    required this.auth,
    required this.authDB,
    required this.prefs,
  }) : super(AuthInitial()) {
    on<LogIn>((event, emit) async {
      emit(AuthLoading());
      await _logIn(event, emit);
    });

    on<LogInDB>((event, emit) async {
      emit(AuthLoading());
      await _logInDB(event, emit);
    });

    on<CheckAuth>((event, emit) async {
      emit(AuthLoading());
      final usuario = await authDB.getUsuario();
      usuario.fold((failure) {
        emit(AuthError(failure.properties.first));
      }, (data) {
        if (data == null) {
          emit(const AuthError('Usuario no autenticado'));
        } else {
          emit(AuthLoaded(data));
        }
      });
    });

    on<LogOut>((_, emit) async {
      await _logOut(emit);
    });

    on<ErrorMsg>((event, emit) {
      emit(AuthError(event.message));
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
    final token = prefs.token;
    if (token.isNotEmpty) {
      await authenticateUser(event.usuario, emit);
    } else {
      emit(const AuthError(
          'No existen datos, inicie sesión con una conexión a internet'));
    }
  }

  _logOut(Emitter<AuthState> emit) async {
    final result = await authDB.logOutUsecaseDB();
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) {
      emit(AuthInitial());
    });
  }

  Future<String> cambioDispositivo(String userName, String idEquipo) async {
    final result = await auth.cambioDispositivoUsecaseDB(userName, idEquipo);
    return result.fold((failure) => '', (data) => data);
  }

  Future<void> authenticateUser(
      UsuarioEntity usuario, Emitter<AuthState> emit) async {
    final result = await authDB.logInUsecaseDB(UsuarioModel(
        userName: usuario.userName,
        password: usuario.password,
        deviceId: usuario.deviceId));
    result.fold((failure) {
      emit(AuthError(failure.properties.first));
    }, (data) {
      if (data == null) {
        emit(const AuthError('Usuario no autenticado'));
      } else {
        emit(AuthLoaded(data));
      }
    });
  }
}
