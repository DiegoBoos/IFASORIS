import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/usuario.dart';
import '../../../domain/repositories/auth/auth_repository_db.dart';
import '../../datasources/local/auth_local_ds.dart';
import '../../models/usuario.dart';

class AuthRepositoryDBImpl implements AuthRepositoryDB {
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryDBImpl({required this.authLocalDataSource});

  @override
  Future<Either<Failure, UsuarioModel?>> logInRepositoryDB(
      UsuarioEntity usuario) async {
    try {
      final usuarioModel = UsuarioModel.fromEntity(usuario);
      final result = await authLocalDataSource.logIn(usuarioModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> logOutUsecaseDB() async {
    try {
      final result = await authLocalDataSource.logOut();

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, UsuarioModel?>> getUsuario() async {
    try {
      final result = await authLocalDataSource.getUsuario();

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
