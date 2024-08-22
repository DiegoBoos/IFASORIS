import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/error/failure.dart';
import '../../entities/usuario.dart';
import '../../repositories/auth/auth_repository.dart';

class AuthUsecase {
  final AuthRepository repository;

  AuthUsecase(this.repository);

  Future<Either<Failure, User>> logInUsecase(UsuarioEntity usuario) {
    return repository.logInRepository(usuario);
  }

  Future<Either<Failure, User>> registerUsecase(UsuarioEntity usuario) {
    return repository.registerRepository(usuario);
  }

  Future<Either<Failure, String>> cambioDispositivoUsecaseDB(
      String userName, String idEquipo) {
    return repository.cambioDispositivoRepositoryDB(userName, idEquipo);
  }
}
