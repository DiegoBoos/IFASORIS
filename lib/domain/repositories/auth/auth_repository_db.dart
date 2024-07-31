import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/usuario.dart';

abstract class AuthRepositoryDB {
  Future<Either<Failure, UsuarioEntity?>> logInRepositoryDB(
      UsuarioEntity usuario);

  Future<Either<Failure, int>> logOutUsecaseDB();
}
