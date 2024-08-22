import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifasoris/services/shared_preferences_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/entities/usuario.dart';
import '../../../domain/usecases/auth/auth_db_usecase.dart';
import '../../../domain/usecases/auth/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  final AuthUsecase auth;
  final AuthUsecaseDB authDB;

  final prefs = SharedPreferencesService();

  AuthBloc({
    required this.auth,
    required this.authDB,
  }) : super(AuthInitial()) {
    on<LogIn>((event, emit) async {
      emit(AuthLoading());
      final usuario = event.usuario;

      final result = await auth.logInUsecase(usuario);
      result.fold((failure) {
        emit(AuthError(failure.properties.first));
      }, (data) {
        emit(AuthLoaded(data));
      });
    });

    on<Register>((event, emit) async {
      emit(AuthLoading());
      final result = await auth.registerUsecase(event.usuario);
      result.fold((failure) {
        emit(AuthError(failure.properties.first));
      }, (data) {
        emit(Registered(data));
      });
    });

    on<LogOut>((_, emit) async {
      final result = await authDB.logOutUsecaseDB();
      result.fold((failure) {
        emit(AuthError(failure.properties.first));
      }, (data) {
        emit(LoggedOut());
      });
    });
  }

  Future<String> cambioDispositivo(String userName, String idEquipo) async {
    final result = await auth.cambioDispositivoUsecaseDB(userName, idEquipo);
    return result.fold((failure) => '', (data) => data);
  }
}
