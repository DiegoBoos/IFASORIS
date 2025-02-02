import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

import '../../../data/models/usuario.dart';
import '../../entities/usuario.dart';
import '../../repositories/auth/auth_repository_db.dart';

class AuthUsecaseDB {
  final AuthRepositoryDB repositoryDB;

  AuthUsecaseDB(this.repositoryDB);

  Future<Either<Failure, UsuarioEntity?>> logInUsecaseDB(UsuarioModel usuario) {
    return repositoryDB.logInRepositoryDB(usuario);
  }

  Future<Either<Failure, int>> logOutUsecaseDB() {
    return repositoryDB.logOutUsecaseDB();
  }

  Future<Either<Failure, UsuarioEntity?>> getUsuario() {
    return repositoryDB.getUsuario();
  }
}
