import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/usuario_entity.dart';
import '../../repositories/auth/auth_repository_db.dart';

class AuthUsecaseDB {
  final AuthRepositoryDB repositoryDB;

  AuthUsecaseDB(this.repositoryDB);

  Future<Either<Failure, UsuarioEntity?>> logInUsecaseDB(
      UsuarioEntity usuario) {
    return repositoryDB.logInRepositoryDB(usuario);
  }

  Future<Either<Failure, int>> logOutUsecaseDB() {
    return repositoryDB.logOutUsecaseDB();
  }
}
