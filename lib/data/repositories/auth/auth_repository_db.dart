import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/auth/auth_repository_db.dart';
import '../../datasources/local/auth_local_ds.dart';

class AuthRepositoryDBImpl implements AuthRepositoryDB {
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryDBImpl({required this.authLocalDataSource});

  @override
  Future<Either<Failure, UsuarioEntity?>> logInRepositoryDB(
      UsuarioEntity usuario) async {
    try {
      final result = await authLocalDataSource.logIn(usuario);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> logOutUsecaseDB() async {
    try {
      final result = await authLocalDataSource.logOut();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
