import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/usuario_entity.dart';
import '../../../domain/repositories/auth/auth_repository.dart';
import '../../datasources/remote/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UsuarioEntity>> logInRepository(
      UsuarioEntity usuario) async {
    try {
      final result = await authRemoteDataSource.logIn(usuario);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }

  @override
  Future<Either<Failure, String>> cambioDispositivoRepositoryDB(
      String userName, String idEquipo) async {
    try {
      final result =
          await authRemoteDataSource.cambioDispositivo(userName, idEquipo);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
